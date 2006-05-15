Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWEOV5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWEOV5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWEOV5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:57:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:31107 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964952AbWEOV5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ScjGY8cqCuTiAgwgg/XwFIYtyqLrc3/i9SxTSUJ/1Yl/pVBMv5EFQ8GcdAtd8v9k3AoZBRiSZ+EG7NbTUc5rDWA9K93Ri+EwFKnqqhlVaKo9pNmexMykqhFEYbJ952Zm8882nSsljXCs024ndii3d9AIuXwg1LdWs3CWLiQ4cLg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] moxa: partial CodingStyle cleanup & spelling fixes
Date: Mon, 15 May 2006 23:57:50 +0200
User-Agent: KMail/1.9.1
Cc: Moxa Technologies <support@moxa.com.tw>, Alan Cox <alan@redhat.com>,
       Martin Mares <mj@ucw.cz>, Alexey Dobriyan <adobriyan@gmail.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152357.50871.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do a *partial* CodingStyle cleanup, 
correct some spelling in printk()'s &&
convert C++ comments to C comments -
in moxa driver.

(applies on top of patch 2/3 - can easily be left out if unwanted)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/mxser.c |  794 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 450 insertions(+), 344 deletions(-)

--- linux-2.6.17-rc4-mm1/drivers/char/mxser.c.2	2006-05-15 22:35:18.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/char/mxser.c	2006-05-15 23:45:00.000000000 +0200
@@ -9,7 +9,7 @@
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
  *      the Free Software Foundation; either version 2 of the License, or
-*      (at your option) any later version.
+ *      (at your option) any later version.
  *
  *      This program is distributed in the hope that it will be useful,
  *      but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -71,8 +71,8 @@
 #define	MXSERMAJOR	 174
 #define	MXSERCUMAJOR	 175
 
-#define	MXSER_EVENT_TXLOW	 1
-#define	MXSER_EVENT_HANGUP	 2
+#define	MXSER_EVENT_TXLOW	1
+#define	MXSER_EVENT_HANGUP	2
 
 #define MXSER_BOARDS		4	/* Max. boards */
 #define MXSER_PORTS		32	/* Max. ports */
@@ -92,7 +92,8 @@
 #define UART_MCR_AFE		0x20
 #define UART_LSR_SPECIAL	0x1E
 
-#define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|IXON|IXOFF))
+#define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|\
+					  IXON|IXOFF))
 
 #define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? SA_SHIRQ : SA_INTERRUPT)
 
@@ -152,27 +153,27 @@ static char *mxser_brdname[] = {
 };
 
 static int mxser_numports[] = {
-	8,			// C168-ISA
-	4,			// C104-ISA
-	4,			// CI104J
-	8,			// C168-PCI
-	4,			// C104-PCI
-	2,			// C102-ISA
-	2,			// CI132
-	4,			// CI134
-	2,			// CP132
-	4,			// CP114
-	4,			// CT114
-	2,			// CP102
-	4,			// CP104U
-	8,			// CP168U
-	2,			// CP132U
-	4,			// CP134U
-	4,			// CP104JU
-	8,			// RC7000
-	8,			// CP118U 
-	2,			// CP102UL 
-	2,			// CP102U
+	8,			/* C168-ISA */
+	4,			/* C104-ISA */
+	4,			/* CI104J */
+	8,			/* C168-PCI */
+	4,			/* C104-PCI */
+	2,			/* C102-ISA */
+	2,			/* CI132 */
+	4,			/* CI134 */
+	2,			/* CP132 */
+	4,			/* CP114 */
+	4,			/* CT114 */
+	2,			/* CP102 */
+	4,			/* CP104U */
+	8,			/* CP168U */
+	2,			/* CP132U */
+	4,			/* CP134U */
+	4,			/* CP104JU */
+	8,			/* RC7000 */
+	8,			/* CP118U */
+	2,			/* CP102UL */
+	2,			/* CP102U */
 };
 
 #define UART_TYPE_NUM	2
@@ -182,7 +183,7 @@ static const unsigned int Gmoxa_uart_id[
 	MOXA_MUST_MU860_HWID
 };
 
