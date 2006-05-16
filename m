Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWEPO5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWEPO5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWEPO5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:57:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbWEPO5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:57:45 -0400
Date: Tue, 16 May 2006 07:57:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Avuton Olrich <avuton@gmail.com>
cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFT] major libata update
In-Reply-To: <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org>
References: <20060515170006.GA29555@havoc.gtf.org> 
 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com> 
 <446914C7.1030702@garzik.org>  <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
  <44694C4F.3000008@garzik.org> <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 May 2006, Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>
> > Can you configure your interrupts so that ethernet and SATA are not on
> > the same irq?
> 
> Sorry, need a little hand holding here. I'm unsure how to do such a
> thing, and can't really google that.

Before you do that, try this patch (that I suggested to Neil Brown in a 
totally unrelated thread) just for fun.

		Linus

----
diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index 06dab00..49b9fea 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -880,6 +880,7 @@ static int pcibios_lookup_irq(struct pci
 	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask)) ) {
 		DBG(" -> got IRQ %d\n", irq);
 		msg = "Found";
+		eisa_set_level_irq(irq);
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
