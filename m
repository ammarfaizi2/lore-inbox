Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965559AbWKDR07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965559AbWKDR07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965558AbWKDR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:26:59 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:741 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S965559AbWKDR05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:26:57 -0500
Message-id: <1121260032782426000@wsc.cz>
Subject: [PATCH 4/6] Char: stallion, remove syntactic sugar
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 18:26:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, remove syntactic sugar

Remove useless parenthesis and brackets.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 02cadc8f971f2cb43ed58957092eea50ef359314
tree e50007c52c0fd670bf72d4819d8c5dfe599e4e59
parent 35d35cadc88b0f52cc4824fafc6a16f3c9301ef0
author Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 19:43:15 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 19:43:15 +0100

 drivers/char/stallion.c |  178 +++++++++++++++++++++--------------------------
 1 files changed, 81 insertions(+), 97 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 072a226..28e61ae 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -639,13 +639,13 @@ static int __init stl_parsebrd(struct st
 	if ((argp[0] == NULL) || (*argp[0] == 0))
 		return 0;
 
-	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
+	for (sp = argp[0], i = 0; (*sp != 0) && (i < 25); sp++, i++)
 		*sp = tolower(*sp);
 
-	for (i = 0; i < ARRAY_SIZE(stl_brdstr); i++) {
+	for (i = 0; i < ARRAY_SIZE(stl_brdstr); i++)
 		if (strcmp(stl_brdstr[i].name, argp[0]) == 0)
 			break;
-	}
+
 	if (i == ARRAY_SIZE(stl_brdstr)) {
 		printk("STALLION: unknown board name, %s?\n", argp[0]);
 		return 0;
@@ -707,7 +707,7 @@ static int stl_open(struct tty_struct *t
 	if (brdp == NULL)
 		return -ENODEV;
 	minordev = MINOR2PORT(minordev);
-	for (portnr = -1, panelnr = 0; (panelnr < STL_MAXPANELS); panelnr++) {
+	for (portnr = -1, panelnr = 0; panelnr < STL_MAXPANELS; panelnr++) {
 		if (brdp->panels[panelnr] == NULL)
 			break;
 		if (minordev < brdp->panels[panelnr]->nrports) {
@@ -766,10 +766,10 @@ static int stl_open(struct tty_struct *t
  *	previous opens still in effect. If we are a normal serial device
  *	then also we might have to wait for carrier.
  */
-	if (!(filp->f_flags & O_NONBLOCK)) {
+	if (!(filp->f_flags & O_NONBLOCK))
 		if ((rc = stl_waitcarrier(portp, filp)) != 0)
 			return rc;
-	}
+
 	portp->flags |= ASYNC_NORMAL_ACTIVE;
 
 	return 0;
@@ -813,9 +813,8 @@ static int stl_waitcarrier(struct stlpor
 			break;
 		}
 		if (((portp->flags & ASYNC_CLOSING) == 0) &&
-		    (doclocal || (portp->sigs & TIOCM_CD))) {
+		    (doclocal || (portp->sigs & TIOCM_CD)))
 			break;
-		}
 		if (signal_pending(current)) {
 			rc = -ERESTARTSYS;
 			break;
@@ -1091,7 +1090,7 @@ static int stl_writeroom(struct tty_stru
 
 	head = portp->tx.head;
 	tail = portp->tx.tail;
-	return ((head >= tail) ? (STL_TXBUFSIZE - (head - tail) - 1) : (tail - head - 1));
+	return (head >= tail) ? (STL_TXBUFSIZE - (head - tail) - 1) : (tail - head - 1);
 }
 
 /*****************************************************************************/
@@ -1261,10 +1260,9 @@ static int stl_ioctl(struct tty_struct *
 		return -ENODEV;
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
- 	    (cmd != COM_GETPORTSTATS) && (cmd != COM_CLRPORTSTATS)) {
+ 	    (cmd != COM_GETPORTSTATS) && (cmd != COM_CLRPORTSTATS))
 		if (tty->flags & (1 << TTY_IO_ERROR))
 			return -EIO;
-	}
 
 	rc = 0;
 
@@ -1538,7 +1536,7 @@ static int stl_portinfo(struct stlport *
 	*sp = ' ';
 	sp += cnt;
 
-	for (cnt = (sp - pos); (cnt < (MAXLINE - 1)); cnt++)
+	for (cnt = sp - pos; cnt < (MAXLINE - 1); cnt++)
 		*sp++ = ' ';
 	if (cnt >= MAXLINE)
 		pos[(MAXLINE - 2)] = '+';
@@ -1582,7 +1580,7 @@ static int stl_readproc(char *page, char
  *	We scan through for each board, panel and port. The offset is
  *	calculated on the fly, and irrelevant ports are skipped.
  */
-	for (brdnr = 0; (brdnr < stl_nrbrds); brdnr++) {
+	for (brdnr = 0; brdnr < stl_nrbrds; brdnr++) {
 		brdp = stl_brds[brdnr];
 		if (brdp == NULL)
 			continue;
@@ -1596,7 +1594,7 @@ static int stl_readproc(char *page, char
 		}
 
 		totalport = brdnr * STL_MAXPORTS;
-		for (panelnr = 0; (panelnr < brdp->nrpanels); panelnr++) {
+		for (panelnr = 0; panelnr < brdp->nrpanels; panelnr++) {
 			panelp = brdp->panels[panelnr];
 			if (panelp == NULL)
 				continue;
@@ -1608,7 +1606,7 @@ static int stl_readproc(char *page, char
 				continue;
 			}
 
-			for (portnr = 0; (portnr < panelp->nrports); portnr++,
+			for (portnr = 0; portnr < panelp->nrports; portnr++,
 			    totalport++) {
 				portp = panelp->ports[portnr];
 				if (portp == NULL)
@@ -1626,7 +1624,7 @@ static int stl_readproc(char *page, char
 
 stl_readdone:
 	*start = page;
-	return (pos - page);
+	return pos - page;
 }
 
 /*****************************************************************************/
@@ -1685,7 +1683,7 @@ static int stl_echatintr(struct stlbrd *
 
 	while (inb(brdp->iostatus) & ECH_INTRPEND) {
 		handled = 1;
-		for (bnknr = 0; (bnknr < brdp->nrbnks); bnknr++) {
+		for (bnknr = 0; bnknr < brdp->nrbnks; bnknr++) {
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
@@ -1714,7 +1712,7 @@ static int stl_echmcaintr(struct stlbrd 
 
 	while (inb(brdp->iostatus) & ECH_INTRPEND) {
 		handled = 1;
-		for (bnknr = 0; (bnknr < brdp->nrbnks); bnknr++) {
+		for (bnknr = 0; bnknr < brdp->nrbnks; bnknr++) {
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
@@ -1740,7 +1738,7 @@ static int stl_echpciintr(struct stlbrd 
 
 	while (1) {
 		recheck = 0;
-		for (bnknr = 0; (bnknr < brdp->nrbnks); bnknr++) {
+		for (bnknr = 0; bnknr < brdp->nrbnks; bnknr++) {
 			outb(brdp->bnkpageaddr[bnknr], brdp->ioctrl);
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
@@ -1771,7 +1769,7 @@ static int stl_echpci64intr(struct stlbr
 
 	while (inb(brdp->ioctrl) & 0x1) {
 		handled = 1;
-		for (bnknr = 0; (bnknr < brdp->nrbnks); bnknr++) {
+		for (bnknr = 0; bnknr < brdp->nrbnks; bnknr++) {
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
@@ -1806,19 +1804,18 @@ static void stl_offintr(void *private)
 		return;
 
 	lock_kernel();
-	if (test_bit(ASYI_TXLOW, &portp->istate)) {
+	if (test_bit(ASYI_TXLOW, &portp->istate))
 		tty_wakeup(tty);
-	}
+
 	if (test_bit(ASYI_DCDCHANGE, &portp->istate)) {
 		clear_bit(ASYI_DCDCHANGE, &portp->istate);
 		oldsigs = portp->sigs;
 		portp->sigs = stl_getsignals(portp);
 		if ((portp->sigs & TIOCM_CD) && ((oldsigs & TIOCM_CD) == 0))
 			wake_up_interruptible(&portp->open_wait);
-		if ((oldsigs & TIOCM_CD) && ((portp->sigs & TIOCM_CD) == 0)) {
+		if ((oldsigs & TIOCM_CD) && ((portp->sigs & TIOCM_CD) == 0))
 			if (portp->flags & ASYNC_CHECK_CD)
 				tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
-		}
 	}
 	unlock_kernel();
 }
@@ -1842,7 +1839,7 @@ static int __devinit stl_initports(struc
  *	All UART's are initialized (if found!). Now go through and setup
  *	each ports data structures.
  */
-	for (i = 0; (i < panelp->nrports); i++) {
+	for (i = 0; i < panelp->nrports; i++) {
 		portp = kzalloc(sizeof(struct stlport), GFP_KERNEL);
 		if (!portp) {
 			printk("STALLION: failed to allocate memory "
@@ -1869,7 +1866,7 @@ static int __devinit stl_initports(struc
 		stl_portinit(brdp, panelp, portp);
 	}
 
-	return(0);
+	return 0;
 }
 
 static void stl_cleanup_panels(struct stlbrd *brdp)
@@ -2094,7 +2091,7 @@ static int __devinit stl_initech(struct 
 		outb((status | ECH_BRDRESET), brdp->ioaddr1);
 		brdp->ioctrlval = ECH_INTENABLE |
 			((brdp->irqtype) ? ECH_INTLEVEL : ECH_INTEDGE);
-		for (i = 0; (i < 10); i++)
+		for (i = 0; i < 10; i++)
 			outb((brdp->ioctrlval | ECH_BRDENABLE), brdp->ioctrl);
 		brdp->iosize1 = 2;
 		brdp->iosize2 = 32;
@@ -2182,7 +2179,7 @@ static int __devinit stl_initech(struct 
 	panelnr = 0;
 	nxtid = 0;
 
-	for (i = 0; (i < STL_MAXPANELS); i++) {
+	for (i = 0; i < STL_MAXPANELS; i++) {
 		if (brdp->brdtype == BRD_ECHPCI) {
 			outb(nxtid, brdp->ioctrl);
 			ioaddr = brdp->ioaddr2;
@@ -2215,9 +2212,8 @@ static int __devinit stl_initech(struct 
 				brdp->bnkpageaddr[banknr] = nxtid;
 				brdp->bnkstataddr[banknr++] = ioaddr + 4 +
 					ECH_PNLSTATUS;
-			} else {
+			} else
 				panelp->nrports = 8;
-			}
 		} else {
 			panelp->uartp = &stl_cd1400uart;
 			panelp->isr = stl_cd1400echintr;
@@ -2313,7 +2309,7 @@ static int __devinit stl_brdinit(struct 
 		goto err_free;
 	}
 
-	for (i = 0; (i < STL_MAXPANELS); i++)
+	for (i = 0; i < STL_MAXPANELS; i++)
 		if (brdp->panels[i] != NULL)
 			stl_initports(brdp, brdp->panels[i]);
 
@@ -2345,14 +2341,14 @@ static int __devinit stl_getbrdnr(void)
 {
 	int	i;
 
-	for (i = 0; (i < STL_MAXBRDS); i++) {
+	for (i = 0; i < STL_MAXBRDS; i++)
 		if (stl_brds[i] == NULL) {
 			if (i >= stl_nrbrds)
 				stl_nrbrds = i + 1;
-			return(i);
+			return i;
 		}
-	}
-	return(-1);
+
+	return -1;
 }
 
 /*****************************************************************************/
@@ -2473,10 +2469,10 @@ static int stl_getbrdstats(combrd_t __us
 	if (copy_from_user(&stl_brdstats, bp, sizeof(combrd_t)))
 		return -EFAULT;
 	if (stl_brdstats.brd >= STL_MAXBRDS)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stl_brds[stl_brdstats.brd];
 	if (brdp == NULL)
-		return(-ENODEV);
+		return -ENODEV;
 
 	memset(&stl_brdstats, 0, sizeof(combrd_t));
 	stl_brdstats.brd = brdp->brdnr;
@@ -2488,7 +2484,7 @@ static int stl_getbrdstats(combrd_t __us
 	stl_brdstats.irq = brdp->irq;
 	stl_brdstats.nrpanels = brdp->nrpanels;
 	stl_brdstats.nrports = brdp->nrports;
-	for (i = 0; (i < brdp->nrpanels); i++) {
+	for (i = 0; i < brdp->nrpanels; i++) {
 		panelp = brdp->panels[i];
 		stl_brdstats.panels[i].panel = i;
 		stl_brdstats.panels[i].hwid = panelp->hwid;
@@ -2509,19 +2505,19 @@ static struct stlport *stl_getport(int b
 	struct stlbrd	*brdp;
 	struct stlpanel	*panelp;
 
-	if ((brdnr < 0) || (brdnr >= STL_MAXBRDS))
-		return(NULL);
+	if (brdnr < 0 || brdnr >= STL_MAXBRDS)
+		return NULL;
 	brdp = stl_brds[brdnr];
 	if (brdp == NULL)
-		return(NULL);
-	if ((panelnr < 0) || (panelnr >= brdp->nrpanels))
-		return(NULL);
+		return NULL;
+	if (panelnr < 0 || panelnr >= brdp->nrpanels)
+		return NULL;
 	panelp = brdp->panels[panelnr];
 	if (panelp == NULL)
-		return(NULL);
-	if ((portnr < 0) || (portnr >= panelp->nrports))
-		return(NULL);
-	return(panelp->ports[portnr]);
+		return NULL;
+	if (portnr < 0 || portnr >= panelp->nrports)
+		return NULL;
+	return panelp->ports[portnr];
 }
 
 /*****************************************************************************/
@@ -2543,7 +2539,7 @@ static int stl_getportstats(struct stlpo
 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
 			stl_comstats.port);
 		if (portp == NULL)
-			return(-ENODEV);
+			return -ENODEV;
 	}
 
 	portp->stats.state = portp->istate;
@@ -2558,7 +2554,7 @@ static int stl_getportstats(struct stlpo
 	portp->stats.rxbuffered = 0;
 
 	spin_lock_irqsave(&stallion_lock, flags);
-	if (portp->tty != NULL) {
+	if (portp->tty != NULL)
 		if (portp->tty->driver_data == portp) {
 			portp->stats.ttystate = portp->tty->flags;
 			/* No longer available as a statistic */
@@ -2570,13 +2566,12 @@ static int stl_getportstats(struct stlpo
 				portp->stats.lflags = portp->tty->termios->c_lflag;
 			}
 		}
-	}
 	spin_unlock_irqrestore(&stallion_lock, flags);
 
 	head = portp->tx.head;
 	tail = portp->tx.tail;
-	portp->stats.txbuffered = ((head >= tail) ? (head - tail) :
-		(STL_TXBUFSIZE - (tail - head)));
+	portp->stats.txbuffered = (head >= tail) ? (head - tail) :
+		(STL_TXBUFSIZE - (tail - head));
 
 	portp->stats.signals = (unsigned long) stl_getsignals(portp);
 
@@ -2598,7 +2593,7 @@ static int stl_clrportstats(struct stlpo
 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
 			stl_comstats.port);
 		if (portp == NULL)
-			return(-ENODEV);
+			return -ENODEV;
 	}
 
 	memset(&portp->stats, 0, sizeof(comstats_t));
@@ -2644,7 +2639,7 @@ static int stl_getbrdstruct(struct stlbr
 		return -ENODEV;
 	brdp = stl_brds[stl_dummybrd.brdnr];
 	if (!brdp)
-		return(-ENODEV);
+		return -ENODEV;
 	return copy_to_user(arg, brdp, sizeof(struct stlbrd)) ? -EFAULT : 0;
 }
 
@@ -2665,7 +2660,7 @@ static int stl_memioctl(struct inode *ip
 
 	brdnr = iminor(ip);
 	if (brdnr >= STL_MAXBRDS)
-		return(-ENODEV);
+		return -ENODEV;
 	rc = 0;
 
 	switch (cmd) {
@@ -2689,7 +2684,7 @@ static int stl_memioctl(struct inode *ip
 		break;
 	}
 
-	return(rc);
+	return rc;
 }
 
 static const struct tty_operations stl_ops = {
@@ -2734,13 +2729,13 @@ static int stl_cd1400getreg(struct stlpo
 
 static void stl_cd1400setreg(struct stlport *portp, int regnr, int value)
 {
-	outb((regnr + portp->uartaddr), portp->ioaddr);
+	outb(regnr + portp->uartaddr, portp->ioaddr);
 	outb(value, portp->ioaddr + EREG_DATA);
 }
 
 static int stl_cd1400updatereg(struct stlport *portp, int regnr, int value)
 {
-	outb((regnr + portp->uartaddr), portp->ioaddr);
+	outb(regnr + portp->uartaddr, portp->ioaddr);
 	if (inb(portp->ioaddr + EREG_DATA) != value) {
 		outb(value, portp->ioaddr + EREG_DATA);
 		return 1;
@@ -2773,13 +2768,12 @@ static int stl_cd1400panelinit(struct st
  */
 	chipmask = 0;
 	nrchips = panelp->nrports / CD1400_PORTS;
-	for (i = 0; (i < nrchips); i++) {
+	for (i = 0; i < nrchips; i++) {
 		if (brdp->brdtype == BRD_ECHPCI) {
 			outb((panelp->pagenr + (i >> 1)), brdp->ioctrl);
 			ioaddr = panelp->iobase;
-		} else {
+		} else
 			ioaddr = panelp->iobase + (EREG_BANKSIZE * (i >> 1));
-		}
 		uartaddr = (i & 0x01) ? 0x080 : 0;
 		outb((GFRCR + uartaddr), ioaddr);
 		outb(0, (ioaddr + EREG_DATA));
@@ -2787,10 +2781,10 @@ static int stl_cd1400panelinit(struct st
 		outb(CCR_RESETFULL, (ioaddr + EREG_DATA));
 		outb(CCR_RESETFULL, (ioaddr + EREG_DATA));
 		outb((GFRCR + uartaddr), ioaddr);
-		for (j = 0; (j < CCR_MAXWAIT); j++) {
+		for (j = 0; j < CCR_MAXWAIT; j++)
 			if ((gfrcr = inb(ioaddr + EREG_DATA)) != 0)
 				break;
-		}
+
 		if ((j >= CCR_MAXWAIT) || (gfrcr < 0x40) || (gfrcr > 0x60)) {
 			printk("STALLION: cd1400 not responding, "
 				"brd=%d panel=%d chip=%d\n",
@@ -2848,11 +2842,9 @@ static void stl_cd1400ccrwait(struct stl
 {
 	int	i;
 
-	for (i = 0; (i < CCR_MAXWAIT); i++) {
-		if (stl_cd1400getreg(portp, CCR) == 0) {
+	for (i = 0; i < CCR_MAXWAIT; i++)
+		if (stl_cd1400getreg(portp, CCR) == 0)
 			return;
-		}
-	}
 
 	printk("STALLION: cd1400 not responding, port=%d panel=%d brd=%d\n",
 		portp->portnr, portp->panelnr, portp->brdnr);
@@ -2988,8 +2980,8 @@ static void stl_cd1400setport(struct stl
 		baudrate = STL_CD1400MAXBAUD;
 
 	if (baudrate > 0) {
-		for (clk = 0; (clk < CD1400_NUMCLKS); clk++) {
-			clkdiv = ((portp->clk / stl_cd1400clkdivs[clk]) / baudrate);
+		for (clk = 0; clk < CD1400_NUMCLKS; clk++) {
+			clkdiv = (portp->clk / stl_cd1400clkdivs[clk]) / baudrate;
 			if (clkdiv < 0x100)
 				break;
 		}
@@ -3004,9 +2996,8 @@ static void stl_cd1400setport(struct stl
 		mcor2 |= MCOR2_DCD;
 		sreron |= SRER_MODEM;
 		portp->flags |= ASYNC_CHECK_CD;
-	} else {
+	} else
 		portp->flags &= ~ASYNC_CHECK_CD;
-	}
 
 /*
  *	Setup cd1400 enhanced modes if we can. In particular we want to
@@ -3650,18 +3641,16 @@ static void stl_cd1400rxisr(struct stlpa
 						do_SAK(tty);
 						BRDENABLE(portp->brdnr, portp->pagenr);
 					}
-				} else if (status & ST_PARITY) {
+				} else if (status & ST_PARITY)
 					status = TTY_PARITY;
-				} else if (status & ST_FRAMING) {
+				else if (status & ST_FRAMING)
 					status = TTY_FRAME;
-				} else if(status & ST_OVERRUN) {
+				else if(status & ST_OVERRUN)
 					status = TTY_OVERRUN;
-				} else {
+				else
 					status = 0;
-				}
-			} else {
+			} else
 				status = 0;
-			}
 			tty_insert_flip_char(tty, ch, status);
 			tty_schedule_flip(tty);
 		}
@@ -3788,7 +3777,7 @@ static int stl_sc26198panelinit(struct s
 	if (brdp->brdtype == BRD_ECHPCI)
 		outb(panelp->pagenr, brdp->ioctrl);
 
-	for (i = 0; (i < nrchips); i++) {
+	for (i = 0; i < nrchips; i++) {
 		ioaddr = panelp->iobase + (i * 4); 
 		outb(SCCR, (ioaddr + XP_ADDR));
 		outb(CR_RESETALL, (ioaddr + XP_DATA));
@@ -3908,9 +3897,8 @@ static void stl_sc26198setport(struct st
 			mr1 |= (MR1_PARENB | MR1_PARODD);
 		else
 			mr1 |= (MR1_PARENB | MR1_PAREVEN);
-	} else {
+	} else
 		mr1 |= MR1_PARNONE;
-	}
 
 	mr1 |= MR1_ERRBLOCK;
 
@@ -3950,12 +3938,10 @@ static void stl_sc26198setport(struct st
 	if (baudrate > STL_SC26198MAXBAUD)
 		baudrate = STL_SC26198MAXBAUD;
 
-	if (baudrate > 0) {
-		for (clk = 0; (clk < SC26198_NRBAUDS); clk++) {
+	if (baudrate > 0)
+		for (clk = 0; clk < SC26198_NRBAUDS; clk++)
 			if (baudrate <= sc26198_baudtable[clk])
 				break;
-		}
-	}
 
 /*
  *	Check what form of modem signaling is required and set it up.
@@ -3977,9 +3963,9 @@ static void stl_sc26198setport(struct st
 	if (tiosp->c_iflag & IXON) {
 		mr0 |= MR0_SWFTX | MR0_SWFT;
 		imron |= IR_XONXOFF;
-	} else {
+	} else
 		imroff |= IR_XONXOFF;
-	}
+
 	if (tiosp->c_iflag & IXOFF)
 		mr0 |= MR0_SWFRX;
 
@@ -4190,9 +4176,9 @@ static void stl_sc26198sendbreak(struct 
 	if (len == 1) {
 		stl_sc26198setreg(portp, SCCR, CR_TXSTARTBREAK);
 		portp->stats.txbreaks++;
-	} else {
+	} else
 		stl_sc26198setreg(portp, SCCR, CR_TXSTOPBREAK);
-	}
+
 	BRDDISABLE(portp->brdnr);
 	spin_unlock_irqrestore(&brd_lock, flags);
 }
@@ -4376,7 +4362,7 @@ static void stl_sc26198wait(struct stlpo
 	if (portp == NULL)
 		return;
 
-	for (i = 0; (i < 20); i++)
+	for (i = 0; i < 20; i++)
 		stl_sc26198getglobreg(portp, TSTR);
 }
 
@@ -4585,18 +4571,16 @@ static void stl_sc26198rxbadch(struct st
 					do_SAK(tty);
 					BRDENABLE(portp->brdnr, portp->pagenr);
 				}
-			} else if (status & SR_RXPARITY) {
+			} else if (status & SR_RXPARITY)
 				status = TTY_PARITY;
-			} else if (status & SR_RXFRAMING) {
+			else if (status & SR_RXFRAMING)
 				status = TTY_FRAME;
-			} else if(status & SR_RXOVERRUN) {
+			else if(status & SR_RXOVERRUN)
 				status = TTY_OVERRUN;
-			} else {
+			else
 				status = 0;
-			}
-		} else {
+		} else
 			status = 0;
-		}
 
 		tty_insert_flip_char(tty, ch, status);
 		tty_schedule_flip(tty);
