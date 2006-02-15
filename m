Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423030AbWBOINu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423030AbWBOINu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423033AbWBOINu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:13:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14747 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423030AbWBOINt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:13:49 -0500
Date: Wed, 15 Feb 2006 00:13:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: oops in exit on null cpuset fix
Message-Id: <20060215001339.4a4d9810.pj@sgi.com>
In-Reply-To: <20060214224710.35887069.akpm@osdl.org>
References: <20060215063058.22043.61848.sendpatchset@jackhammer.engr.sgi.com>
	<20060214224710.35887069.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Seems strange to patch the kernel for this.  Can't the add-on patch do it? 
> Or can we just move the cpuset_exit()s to later in the exit() paths?

Sure, the add-on could have handled it, or had its exit routine
called earlier, or had cpuset_exit called later, ...

But it would still have been an accident waiting to happen again,
when someone adds another hook, or gets the order in cpuset_exit
wrong, or some such.

Heck, for all I know, your *-mm kernel might even have such a
bug now (before you took this patch).  Perhaps there was some
code path that would try to allocate memory after the cpuset_exit
call, and no one has hit on that path yet.

This patch was a zero runtime cost way to reduce the risks.  With
this patch, a task doesn't have a blackout period, shortly before
exit, when memory allocations will oops the kernel.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
