Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSFRJyD>; Tue, 18 Jun 2002 05:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSFRJyC>; Tue, 18 Jun 2002 05:54:02 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:16515 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317373AbSFRJyB>; Tue, 18 Jun 2002 05:54:01 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Helge Hafting'" <helgehaf@aitel.hist.no>
Cc: "'Raphael Manfredi'" <Raphael_Manfredi@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The buggy APIC of the Abit BP6
Date: Tue, 18 Jun 2002 11:53:26 +0200
Message-ID: <003501c216ad$ff50bdb0$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> I'll try it. Have you considered resubmitting the patch,
> hidden behind a CONFIG_BROKEN_APIC? That'll keep the code
> clean for those with better hardware.
 
We might as well move the kick_IO_APIC_irq call to the
arch/i386/kernel/irq.c:ack_none function then, surrounded by proper
#ifdefs. The ack_none is the function that does the printk("unexpected
IRQ trap at vector %02x\n", irq), which I see everytime the bug
triggers.

And looking at the comment of the end_level_ioapic_irq function in
io_apic.c, is there a possibility to replace the kick_IO_APIC_irq call
entirely with a end_level_ioapic_irq call? I see lots of similarities in
these two functions.

I didn't test this yet, as I'm still running on Raphael's patch, waiting
for the bug to trigger. (Anyone got a reliable way of triggering it?)

Regards,
- Robbert Kouprie

