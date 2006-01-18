Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWARII1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWARII1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbWARII1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:08:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:13547 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964880AbWARII0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:08:26 -0500
Date: Wed, 18 Jan 2006 09:08:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Lynch <ntl@pobox.com>, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118080828.GA2324@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117233734.506c2f2e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Yes, which would be why this code never triggered a warning when
> > cpucontrol was a semaphore.
> 
> Yup.  Perhaps a sane fix which preserves the unpleasant semantics is 
> to do irqsave in the mutex debug code.

i'd much rather remove that ugly hack from __might_sleep(). How many 
other bugs does it hide? Does it hide bugs that dont normally trigger 
during bootups on real hardware, but which could trigger on e.g. UML or 
on Xen? I really think such ugly workarounds are not justified, if other 
arches can get their act together. Would you make such an exception for 
other arches too, like ARM?

an irqsave in the mutex debug code will uglify the kernel/mutex.c code - 
i'd have to add extra "unsigned long flags" lines. [It will also slow 
down the debug code a bit - an extra PUSHF has to be done.]

	Ingo
