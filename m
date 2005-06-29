Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVF2Gfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVF2Gfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVF2Gfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:35:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15238 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262446AbVF2GfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:35:22 -0400
Date: Wed, 29 Jun 2005 08:34:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050629063439.GB12536@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu> <20050628203017.GA371@elte.hu> <200506290151.53675.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506290151.53675.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> looked at -50-33 now and wonder why is mask_IO_APIC_irq() called twice 
> from __do_IRQ()? given a threaded interrupt: __do_IRQ() calls 
> desc->handler->ack(irq). ack points to 
> mask_and_ack_level_ioapic_irq(), which calls mask_IO_APIC_irq(irq).  
> some lines later in __do_IRQ() desc->handler->disable(irq) is called.  
> disable points to mask_IO_APIC_irq(), now being called a 2nd time. I 
> think this 2nd call isn't necessary. Is there a difference between 
> masking an interrupt line and disabling it? What am I missing?

you are not missing anything - but i found no easy way for the time 
being to get rid of the second masking.

> Back at 2.6.12-rc5-RT-48-16 mask_and_ack_level_ioapic_irq() also 
> contained the mask_IO_APIC_irq(irq) call and level interrupt-rates 
> where fine. Some versions later it vanished there. Why was that?

i reorganized how redirection is being done, and i've implemented 
auto-ACK for the i8259A, to reduce IRQ handling costs. One goal was to 
avoid the masking of the interrupt line for the timer interrupt on 
i8259A - but i think i'm going to revert that, it's causing too many 
problems all around.

	Ingo
