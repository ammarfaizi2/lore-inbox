Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWESOw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWESOw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWESOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:52:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:3300 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751332AbWESOw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:52:27 -0400
Date: Fri, 19 May 2006 16:52:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: [patchset] Generic IRQ Subsystem: -V5
Message-ID: <20060519145225.GA12703@elte.hu>
References: <20060517001310.GA12877@elte.hu> <20060517221536.GA13444@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This is Version 5 of the genirq patch-queue, against 2.6.17-rc4. The 
genirq patch-queue improves the generic IRQ layer to be truly generic, 
by adding various abstractions and features to it, without impacting 
existing functionality. It converts ARM, i386 and x86_64 to this new 
generic IRQ layer - while keeping compatibility with all the other 
genirq architectures too.

The full patch-queue can be downloaded from:

  http://redhat.com/~mingo/generic-irq-subsystem/

genirq -V5 is mostly about fixes and smaller cleanups. Suggestions from 
many people were included - let us know if anything is missing. It has 
been tested on i386, x86_64 and ARM systems.

Changes since -V4:

 - fix: added IRQ_INPROGRESS protection to the fastack, level and simple
   flow handlers, to avoid irq reentry due to hardware bugs. (especially 
   on SMP this is not unheard of.)

 - fix: fixed two old-style IRQ probing bugs on non-irqchip
   architectures.

 - fix: bad irq vectors should increase the IRQ kstat too

 - feature: added IRQ_DELAYED_DISABLE support for edge-irq handling on 
   really dumb controllers.

 - docs: various documentation and comment updates

 - cleanup/speedup: cleaned up desc->depth and IRQ_DISABLED handling - 
   the two were not always in sync. Made the generic flow handlers use
   IRQ_DISABLED instead of desc->depth - results in more optimal code.

 - cleanup: introduced generic_handle_irq(irq) for architectures to call 
   when they want the generic layer to handle an interrupt.

 - rename: renamed probe_lock to probing_active

 - rename: renamed handle_level_irq_fastack to handle_fastack_irq - 
   there is no strict requirement of the trigger type of the irq.

The split-out queue can be found at:

  http://redhat.com/~mingo/generic-irq-subsystem/patches/

	Ingo, Thomas
