Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTDWJGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTDWJGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:06:07 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58602 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263319AbTDWJGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:06:05 -0400
Date: Wed, 23 Apr 2003 05:17:05 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rick Lindsley <ricklind@us.ibm.com>
cc: Bill Davidsen <davidsen@tmr.com>, Dave Jones <davej@codemonkey.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: several messages 
In-Reply-To: <200304222338.h3MNcHI01727@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0304230513030.11873-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Rick Lindsley wrote:

> True.  I have a hunch (and it's only a hunch -- no hard data!) that two
> threads that are sharing the same data will do better if they can be
> located on a physical/sibling processor group.  For workloads where you
> really do have two distinct processes, or even threads but which are
> operating on wholly different portions of data or code, moving them to
> separate physical processors may be warranted.  The key is whether the
> work of one sibling is destroying the cache of another.

If two threads have a workload that wants to be co-scheduled then the SMP
scheduler will do damage to them anyway - independently of any HT
scheduling decisions. One solution for such specific cases is to use the
CPU-binding API to move those threads to the same physical CPU. If there's
some common class of applications where this is the common case, then we
could start thinking about automatic support for them.

	Ingo

