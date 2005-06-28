Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVF1X6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVF1X6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVF1Xyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:54:45 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:7785 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262313AbVF1Xux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:50:53 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Wed, 29 Jun 2005 01:51:53 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu> <20050628203017.GA371@elte.hu>
In-Reply-To: <20050628203017.GA371@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506290151.53675.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. Juni 2005 22:30 schrieb Ingo Molnar:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> > 
> > > Hi Ingo,
> > > 
> > > suffering (not really ;-) double-rated IO-APIC level-interrupts I 
> > > found the following patch as a solution:
> > 
> > thanks. I've applied your patch but also tweaked this area a bit, to 
> > make the i8259A PIC work too. I've uploaded the -31 patch with these 
> > fixes included.
> 
> make that -50-32, had a leftover hack in io_apic.c.
> 
looked at -50-33 now and wonder why is mask_IO_APIC_irq() called twice
from  __do_IRQ()?
given a threaded interrupt:
__do_IRQ() calls desc->handler->ack(irq).
ack points to mask_and_ack_level_ioapic_irq(), which calls mask_IO_APIC_irq(irq).
some lines later in __do_IRQ() desc->handler->disable(irq) is called.
disable points to  mask_IO_APIC_irq(), now being called a 2nd time.
I think this 2nd call isn't necessary.
Is there a difference between masking an interrupt line and disabling it?
What am I missing?

Back at 2.6.12-rc5-RT-48-16 mask_and_ack_level_ioapic_irq() also contained the mask_IO_APIC_irq(irq)
call and level interrupt-rates where fine.
Some versions later it vanished there. Why was that?

Karsten



  

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
