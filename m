Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWGAPKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWGAPKN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWGAPJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:09:46 -0400
Received: from www.osadl.org ([213.239.205.134]:51876 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751544AbWGAO5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:23 -0400
Message-Id: <20060701145226.463775000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 28/44] drivers/char: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-char.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/char/amiserial.c             |    2 -
 drivers/char/applicom.c              |    4 +-
 drivers/char/cyclades.c              |    8 ++---
 drivers/char/esp.c                   |    2 -
 drivers/char/ftape/lowlevel/fdc-io.c |    2 -
 drivers/char/hpet.c                  |    2 -
 drivers/char/hvc_console.c           |    2 -
 drivers/char/hvcs.c                  |    2 -
 drivers/char/hvsi.c                  |    2 -
 drivers/char/ip2/ip2main.c           |    6 ++--
 drivers/char/ipmi/ipmi_si_intf.c     |    4 +-
 drivers/char/isicom.c                |    4 +-
 drivers/char/ite_gpio.c              |    2 -
 drivers/char/mbcs.c                  |    6 ++--
 drivers/char/mmtimer.c               |    2 -
 drivers/char/mxser.c                 |    2 -
 drivers/char/nwbutton.c              |    2 -
 drivers/char/qtronix.c               |    2 -
 drivers/char/riscom8.c               |    2 -
 drivers/char/rtc.c                   |    6 ++--
 drivers/char/s3c2410-rtc.c           |    4 +-
 drivers/char/snsc.c                  |    2 -
 drivers/char/snsc_event.c            |    2 -
 drivers/char/sonypi.c                |    2 -
 drivers/char/specialix.c             |    4 +-
 drivers/char/stallion.c              |    4 +-
 drivers/char/sx.c                    |    4 +-
 drivers/char/synclink.c              |    2 -
 drivers/char/synclink_gt.c           |    2 -
 drivers/char/synclinkmp.c            |    2 -
 drivers/char/tlclk.c                 |    2 -
 drivers/char/tpm/tpm_tis.c           |    4 +-
 drivers/char/vme_scc.c               |   48 +++++++++++++++++------------------
 drivers/char/watchdog/eurotechwdt.c  |    2 -
 drivers/char/watchdog/mpcore_wdt.c   |    2 -
 drivers/char/watchdog/wdt.c          |    2 -
 drivers/char/watchdog/wdt_pci.c      |    2 -
 37 files changed, 77 insertions(+), 77 deletions(-)

Index: linux-2.6.git/drivers/char/amiserial.c
===================================================================
--- linux-2.6.git.orig/drivers/char/amiserial.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/amiserial.c	2006-07-01 16:51:39.000000000 +0200
@@ -2051,7 +2051,7 @@ static int __init rs_init(void)
 
 	/* set ISRs, and then disable the rx interrupts */
 	request_irq(IRQ_AMIGA_TBE, ser_tx_int, 0, "serial TX", state);
-	request_irq(IRQ_AMIGA_RBF, ser_rx_int, SA_INTERRUPT, "serial RX", state);
+	request_irq(IRQ_AMIGA_RBF, ser_rx_int, IRQF_DISABLED, "serial RX", state);
 
 	/* turn off Rx and Tx interrupts */
 	custom.intena = IF_RBF | IF_TBE;
Index: linux-2.6.git/drivers/char/applicom.c
===================================================================
--- linux-2.6.git.orig/drivers/char/applicom.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/applicom.c	2006-07-01 16:51:39.000000000 +0200
@@ -229,7 +229,7 @@ static int __init applicom_init(void)
 			continue;
 		}
 
