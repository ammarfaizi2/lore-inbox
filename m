Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263760AbUD0FU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUD0FU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUD0FU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:20:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:57910 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263760AbUD0FTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:19:47 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on contended spinlocks 
In-reply-to: Your message of "Mon, 26 Apr 2004 21:49:52 MST."
             <20040426214952.333c9ad7.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Apr 2004 15:19:37 +1000
Message-ID: <4045.1083043177@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 21:49:52 -0700, 
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>
>>  Enable interrupts while waiting for a disabled spinlock, but only if
>>  interrupts were enabled before issuing spin_lock_irqsave().  It makes a
>>  measurable difference to interrupt servicing on large systems.
>
>Do you know which are the offending locks?

Workload dependent.  We already service interrupts while waiting for a
non-disabled spinlock.  The patch allows a cpu to do some useful work
and service interrupts while waiting for disabled spinlocks as well.

>How much difference, and how large are the systems?

>From memory (September 2003) 3-5% improvement on an AIM7 run, with 64
processors.

