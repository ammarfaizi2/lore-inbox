Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWARIZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWARIZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWARIZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:25:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030186AbWARIZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:25:36 -0500
Date: Wed, 18 Jan 2006 00:24:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ntl@pobox.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com, torvalds@osdl.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-Id: <20060118002459.3bc8f75a.akpm@osdl.org>
In-Reply-To: <20060118080828.GA2324@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
	<200601180032.46867.michael@ellerman.id.au>
	<20060117140050.GA13188@elte.hu>
	<200601181119.39872.michael@ellerman.id.au>
	<20060118033239.GA621@cs.umn.edu>
	<20060118063732.GA21003@elte.hu>
	<20060117225304.4b6dd045.akpm@osdl.org>
	<20060118072815.GR2846@localhost.localdomain>
	<20060117233734.506c2f2e.akpm@osdl.org>
	<20060118080828.GA2324@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > Yes, which would be why this code never triggered a warning when
> > > cpucontrol was a semaphore.
> > 
> > Yup.  Perhaps a sane fix which preserves the unpleasant semantics is 
> > to do irqsave in the mutex debug code.
> 
> i'd much rather remove that ugly hack from __might_sleep(). How many 
> other bugs does it hide?

Gee, it was 2.6.0-test9.  I don't remember, but I do recall the problems
were really really nasty, and what's the point?  We're only running one
thread on one CPU at that time, so none of these things _will_ sleep.

> Does it hide bugs that dont normally trigger 
> during bootups on real hardware, but which could trigger on e.g. UML or 
> on Xen? I really think such ugly workarounds are not justified, if other 
> arches can get their act together. Would you make such an exception for 
> other arches too, like ARM?

Don't care really, as long as a) the problems don't hit -mm or mainline and
b) someone else fixes them.  Yes, it'd be nice to fix these things, and we
might even find real bugs.  Perhaps things are better now, but I suspect
it's a can of worms.

> an irqsave in the mutex debug code will uglify the kernel/mutex.c code - 
> i'd have to add extra "unsigned long flags" lines. [It will also slow 
> down the debug code a bit - an extra PUSHF has to be done.]

Small cost, really...
