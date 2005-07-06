Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVGFTs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVGFTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVGFTpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19679 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262285AbVGFOb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:31:59 -0400
Date: Wed, 6 Jul 2005 16:31:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT and mptfusion
Message-ID: <20050706143157.GA22156@elte.hu>
References: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr> <20050706120848.GB16843@elte.hu> <1120653209.6225.96.camel@ibiza.btsn.frna.bull.fr> <1120659178.6225.99.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120659178.6225.99.camel@ibiza.btsn.frna.bull.fr>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> > Yes it was 50-47.
> > CONFIG_X86_UP_IOAPIC is not present in my .config
> > CONFIG_PCI_MSI is set to yes.
> > 
> > I'll try with CONFIG_PCI_MSI=n
> It's OK for me. good job.

good. But it would be nice to make it work with PCI_MSI=y too. Does 
PCI_MSI=y work if you apply the patch below?

	Ingo

--- linux/arch/i386/kernel/io_apic.c.orig
+++ linux/arch/i386/kernel/io_apic.c
@@ -2136,11 +2136,7 @@ static void end_level_ioapic_vector (uns
 {
 	int irq = vector_to_irq(vector);
 
-#ifdef CONFIG_PREEMPT_HARDIRQS
-	if (!(irq_desc[vector].status & (IRQ_DISABLED | IRQ_INPROGRESS)) &&
-							irq_desc[vector].action)
-#endif
-		end_level_ioapic_irq(irq);
+	end_level_ioapic_irq(irq);
 }
 
 static void enable_level_ioapic_vector(unsigned int vector)
