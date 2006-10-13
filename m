Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWJMVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWJMVHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWJMVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:07:39 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:60397 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751921AbWJMVHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:07:37 -0400
Message-id: <3236241001178810397@wsc.cz>
Subject: [PATCH 2/7] Char: stallion, remove unneeded casts
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 13 Oct 2006 23:07:47 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, remove unneeded casts

casts of NULL are unnecessary. And so casts to (void *) are.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b68b0dbe46c87c198d764b214cf663428956135e
tree 926db5d866831aba2d1315300cec15ceb1a1ed00
parent bcedfb013b6cf4869f506acf66d31e73e8d04c10
author Jiri Slaby <jirislaby@gmail.com> Thu, 12 Oct 2006 23:17:19 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 12 Oct 2006 23:17:19 +0200

 drivers/char/stallion.c |  272 ++++++++++++++++++++++++-----------------------
 1 files changed, 136 insertions(+), 136 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 050a4ee..bafaa10 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -187,32 +187,32 @@ #define	ASYI_TXFLOWED	4
  *	referencing boards when printing trace and stuff.
  */
 static char	*stl_brdnames[] = {
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
 	"EasyIO",
 	"EC8/32-AT",
 	"EC8/32-MC",
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
+	NULL,
+	NULL,
+	NULL,
 	"EC8/32-PCI",
 	"EC8/64-PCI",
 	"EasyIO-PCI",
@@ -761,20 +761,20 @@ static void __exit stallion_module_exit(
 	class_destroy(stallion_class);
 
 	for (i = 0; (i < stl_nrbrds); i++) {
-		if ((brdp = stl_brds[i]) == (stlbrd_t *) NULL)
+		if ((brdp = stl_brds[i]) == NULL)
 			continue;
 
 		free_irq(brdp->irq, brdp);
 
 		for (j = 0; (j < STL_MAXPANELS); j++) {
 			panelp = brdp->panels[j];
-			if (panelp == (stlpanel_t *) NULL)
+			if (panelp == NULL)
 				continue;
 			for (k = 0; (k < STL_PORTSPERPANEL); k++) {
 				portp = panelp->ports[k];
-				if (portp == (stlport_t *) NULL)
+				if (portp == NULL)
 					continue;
-				if (portp->tty != (struct tty_struct *) NULL)
+				if (portp->tty != NULL)
 					stl_hangup(portp->tty);
 				kfree(portp->tx.buf);
 				kfree(portp);
@@ -787,7 +787,7 @@ static void __exit stallion_module_exit(
 			release_region(brdp->ioaddr2, brdp->iosize2);
 
 		kfree(brdp);
-		stl_brds[i] = (stlbrd_t *) NULL;
+		stl_brds[i] = NULL;
 	}
 }
 
@@ -812,7 +812,7 @@ static void stl_argbrds(void)
 		memset(&conf, 0, sizeof(conf));
 		if (stl_parsebrd(&conf, stl_brdsp[i]) == 0)
 			continue;
-		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
+		if ((brdp = stl_allocbrd()) == NULL)
 			continue;
 		stl_nrbrds = i + 1;
 		brdp->brdnr = i;
@@ -874,7 +874,7 @@ static int stl_parsebrd(stlconf_t *confp
 
 	pr_debug("stl_parsebrd(confp=%p,argp=%p)\n", confp, argp);
 
-	if ((argp[0] == (char *) NULL) || (*argp[0] == 0))
+	if ((argp[0] == NULL) || (*argp[0] == 0))
 		return 0;
 
 	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
@@ -892,15 +892,15 @@ static int stl_parsebrd(stlconf_t *confp
 	confp->brdtype = stl_brdstr[i].type;
 
 	i = 1;
-	if ((argp[i] != (char *) NULL) && (*argp[i] != 0))
+	if ((argp[i] != NULL) && (*argp[i] != 0))
 		confp->ioaddr1 = stl_atol(argp[i]);
 	i++;
 	if (confp->brdtype == BRD_ECH) {
-		if ((argp[i] != (char *) NULL) && (*argp[i] != 0))
+		if ((argp[i] != NULL) && (*argp[i] != 0))
 			confp->ioaddr2 = stl_atol(argp[i]);
 		i++;
 	}
-	if ((argp[i] != (char *) NULL) && (*argp[i] != 0))
+	if ((argp[i] != NULL) && (*argp[i] != 0))
 		confp->irq = stl_atol(argp[i]);
 	return 1;
 }
@@ -942,11 +942,11 @@ static int stl_open(struct tty_struct *t
 	if (brdnr >= stl_nrbrds)
 		return -ENODEV;
 	brdp = stl_brds[brdnr];
-	if (brdp == (stlbrd_t *) NULL)
+	if (brdp == NULL)
 		return -ENODEV;
 	minordev = MINOR2PORT(minordev);
 	for (portnr = -1, panelnr = 0; (panelnr < STL_MAXPANELS); panelnr++) {
-		if (brdp->panels[panelnr] == (stlpanel_t *) NULL)
+		if (brdp->panels[panelnr] == NULL)
 			break;
 		if (minordev < brdp->panels[panelnr]->nrports) {
 			portnr = minordev;
@@ -958,7 +958,7 @@ static int stl_open(struct tty_struct *t
 		return -ENODEV;
 
 	portp = brdp->panels[panelnr]->ports[portnr];
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return -ENODEV;
 
 /*
@@ -1080,7 +1080,7 @@ static void stl_close(struct tty_struct 
 	pr_debug("stl_close(tty=%p,filp=%p)\n", tty, filp);
 
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	spin_lock_irqsave(&stallion_lock, flags);
@@ -1123,17 +1123,17 @@ static void stl_close(struct tty_struct 
 	stl_enablerxtx(portp, 0, 0);
 	stl_flushbuffer(tty);
 	portp->istate = 0;
-	if (portp->tx.buf != (char *) NULL) {
+	if (portp->tx.buf != NULL) {
 		kfree(portp->tx.buf);
-		portp->tx.buf = (char *) NULL;
-		portp->tx.head = (char *) NULL;
-		portp->tx.tail = (char *) NULL;
+		portp->tx.buf = NULL;
+		portp->tx.head = NULL;
+		portp->tx.tail = NULL;
 	}
 	set_bit(TTY_IO_ERROR, &tty->flags);
 	tty_ldisc_flush(tty);
 
 	tty->closing = 0;
-	portp->tty = (struct tty_struct *) NULL;
+	portp->tty = NULL;
 
 	if (portp->openwaitcnt) {
 		if (portp->close_delay)
@@ -1162,9 +1162,9 @@ static int stl_write(struct tty_struct *
 	pr_debug("stl_write(tty=%p,buf=%p,count=%d)\n", tty, buf, count);
 
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return 0;
-	if (portp->tx.buf == (char *) NULL)
+	if (portp->tx.buf == NULL)
 		return 0;
 
 /*
@@ -1217,12 +1217,12 @@ static void stl_putchar(struct tty_struc
 
 	pr_debug("stl_putchar(tty=%p,ch=%x)\n", tty, ch);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if (portp->tx.buf == (char *) NULL)
+	if (portp->tx.buf == NULL)
 		return;
 
 	head = portp->tx.head;
@@ -1253,12 +1253,12 @@ static void stl_flushchars(struct tty_st
 
 	pr_debug("stl_flushchars(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if (portp->tx.buf == (char *) NULL)
+	if (portp->tx.buf == NULL)
 		return;
 
 	stl_startrxtx(portp, -1, 1);
@@ -1273,12 +1273,12 @@ static int stl_writeroom(struct tty_stru
 
 	pr_debug("stl_writeroom(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return 0;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return 0;
-	if (portp->tx.buf == (char *) NULL)
+	if (portp->tx.buf == NULL)
 		return 0;
 
 	head = portp->tx.head;
@@ -1305,12 +1305,12 @@ static int stl_charsinbuffer(struct tty_
 
 	pr_debug("stl_charsinbuffer(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return 0;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return 0;
-	if (portp->tx.buf == (char *) NULL)
+	if (portp->tx.buf == NULL)
 		return 0;
 
 	head = portp->tx.head;
@@ -1352,7 +1352,7 @@ static int stl_getserial(stlport_t *port
 	}
 
 	brdp = stl_brds[portp->brdnr];
-	if (brdp != (stlbrd_t *) NULL)
+	if (brdp != NULL)
 		sio.irq = brdp->irq;
 
 	return copy_to_user(sp, &sio, sizeof(struct serial_struct)) ? -EFAULT : 0;
@@ -1398,10 +1398,10 @@ static int stl_tiocmget(struct tty_struc
 {
 	stlport_t	*portp;
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return -ENODEV;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
@@ -1415,10 +1415,10 @@ static int stl_tiocmset(struct tty_struc
 	stlport_t	*portp;
 	int rts = -1, dtr = -1;
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return -ENODEV;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
@@ -1446,10 +1446,10 @@ static int stl_ioctl(struct tty_struct *
 	pr_debug("stl_ioctl(tty=%p,file=%p,cmd=%x,arg=%lx)\n", tty, file, cmd,
 			arg);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return -ENODEV;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return -ENODEV;
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
@@ -1508,10 +1508,10 @@ static void stl_settermios(struct tty_st
 
 	pr_debug("stl_settermios(tty=%p,old=%p)\n", tty, old);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	tiosp = tty->termios;
@@ -1543,10 +1543,10 @@ static void stl_throttle(struct tty_stru
 
 	pr_debug("stl_throttle(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	stl_flowctrl(portp, 0);
 }
@@ -1563,10 +1563,10 @@ static void stl_unthrottle(struct tty_st
 
 	pr_debug("stl_unthrottle(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	stl_flowctrl(portp, 1);
 }
@@ -1584,10 +1584,10 @@ static void stl_stop(struct tty_struct *
 
 	pr_debug("stl_stop(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	stl_startrxtx(portp, -1, 0);
 }
@@ -1604,10 +1604,10 @@ static void stl_start(struct tty_struct 
 
 	pr_debug("stl_start(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	stl_startrxtx(portp, -1, 1);
 }
@@ -1626,10 +1626,10 @@ static void stl_hangup(struct tty_struct
 
 	pr_debug("stl_hangup(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	portp->flags &= ~ASYNC_INITIALIZED;
@@ -1640,13 +1640,13 @@ static void stl_hangup(struct tty_struct
 	stl_flushbuffer(tty);
 	portp->istate = 0;
 	set_bit(TTY_IO_ERROR, &tty->flags);
-	if (portp->tx.buf != (char *) NULL) {
+	if (portp->tx.buf != NULL) {
 		kfree(portp->tx.buf);
-		portp->tx.buf = (char *) NULL;
-		portp->tx.head = (char *) NULL;
-		portp->tx.tail = (char *) NULL;
+		portp->tx.buf = NULL;
+		portp->tx.head = NULL;
+		portp->tx.tail = NULL;
 	}
-	portp->tty = (struct tty_struct *) NULL;
+	portp->tty = NULL;
 	portp->flags &= ~ASYNC_NORMAL_ACTIVE;
 	portp->refcount = 0;
 	wake_up_interruptible(&portp->open_wait);
@@ -1660,10 +1660,10 @@ static void stl_flushbuffer(struct tty_s
 
 	pr_debug("stl_flushbuffer(tty=%p)\n", tty);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	stl_flush(portp);
@@ -1678,10 +1678,10 @@ static void stl_breakctl(struct tty_stru
 
 	pr_debug("stl_breakctl(tty=%p,state=%d)\n", tty, state);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	stl_sendbreak(portp, ((state == -1) ? 1 : 2));
@@ -1696,10 +1696,10 @@ static void stl_waituntilsent(struct tty
 
 	pr_debug("stl_waituntilsent(tty=%p,timeout=%d)\n", tty, timeout);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	if (timeout == 0)
@@ -1723,10 +1723,10 @@ static void stl_sendxchar(struct tty_str
 
 	pr_debug("stl_sendxchar(tty=%p,ch=%x)\n", tty, ch);
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	if (ch == STOP_CHAR(tty))
@@ -1822,7 +1822,7 @@ static int stl_readproc(char *page, char
  */
 	for (brdnr = 0; (brdnr < stl_nrbrds); brdnr++) {
 		brdp = stl_brds[brdnr];
-		if (brdp == (stlbrd_t *) NULL)
+		if (brdp == NULL)
 			continue;
 		if (brdp->state == 0)
 			continue;
@@ -1836,7 +1836,7 @@ static int stl_readproc(char *page, char
 		totalport = brdnr * STL_MAXPORTS;
 		for (panelnr = 0; (panelnr < brdp->nrpanels); panelnr++) {
 			panelp = brdp->panels[panelnr];
-			if (panelp == (stlpanel_t *) NULL)
+			if (panelp == NULL)
 				continue;
 
 			maxoff = curoff + (panelp->nrports * MAXLINE);
@@ -1849,7 +1849,7 @@ static int stl_readproc(char *page, char
 			for (portnr = 0; (portnr < panelp->nrports); portnr++,
 			    totalport++) {
 				portp = panelp->ports[portnr];
-				if (portp == (stlport_t *) NULL)
+				if (portp == NULL)
 					continue;
 				if (off >= (curoff += MAXLINE))
 					continue;
@@ -1876,7 +1876,7 @@ stl_readdone:
 
 static irqreturn_t stl_intr(int irq, void *dev_id)
 {
-	stlbrd_t	*brdp = (stlbrd_t *) dev_id;
+	stlbrd_t *brdp = dev_id;
 
 	pr_debug("stl_intr(brdp=%p,irq=%d)\n", brdp, irq);
 
@@ -2036,11 +2036,11 @@ static void stl_offintr(void *private)
 
 	pr_debug("stl_offintr(portp=%p)\n", portp);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 
 	lock_kernel();
@@ -2229,10 +2229,10 @@ static inline int stl_initeio(stlbrd_t *
 	panelp->iobase = brdp->ioaddr1;
 	panelp->hwid = status;
 	if ((status & EIO_IDBITMASK) == EIO_MK3) {
-		panelp->uartp = (void *) &stl_sc26198uart;
+		panelp->uartp = &stl_sc26198uart;
 		panelp->isr = stl_sc26198intr;
 	} else {
-		panelp->uartp = (void *) &stl_cd1400uart;
+		panelp->uartp = &stl_cd1400uart;
 		panelp->isr = stl_cd1400eiointr;
 	}
 
@@ -2404,7 +2404,7 @@ static inline int stl_initech(stlbrd_t *
 		brdp->bnkstataddr[banknr++] = ioaddr + ECH_PNLSTATUS;
 
 		if (status & ECH_PNLXPID) {
-			panelp->uartp = (void *) &stl_sc26198uart;
+			panelp->uartp = &stl_sc26198uart;
 			panelp->isr = stl_sc26198intr;
 			if (status & ECH_PNL16PORT) {
 				panelp->nrports = 16;
@@ -2416,7 +2416,7 @@ static inline int stl_initech(stlbrd_t *
 				panelp->nrports = 8;
 			}
 		} else {
-			panelp->uartp = (void *) &stl_cd1400uart;
+			panelp->uartp = &stl_cd1400uart;
 			panelp->isr = stl_cd1400echintr;
 			if (status & ECH_PNL16PORT) {
 				panelp->nrports = 16;
@@ -2500,7 +2500,7 @@ static int __init stl_brdinit(stlbrd_t *
 	}
 
 	for (i = 0; (i < STL_MAXPANELS); i++)
-		if (brdp->panels[i] != (stlpanel_t *) NULL)
+		if (brdp->panels[i] != NULL)
 			stl_initports(brdp, brdp->panels[i]);
 
 	printk("STALLION: %s found, board=%d io=%x irq=%d "
@@ -2521,7 +2521,7 @@ static inline int stl_getbrdnr(void)
 	int	i;
 
 	for (i = 0; (i < STL_MAXBRDS); i++) {
-		if (stl_brds[i] == (stlbrd_t *) NULL) {
+		if (stl_brds[i] == NULL) {
 			if (i >= stl_nrbrds)
 				stl_nrbrds = i + 1;
 			return(i);
@@ -2549,7 +2549,7 @@ static inline int stl_initpcibrd(int brd
 
 	if (pci_enable_device(devp))
 		return(-EIO);
-	if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
+	if ((brdp = stl_allocbrd()) == NULL)
 		return(-ENOMEM);
 	if ((brdp->brdnr = stl_getbrdnr()) < 0) {
 		printk("STALLION: too many boards found, "
@@ -2659,7 +2659,7 @@ static inline int stl_initbrds(void)
 	for (i = 0; (i < stl_nrbrds); i++) {
 		confp = &stl_brdconf[i];
 		stl_parsebrd(confp, stl_brdsp[i]);
-		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
+		if ((brdp = stl_allocbrd()) == NULL)
 			return(-ENOMEM);
 		brdp->brdnr = i;
 		brdp->brdtype = confp->brdtype;
@@ -2699,7 +2699,7 @@ static int stl_getbrdstats(combrd_t __us
 	if (stl_brdstats.brd >= STL_MAXBRDS)
 		return(-ENODEV);
 	brdp = stl_brds[stl_brdstats.brd];
-	if (brdp == (stlbrd_t *) NULL)
+	if (brdp == NULL)
 		return(-ENODEV);
 
 	memset(&stl_brdstats, 0, sizeof(combrd_t));
@@ -2734,17 +2734,17 @@ static stlport_t *stl_getport(int brdnr,
 	stlpanel_t	*panelp;
 
 	if ((brdnr < 0) || (brdnr >= STL_MAXBRDS))
-		return((stlport_t *) NULL);
+		return(NULL);
 	brdp = stl_brds[brdnr];
-	if (brdp == (stlbrd_t *) NULL)
-		return((stlport_t *) NULL);
+	if (brdp == NULL)
+		return(NULL);
 	if ((panelnr < 0) || (panelnr >= brdp->nrpanels))
-		return((stlport_t *) NULL);
+		return(NULL);
 	panelp = brdp->panels[panelnr];
-	if (panelp == (stlpanel_t *) NULL)
-		return((stlport_t *) NULL);
+	if (panelp == NULL)
+		return(NULL);
 	if ((portnr < 0) || (portnr >= panelp->nrports))
-		return((stlport_t *) NULL);
+		return(NULL);
 	return(panelp->ports[portnr]);
 }
 
@@ -2766,7 +2766,7 @@ static int stl_getportstats(stlport_t *p
 			return -EFAULT;
 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
 			stl_comstats.port);
-		if (portp == (stlport_t *) NULL)
+		if (portp == NULL)
 			return(-ENODEV);
 	}
 
@@ -2782,12 +2782,12 @@ static int stl_getportstats(stlport_t *p
 	portp->stats.rxbuffered = 0;
 
 	spin_lock_irqsave(&stallion_lock, flags);
-	if (portp->tty != (struct tty_struct *) NULL) {
+	if (portp->tty != NULL) {
 		if (portp->tty->driver_data == portp) {
 			portp->stats.ttystate = portp->tty->flags;
 			/* No longer available as a statistic */
 			portp->stats.rxbuffered = 1; /*portp->tty->flip.count; */
-			if (portp->tty->termios != (struct termios *) NULL) {
+			if (portp->tty->termios != NULL) {
 				portp->stats.cflags = portp->tty->termios->c_cflag;
 				portp->stats.iflags = portp->tty->termios->c_iflag;
 				portp->stats.oflags = portp->tty->termios->c_oflag;
@@ -2821,7 +2821,7 @@ static int stl_clrportstats(stlport_t *p
 			return -EFAULT;
 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
 			stl_comstats.port);
-		if (portp == (stlport_t *) NULL)
+		if (portp == NULL)
 			return(-ENODEV);
 	}
 
@@ -3092,8 +3092,8 @@ static void stl_cd1400portinit(stlbrd_t 
 	pr_debug("stl_cd1400portinit(brdp=%p,panelp=%p,portp=%p)\n", brdp,
 			panelp, portp);
 
-	if ((brdp == (stlbrd_t *) NULL) || (panelp == (stlpanel_t *) NULL) ||
-	    (portp == (stlport_t *) NULL))
+	if ((brdp == NULL) || (panelp == NULL) ||
+	    (portp == NULL))
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -3164,7 +3164,7 @@ static void stl_cd1400setport(stlport_t 
 	sreroff = 0;
 
 	brdp = stl_brds[portp->brdnr];
-	if (brdp == (stlbrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
 /*
@@ -3548,10 +3548,10 @@ static void stl_cd1400flowctrl(stlport_t
 
 	pr_debug("stl_cd1400flowctrl(portp=%p,state=%x)\n", portp, state);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -3610,10 +3610,10 @@ static void stl_cd1400sendflow(stlport_t
 
 	pr_debug("stl_cd1400sendflow(portp=%p,state=%x)\n", portp, state);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -3642,7 +3642,7 @@ static void stl_cd1400flush(stlport_t *p
 
 	pr_debug("stl_cd1400flush(portp=%p)\n", portp);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -3669,7 +3669,7 @@ static int stl_cd1400datastate(stlport_t
 {
 	pr_debug("stl_cd1400datastate(portp=%p)\n", portp);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return 0;
 
 	return test_bit(ASYI_TXBUSY, &portp->istate) ? 1 : 0;
@@ -4094,8 +4094,8 @@ static void stl_sc26198portinit(stlbrd_t
 	pr_debug("stl_sc26198portinit(brdp=%p,panelp=%p,portp=%p)\n", brdp,
 			panelp, portp);
 
-	if ((brdp == (stlbrd_t *) NULL) || (panelp == (stlpanel_t *) NULL) ||
-	    (portp == (stlport_t *) NULL))
+	if ((brdp == NULL) || (panelp == NULL) ||
+	    (portp == NULL))
 		return;
 
 	portp->ioaddr = panelp->iobase + ((portp->portnr < 8) ? 0 : 4);
@@ -4132,7 +4132,7 @@ static void stl_sc26198setport(stlport_t
 	imroff = 0;
 
 	brdp = stl_brds[portp->brdnr];
-	if (brdp == (stlbrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
 /*
@@ -4484,10 +4484,10 @@ static void stl_sc26198flowctrl(stlport_
 
 	pr_debug("stl_sc26198flowctrl(portp=%p,state=%x)\n", portp, state);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -4553,10 +4553,10 @@ static void stl_sc26198sendflow(stlport_
 
 	pr_debug("stl_sc26198sendflow(portp=%p,state=%x)\n", portp, state);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -4590,7 +4590,7 @@ static void stl_sc26198flush(stlport_t *
 
 	pr_debug("stl_sc26198flush(portp=%p)\n", portp);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -4619,7 +4619,7 @@ static int stl_sc26198datastate(stlport_
 
 	pr_debug("stl_sc26198datastate(portp=%p)\n", portp);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return 0;
 	if (test_bit(ASYI_TXBUSY, &portp->istate))
 		return 1;
@@ -4646,7 +4646,7 @@ static void stl_sc26198wait(stlport_t *p
 
 	pr_debug("stl_sc26198wait(portp=%p)\n", portp);
 
-	if (portp == (stlport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	for (i = 0; (i < 20); i++)
@@ -4818,8 +4818,8 @@ static void stl_sc26198rxisr(stlport_t *
  *	flow control modes of the sc26198.
  */
 	if (test_bit(ASYI_TXFLOWED, &portp->istate)) {
-		if ((tty != (struct tty_struct *) NULL) &&
-		    (tty->termios != (struct termios *) NULL) &&
+		if ((tty != NULL) &&
+		    (tty->termios != NULL) &&
 		    (tty->termios->c_iflag & IXANY)) {
 			stl_sc26198txunflow(portp, tty);
 		}
@@ -4849,7 +4849,7 @@ static inline void stl_sc26198rxbadch(st
 	if (status & SR_RXBREAK)
 		portp->stats.rxbreaks++;
 
-	if ((tty != (struct tty_struct *) NULL) &&
+	if ((tty != NULL) &&
 	    ((portp->rxignoremsk & status) == 0)) {
 		if (portp->rxmarkmsk & status) {
 			if (status & SR_RXBREAK) {