-		if (request_irq(dev->irq, &ac_interrupt, SA_SHIRQ, "Applicom PCI", &dummy)) {
+		if (request_irq(dev->irq, &ac_interrupt, IRQF_SHARED, "Applicom PCI", &dummy)) {
 			printk(KERN_INFO "Could not allocate IRQ %d for PCI Applicom device.\n", dev->irq);
 			iounmap(RamIO);
 			pci_disable_device(dev);
@@ -276,7 +276,7 @@ static int __init applicom_init(void)
 		printk(KERN_NOTICE "Applicom ISA card found at mem 0x%lx, irq %d\n", mem + (LEN_RAM_IO*i), irq);
 
 		if (!numisa) {
-			if (request_irq(irq, &ac_interrupt, SA_SHIRQ, "Applicom ISA", &dummy)) {
+			if (request_irq(irq, &ac_interrupt, IRQF_SHARED, "Applicom ISA", &dummy)) {
 				printk(KERN_WARNING "Could not allocate IRQ %d for ISA Applicom device.\n", irq);
 				iounmap(RamIO);
 				apbs[boardno - 1].RamIO = NULL;
Index: linux-2.6.git/drivers/char/cyclades.c
===================================================================
--- linux-2.6.git.orig/drivers/char/cyclades.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/cyclades.c	2006-07-01 16:51:39.000000000 +0200
@@ -4612,7 +4612,7 @@ cy_detect_isa(void)
 
                 /* allocate IRQ */
                 if(request_irq(cy_isa_irq, cyy_interrupt,
-				   SA_INTERRUPT, "Cyclom-Y", &cy_card[j]))
+				   IRQF_DISABLED, "Cyclom-Y", &cy_card[j]))
                 {
                         printk("Cyclom-Y/ISA found at 0x%lx ",
                                 (unsigned long) cy_isa_address);
@@ -4785,7 +4785,7 @@ cy_detect_pci(void)
 
                 /* allocate IRQ */
                 if(request_irq(cy_pci_irq, cyy_interrupt,
-		        SA_SHIRQ, "Cyclom-Y", &cy_card[j]))
+		        IRQF_SHARED, "Cyclom-Y", &cy_card[j]))
                 {
                         printk("Cyclom-Y/PCI found at 0x%lx ",
 			    (ulong) cy_pci_phys2);
@@ -4965,7 +4965,7 @@ cy_detect_pci(void)
                 /* allocate IRQ only if board has an IRQ */
 		if( (cy_pci_irq != 0) && (cy_pci_irq != 255) ) {
 		    if(request_irq(cy_pci_irq, cyz_interrupt,
-			SA_SHIRQ, "Cyclades-Z", &cy_card[j]))
+			IRQF_SHARED, "Cyclades-Z", &cy_card[j]))
 		    {
                         printk("Cyclom-8Zo/PCI found at 0x%lx ",
 			    (ulong) cy_pci_phys2);
@@ -5059,7 +5059,7 @@ cy_detect_pci(void)
                 /* allocate IRQ only if board has an IRQ */
 		if( (cy_pci_irq != 0) && (cy_pci_irq != 255) ) {
 		    if(request_irq(cy_pci_irq, cyz_interrupt,
-			SA_SHIRQ, "Cyclades-Z", &cy_card[j]))
+			IRQF_SHARED, "Cyclades-Z", &cy_card[j]))
 		    {
                         printk("Cyclom-Ze/PCI found at 0x%lx ",
 			    (ulong) cy_pci_phys2);
Index: linux-2.6.git/drivers/char/esp.c
===================================================================
--- linux-2.6.git.orig/drivers/char/esp.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/esp.c	2006-07-01 16:51:39.000000000 +0200
@@ -883,7 +883,7 @@ static int startup(struct esp_struct * i
 	 * Allocate the IRQ
 	 */
 
-	retval = request_irq(info->irq, rs_interrupt_single, SA_SHIRQ,
+	retval = request_irq(info->irq, rs_interrupt_single, IRQF_SHARED,
 			     "esp serial", info);
 
 	if (retval) {
Index: linux-2.6.git/drivers/char/hpet.c
===================================================================
--- linux-2.6.git.orig/drivers/char/hpet.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/hpet.c	2006-07-01 16:51:39.000000000 +0200
@@ -395,7 +395,7 @@ static int hpet_ioctl_ieon(struct hpet_d
 
 		sprintf(devp->hd_name, "hpet%d", (int)(devp - hpetp->hp_dev));
 		irq_flags = devp->hd_flags & HPET_SHARED_IRQ
-						? SA_SHIRQ : SA_INTERRUPT;
+						? IRQF_SHARED : IRQF_DISABLED;
 		if (request_irq(irq, hpet_interrupt, irq_flags,
 				devp->hd_name, (void *)devp)) {
 			printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
Index: linux-2.6.git/drivers/char/hvc_console.c
===================================================================
--- linux-2.6.git.orig/drivers/char/hvc_console.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/hvc_console.c	2006-07-01 16:51:39.000000000 +0200
@@ -346,7 +346,7 @@ static int hvc_open(struct tty_struct *t
 	spin_unlock_irqrestore(&hp->lock, flags);
 	/* check error, fallback to non-irq */
 	if (irq != NO_IRQ)
-		rc = request_irq(irq, hvc_handle_interrupt, SA_INTERRUPT, "hvc_console", hp);
+		rc = request_irq(irq, hvc_handle_interrupt, IRQF_DISABLED, "hvc_console", hp);
 
 	/*
 	 * If the request_irq() fails and we return an error.  The tty layer
Index: linux-2.6.git/drivers/char/hvcs.c
===================================================================
--- linux-2.6.git.orig/drivers/char/hvcs.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/hvcs.c	2006-07-01 16:51:39.000000000 +0200
@@ -899,7 +899,7 @@ static int hvcs_enable_device(struct hvc
 	 * the conn was registered and now.
 	 */
 	if (!(rc = request_irq(irq, &hvcs_handle_interrupt,
-				SA_INTERRUPT, "ibmhvcs", hvcsd))) {
+				IRQF_DISABLED, "ibmhvcs", hvcsd))) {
 		/*
 		 * It is possible the vty-server was removed after the irq was
 		 * requested but before we have time to enable interrupts.
Index: linux-2.6.git/drivers/char/hvsi.c
===================================================================
--- linux-2.6.git.orig/drivers/char/hvsi.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/hvsi.c	2006-07-01 16:51:39.000000000 +0200
@@ -1168,7 +1168,7 @@ static int __init hvsi_init(void)
 		struct hvsi_struct *hp = &hvsi_ports[i];
 		int ret = 1;
 
-		ret = request_irq(hp->virq, hvsi_interrupt, SA_INTERRUPT, "hvsi", hp);
+		ret = request_irq(hp->virq, hvsi_interrupt, IRQF_DISABLED, "hvsi", hp);
 		if (ret)
 			printk(KERN_ERR "HVSI: couldn't reserve irq 0x%x (error %i)\n",
 				hp->virq, ret);
Index: linux-2.6.git/drivers/char/isicom.c
===================================================================
--- linux-2.6.git.orig/drivers/char/isicom.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/isicom.c	2006-07-01 16:51:39.000000000 +0200
@@ -1614,14 +1614,14 @@ static int __devinit isicom_register_isr
 	const unsigned int index)
 {
 	struct isi_board *board = pci_get_drvdata(pdev);
-	unsigned long irqflags = SA_INTERRUPT;
+	unsigned long irqflags = IRQF_DISABLED;
 	int retval = -EINVAL;
 
 	if (!board->base)
 		goto end;
 
 	if (board->isa == NO)
-		irqflags |= SA_SHIRQ;
+		irqflags |= IRQF_SHARED;
 
 	retval = request_irq(board->irq, isicom_interrupt, irqflags,
 		ISICOM_NAME, board);
Index: linux-2.6.git/drivers/char/ite_gpio.c
===================================================================
--- linux-2.6.git.orig/drivers/char/ite_gpio.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/ite_gpio.c	2006-07-01 16:51:39.000000000 +0200
@@ -397,7 +397,7 @@ int __init ite_gpio_init(void)
 		init_waitqueue_head(&ite_gpio_wait[i]);
 	}
 
-	if (request_irq(ite_gpio_irq, ite_gpio_irq_handler, SA_SHIRQ, "gpio", 0) < 0) {
+	if (request_irq(ite_gpio_irq, ite_gpio_irq_handler, IRQF_SHARED, "gpio", 0) < 0) {
 		misc_deregister(&ite_gpio_miscdev);
 		release_region(ite_gpio_base, 0x1c);
 		return 0;
Index: linux-2.6.git/drivers/char/mbcs.c
===================================================================
--- linux-2.6.git.orig/drivers/char/mbcs.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/mbcs.c	2006-07-01 16:51:39.000000000 +0200
@@ -592,7 +592,7 @@ static int mbcs_intr_alloc(struct cx_dev
 	getdma->intrHostDest = sn_irq->irq_xtalkaddr;
 	getdma->intrVector = sn_irq->irq_irq;
 	if (request_irq(sn_irq->irq_irq,
-			(void *)mbcs_completion_intr_handler, SA_SHIRQ,
+			(void *)mbcs_completion_intr_handler, IRQF_SHARED,
 			"MBCS get intr", (void *)soft)) {
 		tiocx_irq_free(soft->get_sn_irq);
 		return -EAGAIN;
@@ -608,7 +608,7 @@ static int mbcs_intr_alloc(struct cx_dev
 	putdma->intrHostDest = sn_irq->irq_xtalkaddr;
 	putdma->intrVector = sn_irq->irq_irq;
 	if (request_irq(sn_irq->irq_irq,
-			(void *)mbcs_completion_intr_handler, SA_SHIRQ,
+			(void *)mbcs_completion_intr_handler, IRQF_SHARED,
 			"MBCS put intr", (void *)soft)) {
 		tiocx_irq_free(soft->put_sn_irq);
 		free_irq(soft->get_sn_irq->irq_irq, soft);
@@ -628,7 +628,7 @@ static int mbcs_intr_alloc(struct cx_dev
 	algo->intrHostDest = sn_irq->irq_xtalkaddr;
 	algo->intrVector = sn_irq->irq_irq;
 	if (request_irq(sn_irq->irq_irq,
-			(void *)mbcs_completion_intr_handler, SA_SHIRQ,
+			(void *)mbcs_completion_intr_handler, IRQF_SHARED,
 			"MBCS algo intr", (void *)soft)) {
 		tiocx_irq_free(soft->algo_sn_irq);
 		free_irq(soft->put_sn_irq->irq_irq, soft);
Index: linux-2.6.git/drivers/char/mxser.c
===================================================================
--- linux-2.6.git.orig/drivers/char/mxser.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/mxser.c	2006-07-01 16:51:39.000000000 +0200
@@ -94,7 +94,7 @@
 #define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|\
 					  IXON|IXOFF))
 
-#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? SA_SHIRQ : SA_INTERRUPT)
+#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED : IRQF_DISABLED)
 
 #define C168_ASIC_ID    1
 #define C104_ASIC_ID    2
Index: linux-2.6.git/drivers/char/nwbutton.c
===================================================================
--- linux-2.6.git.orig/drivers/char/nwbutton.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/nwbutton.c	2006-07-01 16:51:39.000000000 +0200
@@ -223,7 +223,7 @@ static int __init nwbutton_init(void)
 		return -EBUSY;
 	}
 
-	if (request_irq (IRQ_NETWINDER_BUTTON, button_handler, SA_INTERRUPT,
+	if (request_irq (IRQ_NETWINDER_BUTTON, button_handler, IRQF_DISABLED,
 			"nwbutton", NULL)) {
 		printk (KERN_WARNING "nwbutton: IRQ %d is not free.\n",
 				IRQ_NETWINDER_BUTTON);
Index: linux-2.6.git/drivers/char/qtronix.c
===================================================================
--- linux-2.6.git.orig/drivers/char/qtronix.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/qtronix.c	2006-07-01 16:51:39.000000000 +0200
@@ -144,7 +144,7 @@ void __init init_qtronix_990P_kbd(void)
 	cir_port_init(cir);
 
 	retval = request_irq(IT8172_CIR0_IRQ, kbd_int_handler, 
-			(unsigned long )(SA_INTERRUPT|SA_SHIRQ), 
+			(unsigned long )(IRQF_DISABLED|IRQF_SHARED), 
 			(const char *)"Qtronix IR Keyboard", (void *)cir);
 
 	if (retval) {
Index: linux-2.6.git/drivers/char/riscom8.c
===================================================================
--- linux-2.6.git.orig/drivers/char/riscom8.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/riscom8.c	2006-07-01 16:51:39.000000000 +0200
@@ -625,7 +625,7 @@ static inline int rc_setup_board(struct 
 	if (bp->flags & RC_BOARD_ACTIVE) 
 		return 0;
 	
-	error = request_irq(bp->irq, rc_interrupt, SA_INTERRUPT,
+	error = request_irq(bp->irq, rc_interrupt, IRQF_DISABLED,
 			    "RISCom/8", NULL);
 	if (error) 
 		return error;
Index: linux-2.6.git/drivers/char/rtc.c
===================================================================
--- linux-2.6.git.orig/drivers/char/rtc.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/rtc.c	2006-07-01 16:51:39.000000000 +0200
@@ -220,7 +220,7 @@ static inline unsigned char rtc_is_updat
 
 #ifdef RTC_IRQ
 /*
- *	A very tiny interrupt handler. It runs with SA_INTERRUPT set,
+ *	A very tiny interrupt handler. It runs with IRQF_DISABLED set,
  *	but there is possibility of conflicting with the set_rtc_mmss()
  *	call (the rtc irq and the timer irq can easily run at the same
  *	time in two different CPUs). So we need to serialize
@@ -958,7 +958,7 @@ found:
 	 * XXX Interrupt pin #7 in Espresso is shared between RTC and
 	 * PCI Slot 2 INTA# (and some INTx# in Slot 1).
 	 */
-	if (request_irq(rtc_irq, rtc_interrupt, SA_SHIRQ, "rtc", (void *)&rtc_port)) {
+	if (request_irq(rtc_irq, rtc_interrupt, IRQF_SHARED, "rtc", (void *)&rtc_port)) {
 		printk(KERN_ERR "rtc: cannot register IRQ %d\n", rtc_irq);
 		return -EIO;
 	}
@@ -976,7 +976,7 @@ no_irq:
 		rtc_int_handler_ptr = rtc_interrupt;
 	}
 
-	if(request_irq(RTC_IRQ, rtc_int_handler_ptr, SA_INTERRUPT, "rtc", NULL)) {
+	if(request_irq(RTC_IRQ, rtc_int_handler_ptr, IRQF_DISABLED, "rtc", NULL)) {
 		/* Yeah right, seeing as irq 8 doesn't even hit the bus. */
 		printk(KERN_ERR "rtc: IRQ %d is not free.\n", RTC_IRQ);
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
Index: linux-2.6.git/drivers/char/s3c2410-rtc.c
===================================================================
--- linux-2.6.git.orig/drivers/char/s3c2410-rtc.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/s3c2410-rtc.c	2006-07-01 16:51:39.000000000 +0200
@@ -341,13 +341,13 @@ static int s3c2410_rtc_open(void)
 	int ret;
 
 	ret = request_irq(s3c2410_rtc_alarmno, s3c2410_rtc_alarmirq,
-			  SA_INTERRUPT,  "s3c2410-rtc alarm", NULL);
+			  IRQF_DISABLED,  "s3c2410-rtc alarm", NULL);
 
 	if (ret)
 		printk(KERN_ERR "IRQ%d already in use\n", s3c2410_rtc_alarmno);
 
 	ret = request_irq(s3c2410_rtc_tickno, s3c2410_rtc_tickirq,
-			  SA_INTERRUPT,  "s3c2410-rtc tick", NULL);
+			  IRQF_DISABLED,  "s3c2410-rtc tick", NULL);
 
 	if (ret) {
 		printk(KERN_ERR "IRQ%d already in use\n", s3c2410_rtc_tickno);
Index: linux-2.6.git/drivers/char/snsc.c
===================================================================
--- linux-2.6.git.orig/drivers/char/snsc.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/snsc.c	2006-07-01 16:51:39.000000000 +0200
@@ -105,7 +105,7 @@ scdrv_open(struct inode *inode, struct f
 
 	/* hook this subchannel up to the system controller interrupt */
 	rv = request_irq(SGI_UART_VECTOR, scdrv_interrupt,
-			 SA_SHIRQ | SA_INTERRUPT,
+			 IRQF_SHARED | IRQF_DISABLED,
 			 SYSCTL_BASENAME, sd);
 	if (rv) {
 		ia64_sn_irtr_close(sd->sd_nasid, sd->sd_subch);
Index: linux-2.6.git/drivers/char/snsc_event.c
===================================================================
--- linux-2.6.git.orig/drivers/char/snsc_event.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/snsc_event.c	2006-07-01 16:51:39.000000000 +0200
@@ -310,7 +310,7 @@ scdrv_event_init(struct sysctl_data_s *s
 
 	/* hook event subchannel up to the system controller interrupt */
 	rv = request_irq(SGI_UART_VECTOR, scdrv_event_interrupt,
-			 SA_SHIRQ | SA_INTERRUPT,
+			 IRQF_SHARED | IRQF_DISABLED,
 			 "system controller events", event_sd);
 	if (rv) {
 		printk(KERN_WARNING "%s: irq request failed (%d)\n",
Index: linux-2.6.git/drivers/char/sonypi.c
===================================================================
--- linux-2.6.git.orig/drivers/char/sonypi.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/sonypi.c	2006-07-01 16:51:39.000000000 +0200
@@ -1282,7 +1282,7 @@ static int __devinit sonypi_setup_irq(st
 	while (irq_list->irq) {
 
 		if (!request_irq(irq_list->irq, sonypi_irq,
-				 SA_SHIRQ, "sonypi", sonypi_irq)) {
+				 IRQF_SHARED, "sonypi", sonypi_irq)) {
 			dev->irq = irq_list->irq;
 			dev->bits = irq_list->bits;
 			return 0;
Index: linux-2.6.git/drivers/char/specialix.c
===================================================================
--- linux-2.6.git.orig/drivers/char/specialix.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/specialix.c	2006-07-01 16:51:39.000000000 +0200
@@ -1015,9 +1015,9 @@ static inline int sx_setup_board(struct 
 		return 0;
 
 	if (bp->flags & SX_BOARD_IS_PCI)
-		error = request_irq(bp->irq, sx_interrupt, SA_INTERRUPT | SA_SHIRQ, "specialix IO8+", bp);
+		error = request_irq(bp->irq, sx_interrupt, IRQF_DISABLED | IRQF_SHARED, "specialix IO8+", bp);
 	else
-		error = request_irq(bp->irq, sx_interrupt, SA_INTERRUPT, "specialix IO8+", bp);
+		error = request_irq(bp->irq, sx_interrupt, IRQF_DISABLED, "specialix IO8+", bp);
 
 	if (error)
 		return error;
Index: linux-2.6.git/drivers/char/stallion.c
===================================================================
--- linux-2.6.git.orig/drivers/char/stallion.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/stallion.c	2006-07-01 16:51:39.000000000 +0200
@@ -2302,7 +2302,7 @@ static inline int stl_initeio(stlbrd_t *
 	brdp->nrpanels = 1;
 	brdp->state |= BRD_FOUND;
 	brdp->hwid = status;
-	if (request_irq(brdp->irq, stl_intr, SA_SHIRQ, name, brdp) != 0) {
+	if (request_irq(brdp->irq, stl_intr, IRQF_SHARED, name, brdp) != 0) {
 		printk("STALLION: failed to register interrupt "
 		    "routine for %s irq=%d\n", name, brdp->irq);
 		rc = -ENODEV;
@@ -2512,7 +2512,7 @@ static inline int stl_initech(stlbrd_t *
 		outb((brdp->ioctrlval | ECH_BRDDISABLE), brdp->ioctrl);
 
 	brdp->state |= BRD_FOUND;
-	if (request_irq(brdp->irq, stl_intr, SA_SHIRQ, name, brdp) != 0) {
+	if (request_irq(brdp->irq, stl_intr, IRQF_SHARED, name, brdp) != 0) {
 		printk("STALLION: failed to register interrupt "
 		    "routine for %s irq=%d\n", name, brdp->irq);
 		i = -ENODEV;
Index: linux-2.6.git/drivers/char/sx.c
===================================================================
--- linux-2.6.git.orig/drivers/char/sx.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/sx.c	2006-07-01 16:51:39.000000000 +0200
@@ -1993,7 +1993,7 @@ static int sx_init_board (struct sx_boar
 		if(board->irq > 0) {
 			/* fixed irq, probably PCI */
 			if(sx_irqmask & (1 << board->irq)) { /* may we use this irq? */
-				if(request_irq(board->irq, sx_interrupt, SA_SHIRQ | SA_INTERRUPT, "sx", board)) {
+				if(request_irq(board->irq, sx_interrupt, IRQF_SHARED | IRQF_DISABLED, "sx", board)) {
 					printk(KERN_ERR "sx: Cannot allocate irq %d.\n", board->irq);
 					board->irq = 0;
 				}
@@ -2005,7 +2005,7 @@ static int sx_init_board (struct sx_boar
 			int irqmask = sx_irqmask & (IS_SX_BOARD(board) ? SX_ISA_IRQ_MASK : SI2_ISA_IRQ_MASK);
 			for(irqnr = 15; irqnr > 0; irqnr--)
 				if(irqmask & (1 << irqnr))
-					if(! request_irq(irqnr, sx_interrupt, SA_SHIRQ | SA_INTERRUPT, "sx", board))
+					if(! request_irq(irqnr, sx_interrupt, IRQF_SHARED | IRQF_DISABLED, "sx", board))
 						break;
 			if(! irqnr)
 				printk(KERN_ERR "sx: Cannot allocate IRQ.\n");
Index: linux-2.6.git/drivers/char/synclink.c
===================================================================
--- linux-2.6.git.orig/drivers/char/synclink.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/synclink.c	2006-07-01 16:51:39.000000000 +0200
@@ -8150,7 +8150,7 @@ static int __devinit synclink_init_one (
 				
 	info->bus_type = MGSL_BUS_TYPE_PCI;
 	info->io_addr_size = 8;
-	info->irq_flags = SA_SHIRQ;
+	info->irq_flags = IRQF_SHARED;
 
 	if (dev->device == 0x0210) {
 		/* Version 1 PCI9030 based universal PCI adapter */
Index: linux-2.6.git/drivers/char/synclink_gt.c
===================================================================
--- linux-2.6.git.orig/drivers/char/synclink_gt.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/synclink_gt.c	2006-07-01 16:51:39.000000000 +0200
@@ -3343,7 +3343,7 @@ static struct slgt_info *alloc_dev(int a
 		info->phys_reg_addr = pci_resource_start(pdev,0);
 
 		info->bus_type = MGSL_BUS_TYPE_PCI;
-		info->irq_flags = SA_SHIRQ;
+		info->irq_flags = IRQF_SHARED;
 
 		info->init_error = -1; /* assume error, set to 0 on successful init */
 	}
Index: linux-2.6.git/drivers/char/synclinkmp.c
===================================================================
--- linux-2.6.git.orig/drivers/char/synclinkmp.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/synclinkmp.c	2006-07-01 16:51:39.000000000 +0200
@@ -3835,7 +3835,7 @@ static SLMP_INFO *alloc_dev(int adapter_
 		info->phys_statctrl_base &= ~(PAGE_SIZE-1);
 
 		info->bus_type = MGSL_BUS_TYPE_PCI;
-		info->irq_flags = SA_SHIRQ;
+		info->irq_flags = IRQF_SHARED;
 
 		init_timer(&info->tx_timer);
 		info->tx_timer.data = (unsigned long)info;
Index: linux-2.6.git/drivers/char/tlclk.c
===================================================================
--- linux-2.6.git.orig/drivers/char/tlclk.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/tlclk.c	2006-07-01 16:51:39.000000000 +0200
@@ -208,7 +208,7 @@ static int tlclk_open(struct inode *inod
 	/* This device is wired through the FPGA IO space of the ATCA blade
 	 * we can't share this IRQ */
 	result = request_irq(telclk_interrupt, &tlclk_interrupt,
-			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
+			     IRQF_DISABLED, "telco_clock", tlclk_interrupt);
 	if (result == -EBUSY) {
 		printk(KERN_ERR "tlclk: Interrupt can't be reserved.\n");
 		return -EBUSY;
Index: linux-2.6.git/drivers/char/vme_scc.c
===================================================================
--- linux-2.6.git.orig/drivers/char/vme_scc.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/vme_scc.c	2006-07-01 16:51:39.000000000 +0200
@@ -203,13 +203,13 @@ static int mvme147_scc_init(void)
 	port->datap = port->ctrlp + 1;
 	port->port_a = &scc_ports[0];
 	port->port_b = &scc_ports[1];
-	request_irq(MVME147_IRQ_SCCA_TX, scc_tx_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCA_TX, scc_tx_int, IRQF_DISABLED,
 		            "SCC-A TX", port);
-	request_irq(MVME147_IRQ_SCCA_STAT, scc_stat_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCA_STAT, scc_stat_int, IRQF_DISABLED,
 		            "SCC-A status", port);
-	request_irq(MVME147_IRQ_SCCA_RX, scc_rx_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCA_RX, scc_rx_int, IRQF_DISABLED,
 		            "SCC-A RX", port);
-	request_irq(MVME147_IRQ_SCCA_SPCOND, scc_spcond_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCA_SPCOND, scc_spcond_int, IRQF_DISABLED,
 		            "SCC-A special cond", port);
 	{
 		SCC_ACCESS_INIT(port);
@@ -230,13 +230,13 @@ static int mvme147_scc_init(void)
 	port->datap = port->ctrlp + 1;
 	port->port_a = &scc_ports[0];
 	port->port_b = &scc_ports[1];
-	request_irq(MVME147_IRQ_SCCB_TX, scc_tx_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCB_TX, scc_tx_int, IRQF_DISABLED,
 		            "SCC-B TX", port);
-	request_irq(MVME147_IRQ_SCCB_STAT, scc_stat_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCB_STAT, scc_stat_int, IRQF_DISABLED,
 		            "SCC-B status", port);
-	request_irq(MVME147_IRQ_SCCB_RX, scc_rx_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCB_RX, scc_rx_int, IRQF_DISABLED,
 		            "SCC-B RX", port);
-	request_irq(MVME147_IRQ_SCCB_SPCOND, scc_spcond_int, SA_INTERRUPT,
+	request_irq(MVME147_IRQ_SCCB_SPCOND, scc_spcond_int, IRQF_DISABLED,
 		            "SCC-B special cond", port);
 	{
 		SCC_ACCESS_INIT(port);
@@ -273,13 +273,13 @@ static int mvme162_scc_init(void)
 	port->datap = port->ctrlp + 2;
 	port->port_a = &scc_ports[0];
 	port->port_b = &scc_ports[1];
-	request_irq(MVME162_IRQ_SCCA_TX, scc_tx_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCA_TX, scc_tx_int, IRQF_DISABLED,
 		            "SCC-A TX", port);
-	request_irq(MVME162_IRQ_SCCA_STAT, scc_stat_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCA_STAT, scc_stat_int, IRQF_DISABLED,
 		            "SCC-A status", port);
-	request_irq(MVME162_IRQ_SCCA_RX, scc_rx_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCA_RX, scc_rx_int, IRQF_DISABLED,
 		            "SCC-A RX", port);
-	request_irq(MVME162_IRQ_SCCA_SPCOND, scc_spcond_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCA_SPCOND, scc_spcond_int, IRQF_DISABLED,
 		            "SCC-A special cond", port);
 	{
 		SCC_ACCESS_INIT(port);
@@ -300,13 +300,13 @@ static int mvme162_scc_init(void)
 	port->datap = port->ctrlp + 2;
 	port->port_a = &scc_ports[0];
 	port->port_b = &scc_ports[1];
-	request_irq(MVME162_IRQ_SCCB_TX, scc_tx_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCB_TX, scc_tx_int, IRQF_DISABLED,
 		            "SCC-B TX", port);
-	request_irq(MVME162_IRQ_SCCB_STAT, scc_stat_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCB_STAT, scc_stat_int, IRQF_DISABLED,
 		            "SCC-B status", port);
-	request_irq(MVME162_IRQ_SCCB_RX, scc_rx_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCB_RX, scc_rx_int, IRQF_DISABLED,
 		            "SCC-B RX", port);
-	request_irq(MVME162_IRQ_SCCB_SPCOND, scc_spcond_int, SA_INTERRUPT,
+	request_irq(MVME162_IRQ_SCCB_SPCOND, scc_spcond_int, IRQF_DISABLED,
 		            "SCC-B special cond", port);
 
 	{
@@ -341,13 +341,13 @@ static int bvme6000_scc_init(void)
 	port->datap = port->ctrlp + 4;
 	port->port_a = &scc_ports[0];
 	port->port_b = &scc_ports[1];
-	request_irq(BVME_IRQ_SCCA_TX, scc_tx_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCA_TX, scc_tx_int, IRQF_DISABLED,
 		            "SCC-A TX", port);
-	request_irq(BVME_IRQ_SCCA_STAT, scc_stat_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCA_STAT, scc_stat_int, IRQF_DISABLED,
 		            "SCC-A status", port);
-	request_irq(BVME_IRQ_SCCA_RX, scc_rx_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCA_RX, scc_rx_int, IRQF_DISABLED,
 		            "SCC-A RX", port);
-	request_irq(BVME_IRQ_SCCA_SPCOND, scc_spcond_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCA_SPCOND, scc_spcond_int, IRQF_DISABLED,
 		            "SCC-A special cond", port);
 	{
 		SCC_ACCESS_INIT(port);
@@ -368,13 +368,13 @@ static int bvme6000_scc_init(void)
 	port->datap = port->ctrlp + 4;
 	port->port_a = &scc_ports[0];
 	port->port_b = &scc_ports[1];
-	request_irq(BVME_IRQ_SCCB_TX, scc_tx_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCB_TX, scc_tx_int, IRQF_DISABLED,
 		            "SCC-B TX", port);
-	request_irq(BVME_IRQ_SCCB_STAT, scc_stat_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCB_STAT, scc_stat_int, IRQF_DISABLED,
 		            "SCC-B status", port);
-	request_irq(BVME_IRQ_SCCB_RX, scc_rx_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCB_RX, scc_rx_int, IRQF_DISABLED,
 		            "SCC-B RX", port);
-	request_irq(BVME_IRQ_SCCB_SPCOND, scc_spcond_int, SA_INTERRUPT,
+	request_irq(BVME_IRQ_SCCB_SPCOND, scc_spcond_int, IRQF_DISABLED,
 		            "SCC-B special cond", port);
 
 	{
Index: linux-2.6.git/drivers/char/ftape/lowlevel/fdc-io.c
===================================================================
--- linux-2.6.git.orig/drivers/char/ftape/lowlevel/fdc-io.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/ftape/lowlevel/fdc-io.c	2006-07-01 16:51:39.000000000 +0200
@@ -1268,7 +1268,7 @@ static int fdc_grab_irq_and_dma(void)
 		/*  Get fast interrupt handler.
 		 */
 		if (request_irq(fdc.irq, ftape_interrupt,
-				SA_INTERRUPT, "ft", ftape_id)) {
+				IRQF_DISABLED, "ft", ftape_id)) {
 			TRACE_ABORT(-EIO, ft_t_bug,
 				    "Unable to grab IRQ%d for ftape driver",
 				    fdc.irq);
Index: linux-2.6.git/drivers/char/ip2/ip2main.c
===================================================================
--- linux-2.6.git.orig/drivers/char/ip2/ip2main.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/ip2/ip2main.c	2006-07-01 16:51:39.000000000 +0200
@@ -491,8 +491,8 @@ static struct tty_operations ip2_ops = {
 /* initialisation of the devices and driver structures, and registers itself  */
 /* with the relevant kernel modules.                                          */
 /******************************************************************************/
-/* SA_INTERRUPT- if set blocks all interrupts else only this line */
-/* SA_SHIRQ    - for shared irq PCI or maybe EISA only */
+/* IRQF_DISABLED - if set blocks all interrupts else only this line */
+/* IRQF_SHARED    - for shared irq PCI or maybe EISA only */
 /* SA_RANDOM   - can be source for cert. random number generators */
 #define IP2_SA_FLAGS	0
 
@@ -753,7 +753,7 @@ retry:
 				if (have_requested_irq(ip2config.irq[i]))
 					continue;
 				rc = request_irq( ip2config.irq[i], ip2_interrupt,
-					IP2_SA_FLAGS | (ip2config.type[i] == PCI ? SA_SHIRQ : 0),
+					IP2_SA_FLAGS | (ip2config.type[i] == PCI ? IRQF_SHARED : 0),
 					pcName, (void *)&pcName);
 				if (rc) {
 					printk(KERN_ERR "IP2: an request_irq failed: error %d\n",rc);
Index: linux-2.6.git/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.git.orig/drivers/char/ipmi/ipmi_si_intf.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/ipmi/ipmi_si_intf.c	2006-07-01 16:51:39.000000000 +0200
@@ -1041,7 +1041,7 @@ static int std_irq_setup(struct smi_info
 	if (info->si_type == SI_BT) {
 		rv = request_irq(info->irq,
 				 si_bt_irq_handler,
-				 SA_INTERRUPT,
+				 IRQF_DISABLED,
 				 DEVICE_NAME,
 				 info);
 		if (!rv)
@@ -1051,7 +1051,7 @@ static int std_irq_setup(struct smi_info
 	} else
 		rv = request_irq(info->irq,
 				 si_irq_handler,
-				 SA_INTERRUPT,
+				 IRQF_DISABLED,
 				 DEVICE_NAME,
 				 info);
 	if (rv) {
Index: linux-2.6.git/drivers/char/tpm/tpm_tis.c
===================================================================
--- linux-2.6.git.orig/drivers/char/tpm/tpm_tis.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/tpm/tpm_tis.c	2006-07-01 16:51:39.000000000 +0200
@@ -522,7 +522,7 @@ static int __devinit tpm_tis_pnp_init(st
 			iowrite8(i, chip->vendor.iobase +
 				    TPM_INT_VECTOR(chip->vendor.locality));
 			if (request_irq
-			    (i, tis_int_probe, SA_SHIRQ,
+			    (i, tis_int_probe, IRQF_SHARED,
 			     chip->vendor.miscdev.name, chip) != 0) {
 				dev_info(chip->dev,
 					 "Unable to request irq: %d for probe\n",
@@ -557,7 +557,7 @@ static int __devinit tpm_tis_pnp_init(st
 			 chip->vendor.iobase +
 			 TPM_INT_VECTOR(chip->vendor.locality));
 		if (request_irq
-		    (chip->vendor.irq, tis_int_handler, SA_SHIRQ,
+		    (chip->vendor.irq, tis_int_handler, IRQF_SHARED,
 		     chip->vendor.miscdev.name, chip) != 0) {
 			dev_info(chip->dev,
 				 "Unable to request irq: %d for use\n",
Index: linux-2.6.git/drivers/char/watchdog/eurotechwdt.c
===================================================================
--- linux-2.6.git.orig/drivers/char/watchdog/eurotechwdt.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/watchdog/eurotechwdt.c	2006-07-01 16:51:39.000000000 +0200
@@ -420,7 +420,7 @@ static int __init eurwdt_init(void)
 		goto out;
 	}
 
-	ret = request_irq(irq, eurwdt_interrupt, SA_INTERRUPT, "eurwdt", NULL);
+	ret = request_irq(irq, eurwdt_interrupt, IRQF_DISABLED, "eurwdt", NULL);
 	if(ret) {
 		printk(KERN_ERR "eurwdt: IRQ %d is not free.\n", irq);
 		goto outmisc;
Index: linux-2.6.git/drivers/char/watchdog/mpcore_wdt.c
===================================================================
--- linux-2.6.git.orig/drivers/char/watchdog/mpcore_wdt.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/watchdog/mpcore_wdt.c	2006-07-01 16:51:39.000000000 +0200
@@ -355,7 +355,7 @@ static int __devinit mpcore_wdt_probe(st
 		goto err_misc;
 	}
 
-	ret = request_irq(wdt->irq, mpcore_wdt_fire, SA_INTERRUPT, "mpcore_wdt", wdt);
+	ret = request_irq(wdt->irq, mpcore_wdt_fire, IRQF_DISABLED, "mpcore_wdt", wdt);
 	if (ret) {
 		dev_printk(KERN_ERR, _dev, "cannot register IRQ%d for watchdog\n", wdt->irq);
 		goto err_irq;
Index: linux-2.6.git/drivers/char/watchdog/wdt.c
===================================================================
--- linux-2.6.git.orig/drivers/char/watchdog/wdt.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/watchdog/wdt.c	2006-07-01 16:51:39.000000000 +0200
@@ -580,7 +580,7 @@ static int __init wdt_init(void)
 		goto out;
 	}
 
-	ret = request_irq(irq, wdt_interrupt, SA_INTERRUPT, "wdt501p", NULL);
+	ret = request_irq(irq, wdt_interrupt, IRQF_DISABLED, "wdt501p", NULL);
 	if(ret) {
 		printk(KERN_ERR "wdt: IRQ %d is not free.\n", irq);
 		goto outreg;
Index: linux-2.6.git/drivers/char/watchdog/wdt_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/char/watchdog/wdt_pci.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/watchdog/wdt_pci.c	2006-07-01 16:51:39.000000000 +0200
@@ -617,7 +617,7 @@ static int __devinit wdtpci_init_one (st
 		goto out_pci;
 	}
 
-	if (request_irq (irq, wdtpci_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	if (request_irq (irq, wdtpci_interrupt, IRQF_DISABLED | IRQF_SHARED,
 			 "wdt_pci", &wdtpci_miscdev)) {
 		printk (KERN_ERR PFX "IRQ %d is not free\n", irq);
 		goto out_reg;
Index: linux-2.6.git/drivers/char/mmtimer.c
===================================================================
--- linux-2.6.git.orig/drivers/char/mmtimer.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/char/mmtimer.c	2006-07-01 16:51:39.000000000 +0200
@@ -687,7 +687,7 @@ static int __init mmtimer_init(void)
 	mmtimer_femtoperiod = ((unsigned long)1E15 + sn_rtc_cycles_per_second /
 			       2) / sn_rtc_cycles_per_second;
 
-	if (request_irq(SGI_MMTIMER_VECTOR, mmtimer_interrupt, SA_PERCPU_IRQ, MMTIMER_NAME, NULL)) {
+	if (request_irq(SGI_MMTIMER_VECTOR, mmtimer_interrupt, IRQF_PERCPU, MMTIMER_NAME, NULL)) {
 		printk(KERN_WARNING "%s: unable to allocate interrupt.",
 			MMTIMER_NAME);
 		return -1;

--

