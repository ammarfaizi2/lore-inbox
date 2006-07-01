Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWGAPJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWGAPJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWGAPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:08:48 -0400
Received: from www.osadl.org ([213.239.205.134]:55972 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750819AbWGAO52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:28 -0400
Message-Id: <20060701145226.942127000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:57 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, hjlipp@web.de
Subject: [RFC][patch 32/44] isdn: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-isdn.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/isdn/hardware/avm/b1pci.c       |    4 ++--
 drivers/isdn/hardware/avm/b1pcmcia.c    |    2 +-
 drivers/isdn/hardware/avm/c4.c          |    2 +-
 drivers/isdn/hardware/avm/t1pci.c       |    2 +-
 drivers/isdn/hardware/eicon/divasmain.c |    2 +-
 drivers/isdn/hisax/avm_a1p.c            |    2 +-
 drivers/isdn/hisax/avm_pci.c            |    2 +-
 drivers/isdn/hisax/bkm_a4t.c            |    2 +-
 drivers/isdn/hisax/bkm_a8.c             |    2 +-
 drivers/isdn/hisax/diva.c               |    2 +-
 drivers/isdn/hisax/elsa.c               |   22 +++++++++++-----------
 drivers/isdn/hisax/enternow_pci.c       |    2 +-
 drivers/isdn/hisax/gazel.c              |    2 +-
 drivers/isdn/hisax/hfc4s8s_l1.c         |    2 +-
 drivers/isdn/hisax/hfc_pci.c            |    2 +-
 drivers/isdn/hisax/hisax_fcpcipnp.c     |    4 ++--
 drivers/isdn/hisax/niccy.c              |    2 +-
 drivers/isdn/hisax/nj_s.c               |    2 +-
 drivers/isdn/hisax/nj_u.c               |    2 +-
 drivers/isdn/hisax/sedlbauer.c          |    4 ++--
 drivers/isdn/hisax/teles3.c             |    2 +-
 drivers/isdn/hisax/telespci.c           |    2 +-
 drivers/isdn/hisax/w6692.c              |    2 +-
 drivers/isdn/hysdn/boardergo.c          |    2 +-
 drivers/isdn/sc/init.c                  |    2 +-
 25 files changed, 38 insertions(+), 38 deletions(-)

Index: linux-2.6.git/drivers/isdn/hardware/avm/b1pci.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hardware/avm/b1pci.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hardware/avm/b1pci.c	2006-07-01 16:51:41.000000000 +0200
@@ -97,7 +97,7 @@ static int b1pci_probe(struct capicardpa
 	b1_reset(card->port);
 	b1_getrevision(card);
 	
-	retval = request_irq(card->irq, b1_interrupt, SA_SHIRQ, card->name, card);
+	retval = request_irq(card->irq, b1_interrupt, IRQF_SHARED, card->name, card);
 	if (retval) {
 		printk(KERN_ERR "b1pci: unable to get IRQ %d.\n", card->irq);
 		retval = -EBUSY;
@@ -234,7 +234,7 @@ static int b1pciv4_probe(struct capicard
 	b1dma_reset(card);
 	b1_getrevision(card);
 
-	retval = request_irq(card->irq, b1dma_interrupt, SA_SHIRQ, card->name, card);
+	retval = request_irq(card->irq, b1dma_interrupt, IRQF_SHARED, card->name, card);
 	if (retval) {
 		printk(KERN_ERR "b1pci: unable to get IRQ %d.\n",
 		       card->irq);
Index: linux-2.6.git/drivers/isdn/hardware/avm/b1pcmcia.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hardware/avm/b1pcmcia.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hardware/avm/b1pcmcia.c	2006-07-01 16:51:41.000000000 +0200
@@ -82,7 +82,7 @@ static int b1pcmcia_add_card(unsigned in
 	card->irq = irq;
 	card->cardtype = cardtype;
 
-	retval = request_irq(card->irq, b1_interrupt, SA_SHIRQ, card->name, card);
+	retval = request_irq(card->irq, b1_interrupt, IRQF_SHARED, card->name, card);
 	if (retval) {
 		printk(KERN_ERR "b1pcmcia: unable to get IRQ %d.\n",
 		       card->irq);
Index: linux-2.6.git/drivers/isdn/hardware/avm/c4.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hardware/avm/c4.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hardware/avm/c4.c	2006-07-01 16:51:41.000000000 +0200
@@ -1172,7 +1172,7 @@ static int c4_add_card(struct capicardpa
 	}
 	c4_reset(card);
 
-	retval = request_irq(card->irq, c4_interrupt, SA_SHIRQ, card->name, card);
+	retval = request_irq(card->irq, c4_interrupt, IRQF_SHARED, card->name, card);
 	if (retval) {
 		printk(KERN_ERR "c4: unable to get IRQ %d.\n",card->irq);
 		retval = -EBUSY;
Index: linux-2.6.git/drivers/isdn/hardware/avm/t1pci.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hardware/avm/t1pci.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hardware/avm/t1pci.c	2006-07-01 16:51:41.000000000 +0200
@@ -103,7 +103,7 @@ static int t1pci_add_card(struct capicar
 	}
 	b1dma_reset(card);
 
-	retval = request_irq(card->irq, b1dma_interrupt, SA_SHIRQ, card->name, card);
+	retval = request_irq(card->irq, b1dma_interrupt, IRQF_SHARED, card->name, card);
 	if (retval) {
 		printk(KERN_ERR "t1pci: unable to get IRQ %d.\n", card->irq);
 		retval = -EBUSY;
Index: linux-2.6.git/drivers/isdn/hardware/eicon/divasmain.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hardware/eicon/divasmain.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hardware/eicon/divasmain.c	2006-07-01 16:51:41.000000000 +0200
@@ -486,7 +486,7 @@ void __inline__ outpp(void __iomem *addr
 int diva_os_register_irq(void *context, byte irq, const char *name)
 {
 	int result = request_irq(irq, diva_os_irq_wrapper,
-				 SA_INTERRUPT | SA_SHIRQ, name, context);
+				 IRQF_DISABLED | IRQF_SHARED, name, context);
 	return (result);
 }
 
Index: linux-2.6.git/drivers/isdn/hisax/avm_a1p.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/avm_a1p.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/avm_a1p.c	2006-07-01 16:51:41.000000000 +0200
@@ -255,7 +255,7 @@ setup_avm_a1_pcmcia(struct IsdnCard *car
 	cs->BC_Write_Reg = &WriteHSCX;
 	cs->BC_Send_Data = &hscx_fill_fifo;
 	cs->cardmsg = &AVM_card_msg;
-	cs->irq_flags = SA_SHIRQ;
+	cs->irq_flags = IRQF_SHARED;
 	cs->irq_func = &avm_a1p_interrupt;
 
 	ISACVersion(cs, "AVM A1 PCMCIA:");
Index: linux-2.6.git/drivers/isdn/hisax/avm_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/avm_pci.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/avm_pci.c	2006-07-01 16:51:41.000000000 +0200
@@ -808,7 +808,7 @@ setup_avm_pcipnp(struct IsdnCard *card)
 		printk(KERN_WARNING "FritzPCI: No PCI card found\n");
 		return(0);
 	}
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 #else
 	printk(KERN_WARNING "FritzPCI: NO_PCI_BIOS\n");
 	return (0);
Index: linux-2.6.git/drivers/isdn/hisax/bkm_a4t.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/bkm_a4t.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/bkm_a4t.c	2006-07-01 16:51:41.000000000 +0200
@@ -335,7 +335,7 @@ setup_bkm_a4t(struct IsdnCard *card)
 	cs->BC_Send_Data = &jade_fill_fifo;
 	cs->cardmsg = &BKM_card_msg;
 	cs->irq_func = &bkm_interrupt;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 	ISACVersion(cs, "Telekom A4T:");
 	/* Jade version */
 	JadeVersion(cs, "Telekom A4T:");
Index: linux-2.6.git/drivers/isdn/hisax/bkm_a8.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/bkm_a8.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/bkm_a8.c	2006-07-01 16:51:41.000000000 +0200
@@ -374,7 +374,7 @@ setup_sct_quadro(struct IsdnCard *card)
 	pci_ioaddr5 &= PCI_BASE_ADDRESS_IO_MASK;
 	/* Take over */
 	cs->irq = pci_irq;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 	/* pci_ioaddr1 is unique to all subdevices */
 	/* pci_ioaddr2 is for the fourth subdevice only */
 	/* pci_ioaddr3 is for the third subdevice only */
Index: linux-2.6.git/drivers/isdn/hisax/diva.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/diva.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/diva.c	2006-07-01 16:51:41.000000000 +0200
@@ -1076,7 +1076,7 @@ setup_diva(struct IsdnCard *card)
 			printk(KERN_WARNING "Diva: No IO-Adr for PCI card found\n");
 			return(0);
 		}
-		cs->irq_flags |= SA_SHIRQ;
+		cs->irq_flags |= IRQF_SHARED;
 #else
 		printk(KERN_WARNING "Diva: cfgreg 0 and NO_PCI_BIOS\n");
 		printk(KERN_WARNING "Diva: unable to config DIVA PCI\n");
Index: linux-2.6.git/drivers/isdn/hisax/elsa.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/elsa.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/elsa.c	2006-07-01 16:51:41.000000000 +0200
@@ -85,8 +85,8 @@ static const char *ITACVer[] =
  ***                                                                    ***/
 
 /* Config-Register (Read) */
-#define ELSA_TIMER_RUN       0x02	/* Bit 1 des Config-Reg     */
-#define ELSA_TIMER_RUN_PCC8  0x01	/* Bit 0 des Config-Reg  bei PCC */
+#define ELIRQF_TIMER_RUN       0x02	/* Bit 1 des Config-Reg     */
+#define ELIRQF_TIMER_RUN_PCC8  0x01	/* Bit 0 des Config-Reg  bei PCC */
 #define ELSA_IRQ_IDX       0x38	/* Bit 3,4,5 des Config-Reg */
 #define ELSA_IRQ_IDX_PCC8  0x30	/* Bit 4,5 des Config-Reg */
 #define ELSA_IRQ_IDX_PC    0x0c	/* Bit 2,3 des Config-Reg */
@@ -102,7 +102,7 @@ static const char *ITACVer[] =
 #define ELSA_S0_POWER_BAD    0x08	/* Bit 3 S0-Bus Spannung fehlt */
 
 /* Status Flags */
-#define ELSA_TIMER_AKTIV 1
+#define ELIRQF_TIMER_AKTIV 1
 #define ELSA_BAD_PWR     2
 #define ELSA_ASSIGN      4
 
@@ -259,10 +259,10 @@ TimerRun(struct IsdnCardState *cs)
 
 	v = bytein(cs->hw.elsa.cfg);
 	if ((cs->subtyp == ELSA_QS1000) || (cs->subtyp == ELSA_QS3000))
-		return (0 == (v & ELSA_TIMER_RUN));
+		return (0 == (v & ELIRQF_TIMER_RUN));
 	else if (cs->subtyp == ELSA_PCC8)
-		return (v & ELSA_TIMER_RUN_PCC8);
-	return (v & ELSA_TIMER_RUN);
+		return (v & ELIRQF_TIMER_RUN_PCC8);
+	return (v & ELIRQF_TIMER_RUN);
 }
 /*
  * fast interrupt HSCX stuff goes here
@@ -334,7 +334,7 @@ elsa_interrupt(int intno, void *dev_id, 
 	writereg(cs->hw.elsa.ale, cs->hw.elsa.hscx, HSCX_MASK, 0xFF);
 	writereg(cs->hw.elsa.ale, cs->hw.elsa.hscx, HSCX_MASK + 0x40, 0xFF);
 	writereg(cs->hw.elsa.ale, cs->hw.elsa.isac, ISAC_MASK, 0xFF);
-	if (cs->hw.elsa.status & ELSA_TIMER_AKTIV) {
+	if (cs->hw.elsa.status & ELIRQF_TIMER_AKTIV) {
 		if (!TimerRun(cs)) {
 			/* Timer Restart */
 			byteout(cs->hw.elsa.timer, 0);
@@ -685,7 +685,7 @@ Elsa_card_msg(struct IsdnCardState *cs, 
 				spin_lock_irqsave(&cs->lock, flags);
 				cs->hw.elsa.counter = 0;
 				cs->hw.elsa.ctrl_reg |= ELSA_ENA_TIMER_INT;
-				cs->hw.elsa.status |= ELSA_TIMER_AKTIV;
+				cs->hw.elsa.status |= ELIRQF_TIMER_AKTIV;
 				byteout(cs->hw.elsa.ctrl, cs->hw.elsa.ctrl_reg);
 				byteout(cs->hw.elsa.timer, 0);
 				spin_unlock_irqrestore(&cs->lock, flags);
@@ -693,7 +693,7 @@ Elsa_card_msg(struct IsdnCardState *cs, 
 				spin_lock_irqsave(&cs->lock, flags);
 				cs->hw.elsa.ctrl_reg &= ~ELSA_ENA_TIMER_INT;
 				byteout(cs->hw.elsa.ctrl, cs->hw.elsa.ctrl_reg);
-				cs->hw.elsa.status &= ~ELSA_TIMER_AKTIV;
+				cs->hw.elsa.status &= ~ELIRQF_TIMER_AKTIV;
 				spin_unlock_irqrestore(&cs->lock, flags);
 				printk(KERN_INFO "Elsa: %d timer tics in 110 msek\n",
 				       cs->hw.elsa.counter);
@@ -1012,7 +1012,7 @@ setup_elsa(struct IsdnCard *card)
 		cs->hw.elsa.timer = 0;
 		cs->hw.elsa.trig = 0;
 		cs->hw.elsa.ctrl = 0;
-		cs->irq_flags |= SA_SHIRQ;
+		cs->irq_flags |= IRQF_SHARED;
 		printk(KERN_INFO
 		       "Elsa: %s defined at %#lx IRQ %d\n",
 		       Elsa_Types[cs->subtyp],
@@ -1061,7 +1061,7 @@ setup_elsa(struct IsdnCard *card)
 		test_and_set_bit(HW_IPAC, &cs->HW_Flags);
 		cs->hw.elsa.timer = 0;
 		cs->hw.elsa.trig  = 0;
-		cs->irq_flags |= SA_SHIRQ;
+		cs->irq_flags |= IRQF_SHARED;
 		printk(KERN_INFO
 		       "Elsa: %s defined at %#lx/0x%x IRQ %d\n",
 		       Elsa_Types[cs->subtyp],
Index: linux-2.6.git/drivers/isdn/hisax/enternow_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/enternow_pci.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/enternow_pci.c	2006-07-01 16:51:41.000000000 +0200
@@ -405,7 +405,7 @@ setup_enternow_pci(struct IsdnCard *card
 	cs->BC_Send_Data = &netjet_fill_dma;
 	cs->cardmsg = &enpci_card_msg;
 	cs->irq_func = &enpci_interrupt;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 
         return (1);
 }
Index: linux-2.6.git/drivers/isdn/hisax/gazel.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/gazel.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/gazel.c	2006-07-01 16:51:41.000000000 +0200
@@ -592,7 +592,7 @@ setup_gazelpci(struct IsdnCardState *cs)
 	cs->hw.gazel.hscxfifo[0] = cs->hw.gazel.hscx[0];
 	cs->hw.gazel.hscxfifo[1] = cs->hw.gazel.hscx[1];
 	cs->irq = pci_irq;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 
 	switch (seekcard) {
 		case PCI_DEVICE_ID_PLX_R685:
Index: linux-2.6.git/drivers/isdn/hisax/hfc4s8s_l1.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/hfc4s8s_l1.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/hfc4s8s_l1.c	2006-07-01 16:51:41.000000000 +0200
@@ -1552,7 +1552,7 @@ setup_instance(hfc4s8s_hw * hw)
 	INIT_WORK(&hw->tqueue, (void *) (void *) hfc4s8s_bh, hw);
 
 	if (request_irq
-	    (hw->irq, hfc4s8s_interrupt, SA_SHIRQ, hw->card_name, hw)) {
+	    (hw->irq, hfc4s8s_interrupt, IRQF_SHARED, hw->card_name, hw)) {
 		printk(KERN_INFO
 		       "HFC-4S/8S: unable to alloc irq %d, card ignored\n",
 		       hw->irq);
Index: linux-2.6.git/drivers/isdn/hisax/hfc_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/hfc_pci.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/hfc_pci.c	2006-07-01 16:51:41.000000000 +0200
@@ -1732,7 +1732,7 @@ setup_hfcpci(struct IsdnCard *card)
 		cs->BC_Read_Reg = NULL;
 		cs->BC_Write_Reg = NULL;
 		cs->irq_func = &hfcpci_interrupt;
-		cs->irq_flags |= SA_SHIRQ;
+		cs->irq_flags |= IRQF_SHARED;
 		cs->hw.hfcpci.timer.function = (void *) hfcpci_Timer;
 		cs->hw.hfcpci.timer.data = (long) cs;
 		init_timer(&cs->hw.hfcpci.timer);
Index: linux-2.6.git/drivers/isdn/hisax/hisax_fcpcipnp.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/hisax_fcpcipnp.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/hisax_fcpcipnp.c	2006-07-01 16:51:41.000000000 +0200
@@ -725,11 +725,11 @@ static int __devinit fcpcipnp_setup(stru
 
 	switch (adapter->type) {
 	case AVM_FRITZ_PCIV2:
-		retval = request_irq(adapter->irq, fcpci2_irq, SA_SHIRQ, 
+		retval = request_irq(adapter->irq, fcpci2_irq, IRQF_SHARED, 
 				     "fcpcipnp", adapter);
 		break;
 	case AVM_FRITZ_PCI:
-		retval = request_irq(adapter->irq, fcpci_irq, SA_SHIRQ,
+		retval = request_irq(adapter->irq, fcpci_irq, IRQF_SHARED,
 				     "fcpcipnp", adapter);
 		break;
 	case AVM_FRITZ_PNP:
Index: linux-2.6.git/drivers/isdn/hisax/niccy.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/niccy.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/niccy.c	2006-07-01 16:51:41.000000000 +0200
@@ -336,7 +336,7 @@ setup_niccy(struct IsdnCard *card)
 			printk(KERN_WARNING "Niccy: No PCI card found\n");
 			return(0);
 		}
-		cs->irq_flags |= SA_SHIRQ;
+		cs->irq_flags |= IRQF_SHARED;
 		cs->hw.niccy.isac = pci_ioaddr + ISAC_PCI_DATA;
 		cs->hw.niccy.isac_ale = pci_ioaddr + ISAC_PCI_ADDR;
 		cs->hw.niccy.hscx = pci_ioaddr + HSCX_PCI_DATA;
Index: linux-2.6.git/drivers/isdn/hisax/nj_s.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/nj_s.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/nj_s.c	2006-07-01 16:51:41.000000000 +0200
@@ -271,7 +271,7 @@ setup_netjet_s(struct IsdnCard *card)
 	setup_isac(cs);
 	cs->cardmsg = &NETjet_S_card_msg;
 	cs->irq_func = &netjet_s_interrupt;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 	ISACVersion(cs, "NETjet-S:");
 	return (1);
 }
Index: linux-2.6.git/drivers/isdn/hisax/nj_u.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/nj_u.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/nj_u.c	2006-07-01 16:51:41.000000000 +0200
@@ -237,7 +237,7 @@ setup_netjet_u(struct IsdnCard *card)
 	cs->BC_Send_Data = &netjet_fill_dma;
 	cs->cardmsg = &NETjet_U_card_msg;
 	cs->irq_func = &netjet_u_interrupt;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 	ICCVersion(cs, "NETspider-U:");
 	return (1);
 }
Index: linux-2.6.git/drivers/isdn/hisax/sedlbauer.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/sedlbauer.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/sedlbauer.c	2006-07-01 16:51:41.000000000 +0200
@@ -632,7 +632,7 @@ setup_sedlbauer(struct IsdnCard *card)
 			printk(KERN_WARNING "Sedlbauer: No PCI card found\n");
 			return(0);
 		}
-		cs->irq_flags |= SA_SHIRQ;
+		cs->irq_flags |= IRQF_SHARED;
 		cs->hw.sedl.bus = SEDL_BUS_PCI;
 		sub_vendor_id = dev_sedl->subsystem_vendor;
 		sub_id = dev_sedl->subsystem_device;
@@ -809,7 +809,7 @@ ready:	
 				cs->hw.sedl.hscx = cs->hw.sedl.cfg_reg + SEDL_HSCX_PCMCIA_HSCX;
 				cs->hw.sedl.reset_on = cs->hw.sedl.cfg_reg + SEDL_HSCX_PCMCIA_RESET;
 				cs->hw.sedl.reset_off = cs->hw.sedl.cfg_reg + SEDL_HSCX_PCMCIA_RESET;
-				cs->irq_flags |= SA_SHIRQ;
+				cs->irq_flags |= IRQF_SHARED;
 			} else {
 				cs->hw.sedl.adr = cs->hw.sedl.cfg_reg + SEDL_HSCX_ISA_ADR;
 				cs->hw.sedl.isac = cs->hw.sedl.cfg_reg + SEDL_HSCX_ISA_ISAC;
Index: linux-2.6.git/drivers/isdn/hisax/teles3.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/teles3.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/teles3.c	2006-07-01 16:51:41.000000000 +0200
@@ -369,7 +369,7 @@ setup_teles3(struct IsdnCard *card)
 			       cs->hw.teles3.hscx[1] + 96);
 			return (0);
 		}
-		cs->irq_flags |= SA_SHIRQ; /* cardbus can share */
+		cs->irq_flags |= IRQF_SHARED; /* cardbus can share */
 	} else {
 		if (cs->hw.teles3.cfg_reg) {
 			if (cs->typ == ISDN_CTYPE_COMPAQ_ISA) {
Index: linux-2.6.git/drivers/isdn/hisax/telespci.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/telespci.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/telespci.c	2006-07-01 16:51:41.000000000 +0200
@@ -347,7 +347,7 @@ setup_telespci(struct IsdnCard *card)
 	cs->BC_Send_Data = &hscx_fill_fifo;
 	cs->cardmsg = &TelesPCI_card_msg;
 	cs->irq_func = &telespci_interrupt;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 	ISACVersion(cs, "TelesPCI:");
 	if (HscxVersion(cs, "TelesPCI:")) {
 		printk(KERN_WARNING
Index: linux-2.6.git/drivers/isdn/hisax/w6692.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hisax/w6692.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hisax/w6692.c	2006-07-01 16:51:41.000000000 +0200
@@ -1080,7 +1080,7 @@ setup_w6692(struct IsdnCard *card)
 	cs->BC_Send_Data = &W6692B_fill_fifo;
 	cs->cardmsg = &w6692_card_msg;
 	cs->irq_func = &W6692_interrupt;
-	cs->irq_flags |= SA_SHIRQ;
+	cs->irq_flags |= IRQF_SHARED;
 	W6692Version(cs, "W6692:");
 	printk(KERN_INFO "W6692 ISTA=0x%X\n", ReadW6692(cs, W_ISTA));
 	printk(KERN_INFO "W6692 IMASK=0x%X\n", ReadW6692(cs, W_IMASK));
Index: linux-2.6.git/drivers/isdn/hysdn/boardergo.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/hysdn/boardergo.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/hysdn/boardergo.c	2006-07-01 16:51:41.000000000 +0200
@@ -435,7 +435,7 @@ ergo_inithardware(hysdn_card * card)
 	}
 
 	ergo_stopcard(card);	/* disable interrupts */
-	if (request_irq(card->irq, ergo_interrupt, SA_SHIRQ, "HYSDN", card)) {
+	if (request_irq(card->irq, ergo_interrupt, IRQF_SHARED, "HYSDN", card)) {
 		ergo_releasehardware(card); /* return the acquired hardware */
 		return (-1);
 	}
Index: linux-2.6.git/drivers/isdn/sc/init.c
===================================================================
--- linux-2.6.git.orig/drivers/isdn/sc/init.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/isdn/sc/init.c	2006-07-01 16:51:41.000000000 +0200
@@ -342,7 +342,7 @@ static int __init sc_init(void)
 		 */
 		sc_adapter[cinst]->interrupt = irq[b];
 		if (request_irq(sc_adapter[cinst]->interrupt, interrupt_handler,
-				SA_INTERRUPT, interface->id, NULL))
+				IRQF_DISABLED, interface->id, NULL))
 		{
 			kfree(sc_adapter[cinst]->channel);
 			indicate_status(cinst, ISDN_STAT_UNLOAD, 0, NULL);	/* Fix me */

--