-// This is only for PCI
+/* This is only for PCI */
 #define UART_INFO_NUM	3
 struct mxpciuart_info {
 	int type;
@@ -231,7 +232,7 @@ MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
 typedef struct _moxa_pci_info {
 	unsigned short busNum;
 	unsigned short devNum;
-	struct pci_dev *pdev;	// add by Victor Yu. 06-23-2003
+	struct pci_dev *pdev;	/* add by Victor Yu. 06-23-2003 */
 } moxa_pci_info;
 
 static int ioaddr[MXSER_BOARDS] = { 0, 0, 0, 0 };
@@ -280,6 +281,7 @@ struct mxser_mon_ext {
 	int fifo[32];
 	int iftype[32];
 };
+
 struct mxser_hwconf {
 	int board_type;
 	int ports;
@@ -290,9 +292,9 @@ struct mxser_hwconf {
 	int ioaddr[MXSER_PORTS_PER_BOARD];
 	int baud_base[MXSER_PORTS_PER_BOARD];
 	moxa_pci_info pciInfo;
-	int IsMoxaMustChipFlag;	// add by Victor Yu. 08-30-2002
-	int MaxCanSetBaudRate[MXSER_PORTS_PER_BOARD];	// add by Victor Yu. 09-04-2002
-	int opmode_ioaddr[MXSER_PORTS_PER_BOARD];	// add by Victor Yu. 01-05-2004
+	int IsMoxaMustChipFlag;	/* add by Victor Yu. 08-30-2002 */
+	int MaxCanSetBaudRate[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 09-04-2002 */
+	int opmode_ioaddr[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 01-05-2004 */
 };
 
 struct mxser_struct {
@@ -334,9 +336,9 @@ struct mxser_struct {
 	wait_queue_head_t delta_msr_wait;
 	struct async_icount icount;	/* kernel counters for the 4 input interrupts */
 	int timeout;
-	int IsMoxaMustChipFlag;	// add by Victor Yu. 08-30-2002
-	int MaxCanSetBaudRate;	// add by Victor Yu. 09-04-2002
-	int opmode_ioaddr;	// add by Victor Yu. 01-05-2004
+	int IsMoxaMustChipFlag;	/* add by Victor Yu. 08-30-2002 */
+	int MaxCanSetBaudRate;	/* add by Victor Yu. 09-04-2002 */
+	int opmode_ioaddr;	/* add by Victor Yu. 01-05-2004 */
 	unsigned char stop_rx;
 	unsigned char ldisc_stop_rx;
 	long realbaud;
@@ -345,7 +347,6 @@ struct mxser_struct {
 	spinlock_t slock;
 };
 
-
 struct mxser_mstatus {
 	tcflag_t cflag;
 	int cts;
@@ -358,7 +359,7 @@ static struct mxser_mstatus GMStatus[MXS
 
 static int mxserBoardCAP[MXSER_BOARDS] = {
 	0, 0, 0, 0
-	    /*  0x180, 0x280, 0x200, 0x320   */
+	/*  0x180, 0x280, 0x200, 0x320 */
 };
 
 static struct tty_driver *mxvar_sdriver;
@@ -386,7 +387,7 @@ static struct mxser_hwconf mxsercfg[MXSE
 static void mxser_getcfg(int board, struct mxser_hwconf *hwconf);
 static int mxser_init(void);
 
-//static void   mxser_poll(unsigned long);
+/* static void   mxser_poll(unsigned long); */
 static int mxser_get_ISA_conf(int, struct mxser_hwconf *);
 static int mxser_get_PCI_conf(int, int, int, struct mxser_hwconf *);
 static void mxser_do_softint(void *);
@@ -440,18 +441,18 @@ static int CheckIsMoxaMust(int io)
 	SET_MOXA_MUST_XON1_VALUE(io, 0x11);
 	if ((hwid = inb(io + UART_MCR)) != 0) {
 		outb(oldmcr, io + UART_MCR);
-		return (MOXA_OTHER_UART);
+		return MOXA_OTHER_UART;
 	}
 
 	GET_MOXA_MUST_HARDWARE_ID(io, &hwid);
 	for (i = 0; i < UART_TYPE_NUM; i++) {
 		if (hwid == Gmoxa_uart_id[i])
-			return (int) hwid;
+			return (int)hwid;
 	}
 	return MOXA_OTHER_UART;
 }
 
-// above is modified by Victor Yu. 08-15-2002
+/* above is modified by Victor Yu. 08-15-2002 */
 
 static struct tty_operations mxser_ops = {
 	.open = mxser_open,
@@ -504,7 +505,6 @@ static void __exit mxser_module_exit(voi
 	else
 		printk(KERN_ERR "Couldn't unregister MOXA Smartio/Industio family serial driver\n");
 
-
 	for (i = 0; i < MXSER_BOARDS; i++) {
 		struct pci_dev *pdev;
 
@@ -513,7 +513,7 @@ static void __exit mxser_module_exit(voi
 		else {
 			pdev = mxsercfg[i].pciInfo.pdev;
 			free_irq(mxsercfg[i].irq, &mxvar_table[i * MXSER_PORTS_PER_BOARD]);
-			if (pdev != NULL) {	//PCI
+			if (pdev != NULL) {	/* PCI */
 				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
 				release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
 			} else {
@@ -524,7 +524,6 @@ static void __exit mxser_module_exit(voi
 	}
 	if (verbose)
 		printk(KERN_DEBUG "Done.\n");
-
 }
 
 static void process_txrx_fifo(struct mxser_struct *info)
@@ -558,8 +557,10 @@ static int mxser_initbrd(int board, stru
 	n = board * MXSER_PORTS_PER_BOARD;
 	info = &mxvar_table[n];
 	/*if (verbose) */  {
-		printk(KERN_DEBUG "        ttyM%d - ttyM%d ", n, n + hwconf->ports - 1);
-		printk(" max. baud rate = %d bps.\n", hwconf->MaxCanSetBaudRate[0]);
+		printk(KERN_DEBUG "        ttyM%d - ttyM%d ",
+			n, n + hwconf->ports - 1);
+		printk(" max. baud rate = %d bps.\n",
+			hwconf->MaxCanSetBaudRate[0]);
 	}
 
 	for (i = 0; i < hwconf->ports; i++, n++, info++) {
@@ -568,12 +569,12 @@ static int mxser_initbrd(int board, stru
 		info->irq = hwconf->irq;
 		info->vector = hwconf->vector;
 		info->vectormask = hwconf->vector_mask;
-		info->opmode_ioaddr = hwconf->opmode_ioaddr[i];	// add by Victor Yu. 01-05-2004
+		info->opmode_ioaddr = hwconf->opmode_ioaddr[i];	/* add by Victor Yu. 01-05-2004 */
 		info->stop_rx = 0;
 		info->ldisc_stop_rx = 0;
 
 		info->IsMoxaMustChipFlag = hwconf->IsMoxaMustChipFlag;
-		//Enhance mode enabled here
+		/* Enhance mode enabled here */
 		if (info->IsMoxaMustChipFlag != MOXA_OTHER_UART) {
 			ENABLE_MOXA_MUST_ENCHANCE_MODE(info->base);
 		}
@@ -606,22 +607,25 @@ static int mxser_initbrd(int board, stru
 
 	/* before set INT ISR, disable all int */
 	for (i = 0; i < hwconf->ports; i++) {
-		outb(inb(hwconf->ioaddr[i] + UART_IER) & 0xf0, hwconf->ioaddr[i] + UART_IER);
+		outb(inb(hwconf->ioaddr[i] + UART_IER) & 0xf0,
+			hwconf->ioaddr[i] + UART_IER);
 	}
 
 	n = board * MXSER_PORTS_PER_BOARD;
 	info = &mxvar_table[n];
 
-	retval = request_irq(hwconf->irq, mxser_interrupt, IRQ_T(info), "mxser", info);
+	retval = request_irq(hwconf->irq, mxser_interrupt, IRQ_T(info),
+				"mxser", info);
 	if (retval) {
-		printk(KERN_ERR "Board %d: %s", board, mxser_brdname[hwconf->board_type - 1]);
-		printk("  Request irq fail,IRQ (%d) may be conflit with another device.\n", info->irq);
+		printk(KERN_ERR "Board %d: %s",
+			board, mxser_brdname[hwconf->board_type - 1]);
+		printk("  Request irq failed, IRQ (%d) may conflict with"
+			" another device.\n", info->irq);
 		return retval;
 	}
 	return 0;
 }
 
-
 static void mxser_getcfg(int board, struct mxser_hwconf *hwconf)
 {
 	mxsercfg[board] = *hwconf;
@@ -631,26 +635,27 @@ static void mxser_getcfg(int board, stru
 static int mxser_get_PCI_conf(int busnum, int devnum, int board_type, struct mxser_hwconf *hwconf)
 {
 	int i, j;
-//      unsigned int    val;
+	/* unsigned int val; */
 	unsigned int ioaddress;
 	struct pci_dev *pdev = hwconf->pciInfo.pdev;
 
-	//io address
+	/* io address */
 	hwconf->board_type = board_type;
 	hwconf->ports = mxser_numports[board_type - 1];
 	ioaddress = pci_resource_start(pdev, 2);
-	request_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2), "mxser(IO)");
+	request_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2),
+			"mxser(IO)");
 
-	for (i = 0; i < hwconf->ports; i++) {
+	for (i = 0; i < hwconf->ports; i++)
 		hwconf->ioaddr[i] = ioaddress + 8 * i;
-	}
 
-	//vector
+	/* vector */
 	ioaddress = pci_resource_start(pdev, 3);
-	request_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3), "mxser(vector)");
+	request_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3),
+			"mxser(vector)");
 	hwconf->vector = ioaddress;
 
-	//irq
+	/* irq */
 	hwconf->irq = hwconf->pciInfo.pdev->irq;
 
 	hwconf->IsMoxaMustChipFlag = CheckIsMoxaMust(hwconf->ioaddr[0]);
@@ -663,7 +668,7 @@ static int mxser_get_PCI_conf(int busnum
 			if (Gpci_uart_info[j].type == hwconf->IsMoxaMustChipFlag) {
 				hwconf->MaxCanSetBaudRate[i] = Gpci_uart_info[j].max_baud;
 
-				//exception....CP-102
+				/* exception....CP-102 */
 				if (board_type == MXSER_BOARD_CP102)
 					hwconf->MaxCanSetBaudRate[i] = 921600;
 				break;
@@ -678,15 +683,15 @@ static int mxser_get_PCI_conf(int busnum
 			else
 				hwconf->opmode_ioaddr[i] = ioaddress + 0x0c;
 		}
-		outb(0, ioaddress + 4);	// default set to RS232 mode
-		outb(0, ioaddress + 0x0c);	//default set to RS232 mode
+		outb(0, ioaddress + 4);	/* default set to RS232 mode */
+		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
 	}
 
 	for (i = 0; i < hwconf->ports; i++) {
 		hwconf->vector_mask |= (1 << i);
 		hwconf->baud_base[i] = 921600;
 	}
-	return (0);
+	return 0;
 }
 #endif
 
@@ -707,7 +712,8 @@ static int mxser_init(void)
 		mxsercfg[i].board_type = -1;
 	}
 
-	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n", MXSER_VERSION);
+	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
+		MXSER_VERSION);
 
 	/* Initialize the tty_driver structure */
 	memset(mxvar_sdriver, 0, sizeof(struct tty_driver));
@@ -719,7 +725,7 @@ static int mxser_init(void)
 	mxvar_sdriver->type = TTY_DRIVER_TYPE_SERIAL;
 	mxvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
 	mxvar_sdriver->init_termios = tty_std_termios;
-	mxvar_sdriver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
 	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(mxvar_sdriver, &mxser_ops);
 	mxvar_sdriver->ttys = mxvar_tty;
@@ -739,23 +745,29 @@ static int mxser_init(void)
 	/* Start finding ISA boards here */
 	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
 		int cap;
+
 		if (!(cap = mxserBoardCAP[b]))
 			continue;
 
 		retval = mxser_get_ISA_conf(cap, &hwconf);
 
 		if (retval != 0)
-			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n", mxser_brdname[hwconf.board_type - 1], ioaddr[b]);
+			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
+				mxser_brdname[hwconf.board_type - 1], ioaddr[b]);
 
 		if (retval <= 0) {
 			if (retval == MXSER_ERR_IRQ)
-				printk(KERN_ERR "Invalid interrupt number,board not configured\n");
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
 			else if (retval == MXSER_ERR_IRQ_CONFLIT)
-				printk(KERN_ERR "Invalid interrupt number,board not configured\n");
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
 			else if (retval == MXSER_ERR_VECTOR)
-				printk(KERN_ERR "Invalid interrupt vector,board not configured\n");
+				printk(KERN_ERR "Invalid interrupt vector, "
+					"board not configured\n");
 			else if (retval == MXSER_ERR_IOADDR)
-				printk(KERN_ERR "Invalid I/O address,board not configured\n");
+				printk(KERN_ERR "Invalid I/O address, "
+					"board not configured\n");
 
 			continue;
 		}
@@ -765,35 +777,43 @@ static int mxser_init(void)
 		hwconf.pciInfo.pdev = NULL;
 
 		mxser_getcfg(m, &hwconf);
-		//init mxsercfg first, or mxsercfg data is not correct on ISR.
-		//mxser_initbrd will hook ISR.
+		/*
+		 * init mxsercfg first,
+		 * or mxsercfg data is not correct on ISR.
+		 */
+		/* mxser_initbrd will hook ISR. */
 		if (mxser_initbrd(m, &hwconf) < 0)
 			continue;
 
-
 		m++;
 	}
 
 	/* Start finding ISA boards from module arg */
 	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
 		int cap;
+
 		if (!(cap = ioaddr[b]))
 			continue;
 
 		retval = mxser_get_ISA_conf(cap, &hwconf);
 
 		if (retval != 0)
-			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n", mxser_brdname[hwconf.board_type - 1], ioaddr[b]);
+			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
+				mxser_brdname[hwconf.board_type - 1], ioaddr[b]);
 
 		if (retval <= 0) {
 			if (retval == MXSER_ERR_IRQ)
-				printk(KERN_ERR "Invalid interrupt number,board not configured\n");
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
 			else if (retval == MXSER_ERR_IRQ_CONFLIT)
-				printk(KERN_ERR "Invalid interrupt number,board not configured\n");
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
 			else if (retval == MXSER_ERR_VECTOR)
-				printk(KERN_ERR "Invalid interrupt vector,board not configured\n");
+				printk(KERN_ERR "Invalid interrupt vector, "
+					"board not configured\n");
 			else if (retval == MXSER_ERR_IOADDR)
-				printk(KERN_ERR "Invalid I/O address,board not configured\n");
+				printk(KERN_ERR "Invalid I/O address, "
+					"board not configured\n");
 
 			continue;
 		}
@@ -803,8 +823,11 @@ static int mxser_init(void)
 		hwconf.pciInfo.pdev = NULL;
 
 		mxser_getcfg(m, &hwconf);
-		//init mxsercfg first, or mxsercfg data is not correct on ISR.
-		//mxser_initbrd will hook ISR.
+		/*
+		 * init mxsercfg first,
+		 * or mxsercfg data is not correct on ISR.
+		 */
+		/* mxser_initbrd will hook ISR. */
 		if (mxser_initbrd(m, &hwconf) < 0)
 			continue;
 
@@ -817,7 +840,8 @@ static int mxser_init(void)
 	index = 0;
 	b = 0;
 	while (b < n) {
-		pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev);
+		pdev = pci_find_device(mxser_pcibrds[b].vendor,
+				mxser_pcibrds[b].device, pdev);
 			if (pdev == NULL) {
 			b++;
 			continue;
@@ -825,30 +849,48 @@ static int mxser_init(void)
 		hwconf.pciInfo.busNum = busnum = pdev->bus->number;
 		hwconf.pciInfo.devNum = devnum = PCI_SLOT(pdev->devfn) << 3;
 		hwconf.pciInfo.pdev = pdev;
-		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n", mxser_brdname[(int) (mxser_pcibrds[b].driver_data) - 1], busnum, devnum >> 3);
+		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
+			mxser_brdname[(int) (mxser_pcibrds[b].driver_data) - 1],
+			busnum, devnum >> 3);
 		index++;
-		if (m >= MXSER_BOARDS) {
-			printk(KERN_ERR "Too many Smartio/Industio family boards find (maximum %d),board not configured\n", MXSER_BOARDS);
-		} else {
+		if (m >= MXSER_BOARDS)
+			printk(KERN_ERR
+				"Too many Smartio/Industio family boards find "
+				"(maximum %d), board not configured\n",
+				MXSER_BOARDS);
+		else {
 			if (pci_enable_device(pdev)) {
-				printk(KERN_ERR "Moxa SmartI/O PCI enable fail !\n");
+				printk(KERN_ERR "Moxa SmartI/O PCI enable "
+					"fail !\n");
 				continue;
 			}
-			retval = mxser_get_PCI_conf(busnum, devnum, (int) mxser_pcibrds[b].driver_data, &hwconf);
+			retval = mxser_get_PCI_conf(busnum, devnum,
+					(int)mxser_pcibrds[b].driver_data,
+					&hwconf);
 			if (retval < 0) {
 				if (retval == MXSER_ERR_IRQ)
-					printk(KERN_ERR "Invalid interrupt number,board not configured\n");
+					printk(KERN_ERR
+						"Invalid interrupt number, "
+						"board not configured\n");
 				else if (retval == MXSER_ERR_IRQ_CONFLIT)
-					printk(KERN_ERR "Invalid interrupt number,board not configured\n");
+					printk(KERN_ERR
+						"Invalid interrupt number, "
+						"board not configured\n");
 				else if (retval == MXSER_ERR_VECTOR)
-					printk(KERN_ERR "Invalid interrupt vector,board not configured\n");
+					printk(KERN_ERR
+						"Invalid interrupt vector, "
+						"board not configured\n");
 				else if (retval == MXSER_ERR_IOADDR)
-					printk(KERN_ERR "Invalid I/O address,board not configured\n");
+					printk(KERN_ERR
+						"Invalid I/O address, "
+						"board not configured\n");
 				continue;
 			}
 			mxser_getcfg(m, &hwconf);
-			//init mxsercfg first, or mxsercfg data is not correct on ISR.
-			//mxser_initbrd will hook ISR.
+			/* init mxsercfg first,
+			 * or mxsercfg data is not correct on ISR.
+			 */
+			/* mxser_initbrd will hook ISR. */
 			if (mxser_initbrd(m, &hwconf) < 0)
 				continue;
 			m++;
@@ -858,7 +900,8 @@ static int mxser_init(void)
 
 	retval = tty_register_driver(mxvar_sdriver);
 	if (retval) {
-		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family driver !\n");
+		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family"
+				" driver !\n");
 		put_tty_driver(mxvar_sdriver);
 
 		for (i = 0; i < MXSER_BOARDS; i++) {
@@ -866,7 +909,7 @@ static int mxser_init(void)
 				continue;
 			else {
 				free_irq(mxsercfg[i].irq, &mxvar_table[i * MXSER_PORTS_PER_BOARD]);
-				//todo: release io, vector
+				/* todo: release io, vector */
 			}
 		}
 		return retval;
@@ -926,7 +969,7 @@ static int mxser_open(struct tty_struct 
 		return -ENODEV;
 	info = mxvar_table + line;
 	if (!info->base)
-		return (-ENODEV);
+		return -ENODEV;
 
 	tty->driver_data = info;
 	info->tty = tty;
@@ -935,11 +978,11 @@ static int mxser_open(struct tty_struct 
 	 */
 	retval = mxser_startup(info);
 	if (retval)
-		return (retval);
+		return retval;
 
 	retval = mxser_block_til_ready(tty, filp, info);
 	if (retval)
-		return (retval);
+		return retval;
 
 	info->count++;
 
@@ -955,11 +998,12 @@ static int mxser_open(struct tty_struct 
 	info->pgrp = process_group(current);
 	clear_bit(TTY_DONT_FLIP, &tty->flags);
 
-	//status = mxser_get_msr(info->base, 0, info->port);
-	//mxser_check_modem_status(info, status);
+	/*
+	status = mxser_get_msr(info->base, 0, info->port);
+	mxser_check_modem_status(info, status);
+	*/
 
-/* unmark here for very high baud rate (ex. 921600 bps) used
-*/
+/* unmark here for very high baud rate (ex. 921600 bps) used */
 	tty->low_latency = 1;
 	return 0;
 }
@@ -997,11 +1041,13 @@ static void mxser_close(struct tty_struc
 		 * one, we've got real problems, since it means the
 		 * serial port won't be shutdown.
 		 */
-		printk(KERN_ERR "mxser_close: bad serial port count; tty->count is 1, " "info->count is %d\n", info->count);
+		printk(KERN_ERR "mxser_close: bad serial port count; "
+			"tty->count is 1, info->count is %d\n", info->count);
 		info->count = 1;
 	}
 	if (--info->count < 0) {
-		printk(KERN_ERR "mxser_close: bad serial port count for ttys%d: %d\n", info->port, info->count);
+		printk(KERN_ERR "mxser_close: bad serial port count for "
+			"ttys%d: %d\n", info->port, info->count);
 		info->count = 0;
 	}
 	if (info->count) {
@@ -1056,7 +1102,7 @@ static void mxser_close(struct tty_struc
 		
 	ld = tty_ldisc_ref(tty);
 	if (ld) {
-		if(ld->flush_buffer)
+		if (ld->flush_buffer)
 			ld->flush_buffer(tty);
 		tty_ldisc_deref(ld);
 	}
@@ -1082,27 +1128,30 @@ static int mxser_write(struct tty_struct
 	unsigned long flags;
 
 	if (!info->xmit_buf)
-		return (0);
+		return 0;
 
 	while (1) {
-		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1, SERIAL_XMIT_SIZE - info->xmit_head));
+		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					  SERIAL_XMIT_SIZE - info->xmit_head));
 		if (c <= 0)
 			break;
 
 		memcpy(info->xmit_buf + info->xmit_head, buf, c);
 		spin_lock_irqsave(&info->slock, flags);
-		info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE - 1);
+		info->xmit_head = (info->xmit_head + c) &
+				  (SERIAL_XMIT_SIZE - 1);
 		info->xmit_cnt += c;
 		spin_unlock_irqrestore(&info->slock, flags);
 
 		buf += c;
 		count -= c;
 		total += c;
-
 	}
 
 	if (info->xmit_cnt && !tty->stopped && !(info->IER & UART_IER_THRI)) {
-		if (!tty->hw_stopped || (info->type == PORT_16550A) || (info->IsMoxaMustChipFlag)) {
+		if (!tty->hw_stopped ||
+				(info->type == PORT_16550A) ||
+				(info->IsMoxaMustChipFlag)) {
 			spin_lock_irqsave(&info->slock, flags);
 			info->IER |= UART_IER_THRI;
 			outb(info->IER, info->base + UART_IER);
@@ -1129,7 +1178,9 @@ static void mxser_put_char(struct tty_st
 	info->xmit_cnt++;
 	spin_unlock_irqrestore(&info->slock, flags);
 	if (!tty->stopped && !(info->IER & UART_IER_THRI)) {
-		if (!tty->hw_stopped || (info->type == PORT_16550A) || info->IsMoxaMustChipFlag) {
+		if (!tty->hw_stopped ||
+				(info->type == PORT_16550A) ||
+				info->IsMoxaMustChipFlag) {
 			spin_lock_irqsave(&info->slock, flags);
 			info->IER |= UART_IER_THRI;
 			outb(info->IER, info->base + UART_IER);
@@ -1144,7 +1195,13 @@ static void mxser_flush_chars(struct tty
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if (info->xmit_cnt <= 0 || tty->stopped || !info->xmit_buf || (tty->hw_stopped && (info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)))
+	if (info->xmit_cnt <= 0 ||
+			tty->stopped ||
+			!info->xmit_buf ||
+			(tty->hw_stopped &&
+			 (info->type != PORT_16550A) &&
+			 (!info->IsMoxaMustChipFlag)
+			))
 		return;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1163,7 +1220,7 @@ static int mxser_write_room(struct tty_s
 	ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
 	if (ret < 0)
 		ret = 0;
-	return (ret);
+	return ret;
 }
 
 static int mxser_chars_in_buffer(struct tty_struct *tty)
@@ -1184,7 +1241,8 @@ static void mxser_flush_buffer(struct tt
 
 	/* below added by shinhay */
 	fcr = inb(info->base + UART_FCR);
-	outb((fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT), info->base + UART_FCR);
+	outb((fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
+		info->base + UART_FCR);
 	outb(fcr, info->base + UART_FCR);
 
 	spin_unlock_irqrestore(&info->slock, flags);
@@ -1206,9 +1264,9 @@ static int mxser_ioctl(struct tty_struct
 	void __user *argp = (void __user *)arg;
 
 	if (tty->index == MXSER_PORTS)
-		return (mxser_ioctl_special(cmd, argp));
+		return mxser_ioctl_special(cmd, argp);
 
-	// following add by Victor Yu. 01-05-2004
+	/* following add by Victor Yu. 01-05-2004 */
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
 		int opmode, p;
 		static unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
@@ -1219,7 +1277,10 @@ static int mxser_ioctl(struct tty_struct
 		if (cmd == MOXA_SET_OP_MODE) {
 			if (get_user(opmode, (int __user *) argp))
 				return -EFAULT;
-			if (opmode != RS232_MODE && opmode != RS485_2WIRE_MODE && opmode != RS422_MODE && opmode != RS485_4WIRE_MODE)
+			if (opmode != RS232_MODE &&
+					opmode != RS485_2WIRE_MODE &&
+					opmode != RS422_MODE &&
+					opmode != RS485_4WIRE_MODE)
 				return -EFAULT;
 			mask = ModeMask[p];
 			shiftbit = p * 2;
@@ -1236,36 +1297,36 @@ static int mxser_ioctl(struct tty_struct
 		}
 		return 0;
 	}
-	// above add by Victor Yu. 01-05-2004
+	/* above add by Victor Yu. 01-05-2004 */
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
 		if (tty->flags & (1 << TTY_IO_ERROR))
-			return (-EIO);
+			return -EIO;
 	}
 	switch (cmd) {
 	case TCSBRK:		/* SVID version: non-zero arg --> no break */
 		retval = tty_check_change(tty);
 		if (retval)
-			return (retval);
+			return retval;
 		tty_wait_until_sent(tty, 0);
 		if (!arg)
 			mxser_send_break(info, HZ / 4);	/* 1/4 second */
-		return (0);
+		return 0;
 	case TCSBRKP:		/* support for POSIX tcsendbreak() */
 		retval = tty_check_change(tty);
 		if (retval)
-			return (retval);
+			return retval;
 		tty_wait_until_sent(tty, 0);
 		mxser_send_break(info, arg ? arg * (HZ / 10) : HZ / 4);
-		return (0);
+		return 0;
 	case TIOCGSOFTCAR:
-		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *) argp);
+		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
 	case TIOCSSOFTCAR:
 		if (get_user(templ, (unsigned long __user *) argp))
 			return -EFAULT;
 		arg = templ;
 		tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL) | (arg ? CLOCAL : 0));
-		return (0);
+		return 0;
 	case TIOCGSERIAL:
 		return mxser_get_serial_info(info, argp);
 	case TIOCSSERIAL:
@@ -1278,7 +1339,7 @@ static int mxser_ioctl(struct tty_struct
 		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
-	case TIOCMIWAIT:{
+	case TIOCMIWAIT: {
 			DECLARE_WAITQUEUE(wait, current);
 			int ret;
 			spin_lock_irqsave(&info->slock, flags);
@@ -1292,7 +1353,14 @@ static int mxser_ioctl(struct tty_struct
 				spin_unlock_irqrestore(&info->slock, flags);
 
 				set_current_state(TASK_INTERRUPTIBLE);
-				if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) || ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) || ((arg & TIOCM_CD) && (cnow.dcd != cprev.dcd)) || ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts))) {
+				if (((arg & TIOCM_RNG) &&
+						(cnow.rng != cprev.rng)) ||
+						((arg & TIOCM_DSR) &&
+						(cnow.dsr != cprev.dsr)) ||
+						((arg & TIOCM_CD) &&
+						(cnow.dcd != cprev.dcd)) ||
+						((arg & TIOCM_CTS) &&
+						(cnow.cts != cprev.cts))) {
 					ret = 0;
 					break;
 				}
@@ -1338,21 +1406,18 @@ static int mxser_ioctl(struct tty_struct
 		put_user(cnow.dsr, &p_cuser->dsr);
 		put_user(cnow.rng, &p_cuser->rng);
 		put_user(cnow.dcd, &p_cuser->dcd);
-
-/* */
 		return 0;
 	case MOXA_HighSpeedOn:
-		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *) argp);
-
-	case MOXA_SDS_RSTICOUNTER:{
+		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *)argp);
+	case MOXA_SDS_RSTICOUNTER: {
 			info->mon_data.rxcnt = 0;
 			info->mon_data.txcnt = 0;
 			return 0;
 		}
-// (above) added by James.
+/* (above) added by James. */
 	case MOXA_ASPP_SETBAUD:{
 			long baud;
-			if (get_user(baud, (long __user *) argp))
+			if (get_user(baud, (long __user *)argp))
 				return -EFAULT;
 			mxser_set_baud(info, baud);
 			return 0;
@@ -1377,9 +1442,10 @@ static int mxser_ioctl(struct tty_struct
 
 			return 0;
 		}
-	case MOXA_ASPP_MON:{
+	case MOXA_ASPP_MON: {
 			int mcr, status;
-//      info->mon_data.ser_param = tty->termios->c_cflag;
+
+			/* info->mon_data.ser_param = tty->termios->c_cflag; */
 
 			status = mxser_get_msr(info->base, 1, info->port, info);
 			mxser_check_modem_status(info, status);
@@ -1400,25 +1466,25 @@ static int mxser_ioctl(struct tty_struct
 			else
 				info->mon_data.hold_reason &= ~NPPI_NOTIFY_CTSHOLD;
 
-
-			if (copy_to_user(argp, &info->mon_data, sizeof(struct mxser_mon)))
+			if (copy_to_user(argp, &info->mon_data,
+					sizeof(struct mxser_mon)))
 				return -EFAULT;
 
 			return 0;
-
 		}
 
-	case MOXA_ASPP_LSTATUS:{
-			if (copy_to_user(argp, &info->err_shadow, sizeof(unsigned char)))
+	case MOXA_ASPP_LSTATUS: {
+			if (copy_to_user(argp, &info->err_shadow,
+					sizeof(unsigned char)))
 				return -EFAULT;
 
 			info->err_shadow = 0;
 			return 0;
-
 		}
-	case MOXA_SET_BAUD_METHOD:{
+	case MOXA_SET_BAUD_METHOD: {
 			int method;
-			if (get_user(method, (int __user *) argp))
+
+			if (get_user(method, (int __user *)argp))
 				return -EFAULT;
 			mxser_set_baud_method[info->port] = method;
 			if (copy_to_user(argp, &method, sizeof(int)))
@@ -1442,7 +1508,8 @@ static int mxser_ioctl_special(unsigned 
 
 	switch (cmd) {
 	case MOXA_GET_CONF:
-		if (copy_to_user(argp, mxsercfg, sizeof(struct mxser_hwconf) * 4))
+		if (copy_to_user(argp, mxsercfg,
+				sizeof(struct mxser_hwconf) * 4))
 			return -EFAULT;
 		return 0;
 	case MOXA_GET_MAJOR:
@@ -1461,11 +1528,11 @@ static int mxser_ioctl_special(unsigned 
 			if (mxvar_table[i].base)
 				result |= (1 << i);
 		}
-		return put_user(result, (unsigned long __user *) argp);
+		return put_user(result, (unsigned long __user *)argp);
 	case MOXA_GETDATACOUNT:
 		if (copy_to_user(argp, &mxvar_log, sizeof(mxvar_log)))
 			return -EFAULT;
-		return (0);
+		return 0;
 	case MOXA_GETMSTATUS:
 		for (i = 0; i < MXSER_PORTS; i++) {
 			GMStatus[i].ri = 0;
@@ -1498,22 +1565,26 @@ static int mxser_ioctl_special(unsigned 
 			else
 				GMStatus[i].cts = 0;
 		}
-		if (copy_to_user(argp, GMStatus, sizeof(struct mxser_mstatus) * MXSER_PORTS))
+		if (copy_to_user(argp, GMStatus,
+				sizeof(struct mxser_mstatus) * MXSER_PORTS))
 			return -EFAULT;
 		return 0;
-	case MOXA_ASPP_MON_EXT:{
+	case MOXA_ASPP_MON_EXT: {
 			int status;
 			int opmode, p;
 			int shiftbit;
 			unsigned cflag, iflag;
 
 			for (i = 0; i < MXSER_PORTS; i++) {
-
 				if (!mxvar_table[i].base)
 					continue;
 
-				status = mxser_get_msr(mxvar_table[i].base, 0, i, &(mxvar_table[i]));
-//                      mxser_check_modem_status(&mxvar_table[i], status);
+				status = mxser_get_msr(mxvar_table[i].base, 0,
+							i, &(mxvar_table[i]));
+				/*
+				mxser_check_modem_status(&mxvar_table[i],
+								status);
+				*/
 				if (status & UART_MSR_TERI)
 					mxvar_table[i].icount.rng++;
 				if (status & UART_MSR_DDSR)
@@ -1578,75 +1649,76 @@ static int mxser_ioctl_special(unsigned 
 	return 0;
 }
 
-
 static void mxser_stoprx(struct tty_struct *tty)
 {
 	struct mxser_struct *info = tty->driver_data;
-	//unsigned long flags;
-
+	/* unsigned long flags; */
 
 	info->ldisc_stop_rx = 1;
 	if (I_IXOFF(tty)) {
-
-		//MX_LOCK(&info->slock);
-		// following add by Victor Yu. 09-02-2002
+		/* MX_LOCK(&info->slock); */
+		/* following add by Victor Yu. 09-02-2002 */
 		if (info->IsMoxaMustChipFlag) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
 			outb(info->IER, info->base + UART_IER);
 		} else {
-			// above add by Victor Yu. 09-02-2002
-
+			/* above add by Victor Yu. 09-02-2002 */
 			info->x_char = STOP_CHAR(tty);
-			//      outb(info->IER, 0); // mask by Victor Yu. 09-02-2002
+			/* mask by Victor Yu. 09-02-2002 */
+			/* outb(info->IER, 0); */
 			outb(0, info->base + UART_IER);
 			info->IER |= UART_IER_THRI;
-			outb(info->IER, info->base + UART_IER);	/* force Tx interrupt */
-		}		// add by Victor Yu. 09-02-2002
-		//MX_UNLOCK(&info->slock);
+			/* force Tx interrupt */
+			outb(info->IER, info->base + UART_IER);
+		}		/* add by Victor Yu. 09-02-2002 */
+		/* MX_UNLOCK(&info->slock); */
 	}
 
 	if (info->tty->termios->c_cflag & CRTSCTS) {
-		//MX_LOCK(&info->slock);
+		/* MX_LOCK(&info->slock); */
 		info->MCR &= ~UART_MCR_RTS;
 		outb(info->MCR, info->base + UART_MCR);
-		//MX_UNLOCK(&info->slock);
+		/* MX_UNLOCK(&info->slock); */
 	}
 }
 
 static void mxser_startrx(struct tty_struct *tty)
 {
 	struct mxser_struct *info = tty->driver_data;
-	//unsigned long flags;
+	/* unsigned long flags; */
 
 	info->ldisc_stop_rx = 0;
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else {
-			//MX_LOCK(&info->slock);
+			/* MX_LOCK(&info->slock); */
 
-			// following add by Victor Yu. 09-02-2002
+			/* following add by Victor Yu. 09-02-2002 */
 			if (info->IsMoxaMustChipFlag) {
 				info->IER |= MOXA_MUST_RECV_ISR;
 				outb(info->IER, info->base + UART_IER);
 			} else {
-				// above add by Victor Yu. 09-02-2002
+				/* above add by Victor Yu. 09-02-2002 */
 
 				info->x_char = START_CHAR(tty);
-				//          outb(info->IER, 0); // mask by Victor Yu. 09-02-2002
-				outb(0, info->base + UART_IER);	// add by Victor Yu. 09-02-2002
-				info->IER |= UART_IER_THRI;	/* force Tx interrupt */
+				/* mask by Victor Yu. 09-02-2002 */
+				/* outb(info->IER, 0); */
+				/* add by Victor Yu. 09-02-2002 */
+				outb(0, info->base + UART_IER);
+				/* force Tx interrupt */
+				info->IER |= UART_IER_THRI;
 				outb(info->IER, info->base + UART_IER);
-			}	// add by Victor Yu. 09-02-2002
-			//MX_UNLOCK(&info->slock);
+			}	/* add by Victor Yu. 09-02-2002 */
+			/* MX_UNLOCK(&info->slock); */
 		}
 	}
 
 	if (info->tty->termios->c_cflag & CRTSCTS) {
-		//MX_LOCK(&info->slock);
+		/* MX_LOCK(&info->slock); */
 		info->MCR |= UART_MCR_RTS;
 		outb(info->MCR, info->base + UART_MCR);
-		//MX_UNLOCK(&info->slock);
+		/* MX_UNLOCK(&info->slock); */
 	}
 }
 
@@ -1656,20 +1728,22 @@ static void mxser_startrx(struct tty_str
  */
 static void mxser_throttle(struct tty_struct *tty)
 {
-	//struct mxser_struct *info = tty->driver_data;
-	//unsigned long flags;
-	//MX_LOCK(&info->slock);
+	/* struct mxser_struct *info = tty->driver_data; */
+	/* unsigned long flags; */
+
+	/* MX_LOCK(&info->slock); */
 	mxser_stoprx(tty);
-	//MX_UNLOCK(&info->slock);
+	/* MX_UNLOCK(&info->slock); */
 }
 
 static void mxser_unthrottle(struct tty_struct *tty)
 {
-	//struct mxser_struct *info = tty->driver_data;
-	//unsigned long flags;
-	//MX_LOCK(&info->slock);
+	/* struct mxser_struct *info = tty->driver_data; */
+	/* unsigned long flags; */
+
+	/* MX_LOCK(&info->slock); */
 	mxser_startrx(tty);
-	//MX_UNLOCK(&info->slock);
+	/* MX_UNLOCK(&info->slock); */
 }
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
@@ -1677,27 +1751,30 @@ static void mxser_set_termios(struct tty
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if ((tty->termios->c_cflag != old_termios->c_cflag) || (RELEVANT_IFLAG(tty->termios->c_iflag) != RELEVANT_IFLAG(old_termios->c_iflag))) {
+	if ((tty->termios->c_cflag != old_termios->c_cflag) ||
+			(RELEVANT_IFLAG(tty->termios->c_iflag) != RELEVANT_IFLAG(old_termios->c_iflag))) {
 
 		mxser_change_speed(info, old_termios);
 
-		if ((old_termios->c_cflag & CRTSCTS) && !(tty->termios->c_cflag & CRTSCTS)) {
+		if ((old_termios->c_cflag & CRTSCTS) &&
+				!(tty->termios->c_cflag & CRTSCTS)) {
 			tty->hw_stopped = 0;
 			mxser_start(tty);
 		}
 	}
 
 /* Handle sw stopped */
-	if ((old_termios->c_iflag & IXON) && !(tty->termios->c_iflag & IXON)) {
+	if ((old_termios->c_iflag & IXON) &&
+			!(tty->termios->c_iflag & IXON)) {
 		tty->stopped = 0;
 
-		// following add by Victor Yu. 09-02-2002
+		/* following add by Victor Yu. 09-02-2002 */
 		if (info->IsMoxaMustChipFlag) {
 			spin_lock_irqsave(&info->slock, flags);
 			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->base);
 			spin_unlock_irqrestore(&info->slock, flags);
 		}
-		// above add by Victor Yu. 09-02-2002
+		/* above add by Victor Yu. 09-02-2002 */
 
 		mxser_start(tty);
 	}
@@ -1777,7 +1854,8 @@ static void mxser_wait_until_sent(struct
 	if (!timeout || timeout > 2 * info->timeout)
 		timeout = 2 * info->timeout;
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
-	printk(KERN_DEBUG "In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
+	printk(KERN_DEBUG "In rs_wait_until_sent(%d) check=%lu...",
+		timeout, char_time);
 	printk("jiff=%lu...", jiffies);
 #endif
 	while (!((lsr = inb(info->base + UART_LSR)) & UART_LSR_TEMT)) {
@@ -1815,7 +1893,7 @@ void mxser_hangup(struct tty_struct *tty
 }
 
 
-// added by James 03-12-2004.
+/* added by James 03-12-2004. */
 /*
  * mxser_rs_break() --- routine which turns the break handling on or off
  */
@@ -1826,13 +1904,15 @@ static void mxser_rs_break(struct tty_st
 
 	spin_lock_irqsave(&info->slock, flags);
 	if (break_state == -1)
-		outb(inb(info->base + UART_LCR) | UART_LCR_SBC, info->base + UART_LCR);
+		outb(inb(info->base + UART_LCR) | UART_LCR_SBC,
+			info->base + UART_LCR);
 	else
-		outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC, info->base + UART_LCR);
+		outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC,
+			info->base + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
-// (above) added by James.
+/* (above) added by James. */
 
 
 /*
@@ -1848,7 +1928,7 @@ static irqreturn_t mxser_interrupt(int i
 	int handled = IRQ_NONE;
 
 	port = NULL;
-	//spin_lock(&gm_lock);
+	/* spin_lock(&gm_lock); */
 
 	for (i = 0; i < MXSER_BOARDS; i++) {
 		if (dev_id == &(mxvar_table[i * MXSER_PORTS_PER_BOARD])) {
@@ -1857,29 +1937,25 @@ static irqreturn_t mxser_interrupt(int i
 		}
 	}
 
-	if (i == MXSER_BOARDS) {
+	if (i == MXSER_BOARDS)
 		goto irq_stop;
-	}
-	if (port == 0) {
+	if (port == 0)
 		goto irq_stop;
-	}
 	max = mxser_numports[mxsercfg[i].board_type - 1];
 	while (1) {
 		irqbits = inb(port->vector) & port->vectormask;
-		if (irqbits == port->vectormask) {
+		if (irqbits == port->vectormask)
 			break;
-		}
 
 		handled = IRQ_HANDLED;
 		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
-			if (irqbits == port->vectormask) {
+			if (irqbits == port->vectormask)
 				break;
-			}
 			if (bits & irqbits)
 				continue;
 			info = port + i;
 
-			// following add by Victor Yu. 09-13-2002
+			/* following add by Victor Yu. 09-13-2002 */
 			iir = inb(info->base + UART_IIR);
 			if (iir & UART_IIR_NO_INT)
 				continue;
@@ -1890,9 +1966,9 @@ static irqreturn_t mxser_interrupt(int i
 				inb(info->base + UART_MSR);
 				continue;
 			}
-			// above add by Victor Yu. 09-13-2002
+			/* above add by Victor Yu. 09-13-2002 */
 			/*
-			   if ( info->tty->flip.count < TTY_FLIPBUF_SIZE/4 ){
+			   if (info->tty->flip.count < TTY_FLIPBUF_SIZE / 4) {
 			   info->IER |= MOXA_MUST_RECV_ISR;
 			   outb(info->IER, info->base + UART_IER);
 			   }
@@ -1908,18 +1984,15 @@ static irqreturn_t mxser_interrupt(int i
 			   status = inb(info->base + UART_LSR) & info->read_status_mask;
 			 */
 
-			// following add by Victor Yu. 09-02-2002
+			/* following add by Victor Yu. 09-02-2002 */
 			status = inb(info->base + UART_LSR);
 
-			if (status & UART_LSR_PE) {
+			if (status & UART_LSR_PE)
 				info->err_shadow |= NPPI_NOTIFY_PARITY;
-			}
-			if (status & UART_LSR_FE) {
+			if (status & UART_LSR_FE)
 				info->err_shadow |= NPPI_NOTIFY_FRAMING;
-			}
-			if (status & UART_LSR_OE) {
+			if (status & UART_LSR_OE)
 				info->err_shadow |= NPPI_NOTIFY_HW_OVERRUN;
-			}
 			if (status & UART_LSR_BI)
 				info->err_shadow |= NPPI_NOTIFY_BREAK;
 
@@ -1930,11 +2003,14 @@ static irqreturn_t mxser_interrupt(int i
 				   continue;
 				   }
 				 */
-				if (iir == MOXA_MUST_IIR_GDA || iir == MOXA_MUST_IIR_RDA || iir == MOXA_MUST_IIR_RTO || iir == MOXA_MUST_IIR_LSR)
+				if (iir == MOXA_MUST_IIR_GDA ||
+						iir == MOXA_MUST_IIR_RDA ||
+						iir == MOXA_MUST_IIR_RTO ||
+						iir == MOXA_MUST_IIR_LSR)
 					mxser_receive_chars(info, &status);
 
 			} else {
-				// above add by Victor Yu. 09-02-2002
+				/* above add by Victor Yu. 09-02-2002 */
 
 				status &= info->read_status_mask;
 				if (status & UART_LSR_DR)
@@ -1944,13 +2020,13 @@ static irqreturn_t mxser_interrupt(int i
 			if (msr & UART_MSR_ANY_DELTA) {
 				mxser_check_modem_status(info, msr);
 			}
-			// following add by Victor Yu. 09-13-2002
+			/* following add by Victor Yu. 09-13-2002 */
 			if (info->IsMoxaMustChipFlag) {
 				if ((iir == 0x02) && (status & UART_LSR_THRE)) {
 					mxser_transmit_chars(info);
 				}
 			} else {
-				// above add by Victor Yu. 09-13-2002
+				/* above add by Victor Yu. 09-13-2002 */
 
 				if (status & UART_LSR_THRE) {
 /* 8-2-99 by William
@@ -1966,7 +2042,7 @@ static irqreturn_t mxser_interrupt(int i
 	}
 
       irq_stop:
-	//spin_unlock(&gm_lock);
+	/* spin_unlock(&gm_lock); */
 	return handled;
 }
 
@@ -1984,56 +2060,58 @@ static void mxser_receive_chars(struct m
 
 	recv_room = tty->receive_room;
 	if ((recv_room == 0) && (!info->ldisc_stop_rx)) {
-		//mxser_throttle(tty);
+		/* mxser_throttle(tty); */
 		mxser_stoprx(tty);
-		//return;
+		/* return; */
 	}
 
-	// following add by Victor Yu. 09-02-2002
+	/* following add by Victor Yu. 09-02-2002 */
 	if (info->IsMoxaMustChipFlag != MOXA_OTHER_UART) {
 
 		if (*status & UART_LSR_SPECIAL) {
 			goto intr_old;
 		}
-		// following add by Victor Yu. 02-11-2004
-		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU860_HWID && (*status & MOXA_MUST_LSR_RERR))
+		/* following add by Victor Yu. 02-11-2004 */
+		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU860_HWID &&
+				(*status & MOXA_MUST_LSR_RERR))
 			goto intr_old;
-		// above add by Victor Yu. 02-14-2004
+		/* above add by Victor Yu. 02-14-2004 */
 		if (*status & MOXA_MUST_LSR_RERR)
 			goto intr_old;
 
 		gdl = inb(info->base + MOXA_MUST_GDL_REGISTER);
 
-		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU150_HWID)	// add by Victor Yu. 02-11-2004
+		/* add by Victor Yu. 02-11-2004 */
+		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU150_HWID)
 			gdl &= MOXA_MUST_GDL_MASK;
 		if (gdl >= recv_room) {
 			if (!info->ldisc_stop_rx) {
-				//mxser_throttle(tty);
+				/* mxser_throttle(tty); */
 				mxser_stoprx(tty);
 			}
-			//return;
+			/* return; */
 		}
 		while (gdl--) {
 			ch = inb(info->base + UART_RX);
 			tty_insert_flip_char(tty, ch, 0);
 			cnt++;
 			/*
-			   if((cnt>=HI_WATER) && (info->stop_rx==0)){
+			   if ((cnt >= HI_WATER) && (info->stop_rx == 0)) {
 			   mxser_stoprx(tty);
-			   info->stop_rx=1;
+			   info->stop_rx = 1;
 			   break;
 			   } */
 		}
 		goto end_intr;
 	}
-intr_old:
-	// above add by Victor Yu. 09-02-2002
+ intr_old:
+	/* above add by Victor Yu. 09-02-2002 */
 
 	do {
 		if (max-- < 0)
 			break;
 		/*
-		   if((cnt>=HI_WATER) && (info->stop_rx==0)){
+		   if ((cnt >= HI_WATER) && (info->stop_rx == 0)) {
 		   mxser_stoprx(tty);
 		   info->stop_rx=1;
 		   break;
@@ -2041,11 +2119,11 @@ intr_old:
 		 */
 
 		ch = inb(info->base + UART_RX);
-		// following add by Victor Yu. 09-02-2002
+		/* following add by Victor Yu. 09-02-2002 */
 		if (info->IsMoxaMustChipFlag && (*status & UART_LSR_OE) /*&& !(*status&UART_LSR_DR) */ )
 			outb(0x23, info->base + UART_FCR);
 		*status &= info->read_status_mask;
-		// above add by Victor Yu. 09-02-2002
+		/* above add by Victor Yu. 09-02-2002 */
 		if (*status & info->ignore_status_mask) {
 			if (++ignored > 100)
 				break;
@@ -2080,7 +2158,7 @@ intr_old:
 			cnt++;
 			if (cnt >= recv_room) {
 				if (!info->ldisc_stop_rx) {
-					//mxser_throttle(tty);
+					/* mxser_throttle(tty); */
 					mxser_stoprx(tty);
 				}
 				break;
@@ -2088,21 +2166,20 @@ intr_old:
 
 		}
 
-		// following add by Victor Yu. 09-02-2002
+		/* following add by Victor Yu. 09-02-2002 */
 		if (info->IsMoxaMustChipFlag)
 			break;
-		// above add by Victor Yu. 09-02-2002
+		/* above add by Victor Yu. 09-02-2002 */
 
 		/* mask by Victor Yu. 09-02-2002
 		 *status = inb(info->base + UART_LSR) & info->read_status_mask;
 		 */
-		// following add by Victor Yu. 09-02-2002
+		/* following add by Victor Yu. 09-02-2002 */
 		*status = inb(info->base + UART_LSR);
-		// above add by Victor Yu. 09-02-2002
+		/* above add by Victor Yu. 09-02-2002 */
 	} while (*status & UART_LSR_DR);
 
-end_intr:		// add by Victor Yu. 09-02-2002
-
+end_intr:		/* add by Victor Yu. 09-02-2002 */
 	mxvar_log.rxcnt[info->port] += cnt;
 	info->mon_data.rxcnt += cnt;
 	info->mon_data.up_rxcnt += cnt;
@@ -2137,7 +2214,10 @@ static void mxser_transmit_chars(struct 
 		return;
 	}
 
-	if ((info->xmit_cnt <= 0) || info->tty->stopped || (info->tty->hw_stopped && (info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag))) {
+	if ((info->xmit_cnt <= 0) || info->tty->stopped ||
+			(info->tty->hw_stopped &&
+			(info->type != PORT_16550A) &&
+			(!info->IsMoxaMustChipFlag))) {
 		info->IER &= ~UART_IER_THRI;
 		outb(info->IER, info->base + UART_IER);
 		spin_unlock_irqrestore(&info->slock, flags);
@@ -2147,17 +2227,18 @@ static void mxser_transmit_chars(struct 
 	cnt = info->xmit_cnt;
 	count = info->xmit_fifo_size;
 	do {
-		outb(info->xmit_buf[info->xmit_tail++], info->base + UART_TX);
+		outb(info->xmit_buf[info->xmit_tail++],
+			info->base + UART_TX);
 		info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE - 1);
 		if (--info->xmit_cnt <= 0)
 			break;
 	} while (--count > 0);
 	mxvar_log.txcnt[info->port] += (cnt - info->xmit_cnt);
 
-// added by James 03-12-2004.
+/* added by James 03-12-2004. */
 	info->mon_data.txcnt += (cnt - info->xmit_cnt);
 	info->mon_data.up_txcnt += (cnt - info->xmit_cnt);
-// (above) added by James.
+/* (above) added by James. */
 
 /* added by casper 1/11/2000 */
 	info->icount.tx += (cnt - info->xmit_cnt);
@@ -2188,7 +2269,6 @@ static void mxser_check_modem_status(str
 	info->mon_data.modem_status = status;
 	wake_up_interruptible(&info->delta_msr_wait);
 
-
 	if ((info->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
 		if (status & UART_MSR_DCD)
 			wake_up_interruptible(&info->open_wait);
@@ -2200,7 +2280,8 @@ static void mxser_check_modem_status(str
 			if (status & UART_MSR_CTS) {
 				info->tty->hw_stopped = 0;
 
-				if ((info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)) {
+				if ((info->type != PORT_16550A) &&
+						(!info->IsMoxaMustChipFlag)) {
 					info->IER |= UART_IER_THRI;
 					outb(info->IER, info->base + UART_IER);
 				}
@@ -2209,7 +2290,8 @@ static void mxser_check_modem_status(str
 		} else {
 			if (!(status & UART_MSR_CTS)) {
 				info->tty->hw_stopped = 1;
-				if ((info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)) {
+				if ((info->type != PORT_16550A) &&
+						(!info->IsMoxaMustChipFlag)) {
 					info->IER &= ~UART_IER_THRI;
 					outb(info->IER, info->base + UART_IER);
 				}
@@ -2231,7 +2313,7 @@ static int mxser_block_til_ready(struct 
 	 */
 	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
 		info->flags |= ASYNC_NORMAL_ACTIVE;
-		return (0);
+		return 0;
 	}
 
 	if (tty->termios->c_cflag & CLOCAL)
@@ -2254,7 +2336,8 @@ static int mxser_block_til_ready(struct 
 	info->blocked_open++;
 	while (1) {
 		spin_lock_irqsave(&info->slock, flags);
-		outb(inb(info->base + UART_MCR) | UART_MCR_DTR | UART_MCR_RTS, info->base + UART_MCR);
+		outb(inb(info->base + UART_MCR) |
+			UART_MCR_DTR | UART_MCR_RTS, info->base + UART_MCR);
 		spin_unlock_irqrestore(&info->slock, flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) || !(info->flags & ASYNC_INITIALIZED)) {
@@ -2264,7 +2347,9 @@ static int mxser_block_til_ready(struct 
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(info->flags & ASYNC_CLOSING) && (do_clocal || (inb(info->base + UART_MSR) & UART_MSR_DCD)))
+		if (!(info->flags & ASYNC_CLOSING) &&
+				(do_clocal ||
+				(inb(info->base + UART_MSR) & UART_MSR_DCD)))
 			break;
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -2278,27 +2363,26 @@ static int mxser_block_til_ready(struct 
 		info->count++;
 	info->blocked_open--;
 	if (retval)
-		return (retval);
+		return retval;
 	info->flags |= ASYNC_NORMAL_ACTIVE;
-	return (0);
+	return 0;
 }
 
 static int mxser_startup(struct mxser_struct *info)
 {
-
 	unsigned long page;
 	unsigned long flags;
 
 	page = __get_free_page(GFP_KERNEL);
 	if (!page)
-		return (-ENOMEM);
+		return -ENOMEM;
 
 	spin_lock_irqsave(&info->slock, flags);
 
 	if (info->flags & ASYNC_INITIALIZED) {
 		free_page(page);
 		spin_unlock_irqrestore(&info->slock, flags);
-		return (0);
+		return 0;
 	}
 
 	if (!info->base || !info->type) {
@@ -2306,7 +2390,7 @@ static int mxser_startup(struct mxser_st
 			set_bit(TTY_IO_ERROR, &info->tty->flags);
 		free_page(page);
 		spin_unlock_irqrestore(&info->slock, flags);
-		return (0);
+		return 0;
 	}
 	if (info->xmit_buf)
 		free_page(page);
@@ -2318,9 +2402,12 @@ static int mxser_startup(struct mxser_st
 	 * (they will be reenabled in mxser_change_speed())
 	 */
 	if (info->IsMoxaMustChipFlag)
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT | MOXA_MUST_FCR_GDA_MODE_ENABLE), info->base + UART_FCR);
+		outb((UART_FCR_CLEAR_RCVR |
+			UART_FCR_CLEAR_XMIT |
+			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->base + UART_FCR);
 	else
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT), info->base + UART_FCR);
+		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
+			info->base + UART_FCR);
 
 	/*
 	 * At this point there's no way the LSR could still be 0xFF;
@@ -2332,9 +2419,9 @@ static int mxser_startup(struct mxser_st
 		if (capable(CAP_SYS_ADMIN)) {
 			if (info->tty)
 				set_bit(TTY_IO_ERROR, &info->tty->flags);
-			return (0);
+			return 0;
 		} else
-			return (-ENODEV);
+			return -ENODEV;
 	}
 
 	/*
@@ -2356,12 +2443,12 @@ static int mxser_startup(struct mxser_st
 	 * Finally, enable interrupts
 	 */
 	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
-//      info->IER = UART_IER_RLSI | UART_IER_RDI;
+	/* info->IER = UART_IER_RLSI | UART_IER_RDI; */
 
-	// following add by Victor Yu. 08-30-2002
+	/* following add by Victor Yu. 08-30-2002 */
 	if (info->IsMoxaMustChipFlag)
 		info->IER |= MOXA_MUST_IER_EGDAI;
-	// above add by Victor Yu. 08-30-2002
+	/* above add by Victor Yu. 08-30-2002 */
 	outb(info->IER, info->base + UART_IER);	/* enable interrupts */
 
 	/*
@@ -2383,7 +2470,7 @@ static int mxser_startup(struct mxser_st
 	mxser_change_speed(info, NULL);
 
 	info->flags |= ASYNC_INITIALIZED;
-	return (0);
+	return 0;
 }
 
 /*
@@ -2421,12 +2508,15 @@ static void mxser_shutdown(struct mxser_
 	outb(info->MCR, info->base + UART_MCR);
 
 	/* clear Rx/Tx FIFO's */
-	// following add by Victor Yu. 08-30-2002
+	/* following add by Victor Yu. 08-30-2002 */
 	if (info->IsMoxaMustChipFlag)
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT | MOXA_MUST_FCR_GDA_MODE_ENABLE), info->base + UART_FCR);
+		outb((UART_FCR_CLEAR_RCVR |
+			UART_FCR_CLEAR_XMIT |
+			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->base + UART_FCR);
 	else
-		// above add by Victor Yu. 08-30-2002
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT), info->base + UART_FCR);
+		/* above add by Victor Yu. 08-30-2002 */
+		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
+			info->base + UART_FCR);
 
 	/* read data port to reset things */
 	(void) inb(info->base + UART_RX);
@@ -2436,11 +2526,10 @@ static void mxser_shutdown(struct mxser_
 
 	info->flags &= ~ASYNC_INITIALIZED;
 
-	// following add by Victor Yu. 09-23-2002
-	if (info->IsMoxaMustChipFlag) {
+	/* following add by Victor Yu. 09-23-2002 */
+	if (info->IsMoxaMustChipFlag)
 		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->base);
-	}
-	// above add by Victor Yu. 09-23-2002
+	/* above add by Victor Yu. 09-23-2002 */
 
 	spin_unlock_irqrestore(&info->slock, flags);
 }
@@ -2457,14 +2546,12 @@ static int mxser_change_speed(struct mxs
 	long baud;
 	unsigned long flags;
 
-
 	if (!info->tty || !info->tty->termios)
 		return ret;
 	cflag = info->tty->termios->c_cflag;
 	if (!(info->base))
 		return ret;
 
-
 #ifndef B921600
 #define B921600 (B460800 +1)
 #endif
@@ -2559,9 +2646,8 @@ static int mxser_change_speed(struct mxs
 		cval |= 0x04;
 	if (cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-	if (!(cflag & PARODD)) {
+	if (!(cflag & PARODD))
 		cval |= UART_LCR_EPAR;
-	}
 	if (cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
 
@@ -2574,13 +2660,12 @@ static int mxser_change_speed(struct mxs
 			fcr = 0;
 	} else {
 		fcr = UART_FCR_ENABLE_FIFO;
-		// following add by Victor Yu. 08-30-2002
+		/* following add by Victor Yu. 08-30-2002 */
 		if (info->IsMoxaMustChipFlag) {
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			SET_MOXA_MUST_FIFO_VALUE(info);
 		} else {
-			// above add by Victor Yu. 08-30-2002
-
+			/* above add by Victor Yu. 08-30-2002 */
 			switch (info->rx_trigger) {
 			case 1:
 				fcr |= UART_FCR_TRIGGER_1;
@@ -2606,22 +2691,24 @@ static int mxser_change_speed(struct mxs
 		info->IER |= UART_IER_MSI;
 		if ((info->type == PORT_16550A) || (info->IsMoxaMustChipFlag)) {
 			info->MCR |= UART_MCR_AFE;
-			//status = mxser_get_msr(info->base, 0, info->port);
-/*	save_flags(flags);
+			/* status = mxser_get_msr(info->base, 0, info->port); */
+/*
+	save_flags(flags);
 	cli();
 	status = inb(baseaddr + UART_MSR);
-	restore_flags(flags);*/
-			//mxser_check_modem_status(info, status);
+	restore_flags(flags);
+*/
+			/* mxser_check_modem_status(info, status); */
 		} else {
-			//status = mxser_get_msr(info->base, 0, info->port);
-
-			//MX_LOCK(&info->slock);
+			/* status = mxser_get_msr(info->base, 0, info->port); */
+			/* MX_LOCK(&info->slock); */
 			status = inb(info->base + UART_MSR);
-			//MX_UNLOCK(&info->slock);
+			/* MX_UNLOCK(&info->slock); */
 			if (info->tty->hw_stopped) {
 				if (status & UART_MSR_CTS) {
 					info->tty->hw_stopped = 0;
-					if ((info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)) {
+					if ((info->type != PORT_16550A) &&
+							(!info->IsMoxaMustChipFlag)) {
 						info->IER |= UART_IER_THRI;
 						outb(info->IER, info->base + UART_IER);
 					}
@@ -2630,7 +2717,8 @@ static int mxser_change_speed(struct mxs
 			} else {
 				if (!(status & UART_MSR_CTS)) {
 					info->tty->hw_stopped = 1;
-					if ((info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)) {
+					if ((info->type != PORT_16550A) &&
+							(!info->IsMoxaMustChipFlag)) {
 						info->IER &= ~UART_IER_THRI;
 						outb(info->IER, info->base + UART_IER);
 					}
@@ -2668,11 +2756,17 @@ static int mxser_change_speed(struct mxs
 		 * overruns too.  (For real raw support).
 		 */
 		if (I_IGNPAR(info->tty)) {
-			info->ignore_status_mask |= UART_LSR_OE | UART_LSR_PE | UART_LSR_FE;
-			info->read_status_mask |= UART_LSR_OE | UART_LSR_PE | UART_LSR_FE;
+			info->ignore_status_mask |=
+						UART_LSR_OE |
+						UART_LSR_PE |
+						UART_LSR_FE;
+			info->read_status_mask |=
+						UART_LSR_OE |
+						UART_LSR_PE |
+						UART_LSR_FE;
 		}
 	}
-	// following add by Victor Yu. 09-02-2002
+	/* following add by Victor Yu. 09-02-2002 */
 	if (info->IsMoxaMustChipFlag) {
 		spin_lock_irqsave(&info->slock, flags);
 		SET_MOXA_MUST_XON1_VALUE(info->base, START_CHAR(info->tty));
@@ -2698,7 +2792,7 @@ static int mxser_change_speed(struct mxs
 		 */
 		spin_unlock_irqrestore(&info->slock, flags);
 	}
-	// above add by Victor Yu. 09-02-2002
+	/* above add by Victor Yu. 09-02-2002 */
 
 
 	outb(fcr, info->base + UART_FCR);	/* set fcr */
@@ -2729,10 +2823,8 @@ static int mxser_set_baud(struct mxser_s
 		quot = (2 * info->baud_base / 269);
 	} else if (newspd) {
 		quot = info->baud_base / newspd;
-
 		if (quot == 0)
 			quot = 1;
-
 	} else {
 		quot = 0;
 	}
@@ -2765,8 +2857,6 @@ static int mxser_set_baud(struct mxser_s
 	return ret;
 }
 
-
-
 /*
  * ------------------------------------------------------------
  * friends of mxser_ioctl()
@@ -2777,7 +2867,7 @@ static int mxser_get_serial_info(struct 
 	struct serial_struct tmp;
 
 	if (!retinfo)
-		return (-EFAULT);
+		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = info->type;
 	tmp.line = info->port;
@@ -2791,7 +2881,7 @@ static int mxser_get_serial_info(struct 
 	tmp.hub6 = 0;
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;
-	return (0);
+	return 0;
 }
 
 static int mxser_set_serial_info(struct mxser_struct *info, struct serial_struct __user *new_info)
@@ -2801,29 +2891,37 @@ static int mxser_set_serial_info(struct 
 	int retval = 0;
 
 	if (!new_info || !info->base)
-		return (-EFAULT);
+		return -EFAULT;
 	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
 		return -EFAULT;
 
-	if ((new_serial.irq != info->irq) || (new_serial.port != info->base) || (new_serial.custom_divisor != info->custom_divisor) || (new_serial.baud_base != info->baud_base))
-		return (-EPERM);
+	if ((new_serial.irq != info->irq) ||
+			(new_serial.port != info->base) ||
+			(new_serial.custom_divisor != info->custom_divisor) ||
+			(new_serial.baud_base != info->baud_base))
+		return -EPERM;
 
 	flags = info->flags & ASYNC_SPD_MASK;
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if ((new_serial.baud_base != info->baud_base) || (new_serial.close_delay != info->close_delay) || ((new_serial.flags & ~ASYNC_USR_MASK) != (info->flags & ~ASYNC_USR_MASK)))
-			return (-EPERM);
-		info->flags = ((info->flags & ~ASYNC_USR_MASK) | (new_serial.flags & ASYNC_USR_MASK));
+		if ((new_serial.baud_base != info->baud_base) ||
+				(new_serial.close_delay != info->close_delay) ||
+				((new_serial.flags & ~ASYNC_USR_MASK) != (info->flags & ~ASYNC_USR_MASK)))
+			return -EPERM;
+		info->flags = ((info->flags & ~ASYNC_USR_MASK) |
+				(new_serial.flags & ASYNC_USR_MASK));
 	} else {
 		/*
 		 * OK, past this point, all the error checking has been done.
 		 * At this point, we start making changes.....
 		 */
-		info->flags = ((info->flags & ~ASYNC_FLAGS) | (new_serial.flags & ASYNC_FLAGS));
+		info->flags = ((info->flags & ~ASYNC_FLAGS) |
+				(new_serial.flags & ASYNC_FLAGS));
 		info->close_delay = new_serial.close_delay * HZ / 100;
 		info->closing_wait = new_serial.closing_wait * HZ / 100;
-		info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-		info->tty->low_latency = 0;	//(info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
+		info->tty->low_latency =
+				(info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
+		info->tty->low_latency = 0;	/* (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0; */
 	}
 
 	/* added by casper, 3/17/2000, for mouse */
@@ -2831,7 +2929,6 @@ static int mxser_set_serial_info(struct 
 
 	process_txrx_fifo(info);
 
-	/* */
 	if (info->flags & ASYNC_INITIALIZED) {
 		if (flags != (info->flags & ASYNC_SPD_MASK)) {
 			mxser_change_speed(info, NULL);
@@ -2839,7 +2936,7 @@ static int mxser_set_serial_info(struct 
 	} else {
 		retval = mxser_startup(info);
 	}
-	return (retval);
+	return retval;
 }
 
 /*
@@ -2876,11 +2973,13 @@ static void mxser_send_break(struct mxse
 		return;
 	set_current_state(TASK_INTERRUPTIBLE);
 	spin_lock_irqsave(&info->slock, flags);
-	outb(inb(info->base + UART_LCR) | UART_LCR_SBC, info->base + UART_LCR);
+	outb(inb(info->base + UART_LCR) | UART_LCR_SBC,
+		info->base + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 	schedule_timeout(duration);
 	spin_lock_irqsave(&info->slock, flags);
-	outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC, info->base + UART_LCR);
+	outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC,
+		info->base + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
@@ -2892,9 +2991,9 @@ static int mxser_tiocmget(struct tty_str
 
 
 	if (tty->index == MXSER_PORTS)
-		return (-ENOIOCTLCMD);
+		return -ENOIOCTLCMD;
 	if (tty->flags & (1 << TTY_IO_ERROR))
-		return (-EIO);
+		return -EIO;
 
 	control = info->MCR;
 
@@ -2904,7 +3003,11 @@ static int mxser_tiocmget(struct tty_str
 		mxser_check_modem_status(info, status);
 	spin_unlock_irqrestore(&info->slock, flags);
 	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
-	    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) | ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) | ((status & UART_MSR_RI) ? TIOCM_RNG : 0) | ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) | ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
+		    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
+		    ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) |
+		    ((status & UART_MSR_RI) ? TIOCM_RNG : 0) |
+		    ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) |
+		    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
 }
 
 static int mxser_tiocmset(struct tty_struct *tty, struct file *file, unsigned int set, unsigned int clear)
@@ -2968,38 +3071,36 @@ static int mxser_get_ISA_conf(int cap, s
 		hwconf->board_type = MXSER_BOARD_CI104J;
 		hwconf->ports = 4;
 	} else
-		return (0);
+		return 0;
 
 	irq = 0;
 	if (hwconf->ports == 2) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		if (irq != (regs[9] & 0xFF00))
-			return (MXSER_ERR_IRQ_CONFLIT);
+			return MXSER_ERR_IRQ_CONFLIT;
 	} else if (hwconf->ports == 4) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		irq = irq | (irq >> 8);
 		if (irq != regs[9])
-			return (MXSER_ERR_IRQ_CONFLIT);
+			return MXSER_ERR_IRQ_CONFLIT;
 	} else if (hwconf->ports == 8) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		irq = irq | (irq >> 8);
 		if ((irq != regs[9]) || (irq != regs[10]))
-			return (MXSER_ERR_IRQ_CONFLIT);
+			return MXSER_ERR_IRQ_CONFLIT;
 	}
 
-	if (!irq) {
-		return (MXSER_ERR_IRQ);
-	}
-	hwconf->irq = ((int) (irq & 0xF000) >> 12);
+	if (!irq)
+		return MXSER_ERR_IRQ;
+	hwconf->irq = ((int)(irq & 0xF000) >> 12);
 	for (i = 0; i < 8; i++)
 		hwconf->ioaddr[i] = (int) regs[i + 1] & 0xFFF8;
-	if ((regs[12] & 0x80) == 0) {
-		return (MXSER_ERR_VECTOR);
-	}
-	hwconf->vector = (int) regs[11];	/* interrupt vector */
+	if ((regs[12] & 0x80) == 0)
+		return MXSER_ERR_VECTOR;
+	hwconf->vector = (int)regs[11];	/* interrupt vector */
 	if (id == 1)
 		hwconf->vector_mask = 0x00FF;
 	else
@@ -3007,10 +3108,10 @@ static int mxser_get_ISA_conf(int cap, s
 	for (i = 7, bits = 0x0100; i >= 0; i--, bits <<= 1) {
 		if (regs[12] & bits) {
 			hwconf->baud_base[i] = 921600;
-			hwconf->MaxCanSetBaudRate[i] = 921600;	// add by Victor Yu. 09-04-2002
+			hwconf->MaxCanSetBaudRate[i] = 921600;	/* add by Victor Yu. 09-04-2002 */
 		} else {
 			hwconf->baud_base[i] = 115200;
-			hwconf->MaxCanSetBaudRate[i] = 115200;	// add by Victor Yu. 09-04-2002
+			hwconf->MaxCanSetBaudRate[i] = 115200;	/* add by Victor Yu. 09-04-2002 */
 		}
 	}
 	scratch2 = inb(cap + UART_LCR) & (~UART_LCR_DLAB);
@@ -3030,7 +3131,7 @@ static int mxser_get_ISA_conf(int cap, s
 		hwconf->ports = 4;
 	request_region(hwconf->ioaddr[0], 8 * hwconf->ports, "mxser(IO)");
 	request_region(hwconf->vector, 1, "mxser(vector)");
-	return (hwconf->ports);
+	return hwconf->ports;
 }
 
 #define CHIP_SK 	0x01	/* Serial Data Clock  in Eprom */
@@ -3053,7 +3154,7 @@ static int mxser_read_register(int port,
 
 	id = mxser_program_mode(port);
 	if (id < 0)
-		return (id);
+		return id;
 	for (i = 0; i < 14; i++) {
 		k = (i & 0x3F) | 0x180;
 		for (j = 0x100; j > 0; j >>= 1) {
@@ -3066,7 +3167,7 @@ static int mxser_read_register(int port,
 				outb(CHIP_CS | CHIP_SK, port);	/* A? bit of read */
 			}
 		}
-		(void) inb(port);
+		(void)inb(port);
 		value = 0;
 		for (k = 0, j = 0x8000; k < 16; k++, j >>= 1) {
 			outb(CHIP_CS, port);
@@ -3078,28 +3179,33 @@ static int mxser_read_register(int port,
 		outb(0, port);
 	}
 	mxser_normal_mode(port);
-	return (id);
+	return id;
 }
 
 static int mxser_program_mode(int port)
 {
 	int id, i, j, n;
-	//unsigned long flags;
+	/* unsigned long flags; */
 
 	spin_lock(&gm_lock);
 	outb(0, port);
 	outb(0, port);
 	outb(0, port);
-	(void) inb(port);
-	(void) inb(port);
+	(void)inb(port);
+	(void)inb(port);
 	outb(0, port);
-	(void) inb(port);
-	//restore_flags(flags);
+	(void)inb(port);
+	/* restore_flags(flags); */
 	spin_unlock(&gm_lock);
 
 	id = inb(port + 1) & 0x1F;
-	if ((id != C168_ASIC_ID) && (id != C104_ASIC_ID) && (id != C102_ASIC_ID) && (id != CI132_ASIC_ID) && (id != CI134_ASIC_ID) && (id != CI104J_ASIC_ID))
-		return (-1);
+	if ((id != C168_ASIC_ID) &&
+			(id != C104_ASIC_ID) &&
+			(id != C102_ASIC_ID) &&
+			(id != CI132_ASIC_ID) &&
+			(id != CI134_ASIC_ID) &&
+			(id != CI104J_ASIC_ID))
+		return -1;
 	for (i = 0, j = 0; i < 4; i++) {
 		n = inb(port + 2);
 		if (n == 'M') {
@@ -3112,7 +3218,7 @@ static int mxser_program_mode(int port)
 	}
 	if (j != 2)
 		id = -2;
-	return (id);
+	return id;
 }
 
 static void mxser_normal_mode(int port)
@@ -3130,7 +3236,7 @@ static void mxser_normal_mode(int port)
 		if ((n & 0x61) == 0x60)
 			break;
 		if ((n & 1) == 1)
-			(void) inb(port);
+			(void)inb(port);
 	}
 	outb(0x00, port + 4);
 }



