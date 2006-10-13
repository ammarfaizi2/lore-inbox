Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWJMVHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWJMVHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWJMVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:07:20 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:59885 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751910AbWJMVHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:07:17 -0400
Message-id: <347066701121713986@wsc.cz>
Subject: [PATCH 1/7] Char: stallion, use pr_debug macro
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 13 Oct 2006 23:07:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, use pr_debug macro

Use pr_debug kernel macro instead of #ifdef DEBUG | printk() | #endif

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit bcedfb013b6cf4869f506acf66d31e73e8d04c10
tree 328e7d04ca9712869050d0ad1cbaee1755ea766f
parent a17f8130e4af536608ed6f93341003dd5f0af825
author Jiri Slaby <jirislaby@gmail.com> Thu, 12 Oct 2006 23:05:59 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 12 Oct 2006 23:05:59 +0200

 drivers/char/stallion.c |  323 +++++++++++++----------------------------------
 1 files changed, 86 insertions(+), 237 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 522e88e..050a4ee 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -735,9 +735,7 @@ static void __exit stallion_module_exit(
 	stlport_t	*portp;
 	int		i, j, k;
 
-#ifdef DEBUG
-	printk("cleanup_module()\n");
-#endif
+	pr_debug("cleanup_module()\n");
 
 	printk(KERN_INFO "Unloading %s: version %s\n", stl_drvtitle,
 		stl_drvversion);
@@ -808,9 +806,7 @@ static void stl_argbrds(void)
 	stlbrd_t	*brdp;
 	int		i;
 
-#ifdef DEBUG
-	printk("stl_argbrds()\n");
-#endif
+	pr_debug("stl_argbrds()\n");
 
 	for (i = stl_nrbrds; (i < stl_nargs); i++) {
 		memset(&conf, 0, sizeof(conf));
@@ -876,9 +872,7 @@ static int stl_parsebrd(stlconf_t *confp
 	char	*sp;
 	int	i;
 
-#ifdef DEBUG
-	printk("stl_parsebrd(confp=%x,argp=%x)\n", (int) confp, (int) argp);
-#endif
+	pr_debug("stl_parsebrd(confp=%p,argp=%p)\n", confp, argp);
 
 	if ((argp[0] == (char *) NULL) || (*argp[0] == 0))
 		return 0;
@@ -941,10 +935,7 @@ static int stl_open(struct tty_struct *t
 	unsigned int	minordev;
 	int		brdnr, panelnr, portnr, rc;
 
-#ifdef DEBUG
-	printk("stl_open(tty=%x,filp=%x): device=%s\n", (int) tty,
-		(int) filp, tty->name);
-#endif
+	pr_debug("stl_open(tty=%p,filp=%p): device=%s\n", tty, filp, tty->name);
 
 	minordev = tty->index;
 	brdnr = MINOR2BRD(minordev);
@@ -1034,9 +1025,7 @@ static int stl_waitcarrier(stlport_t *po
 	unsigned long	flags;
 	int		rc, doclocal;
 
-#ifdef DEBUG
-	printk("stl_waitcarrier(portp=%x,filp=%x)\n", (int) portp, (int) filp);
-#endif
+	pr_debug("stl_waitcarrier(portp=%p,filp=%p)\n", portp, filp);
 
 	rc = 0;
 	doclocal = 0;
@@ -1088,9 +1077,7 @@ static void stl_close(struct tty_struct 
 	stlport_t	*portp;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_close(tty=%x,filp=%x)\n", (int) tty, (int) filp);
-#endif
+	pr_debug("stl_close(tty=%p,filp=%p)\n", tty, filp);
 
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
@@ -1172,10 +1159,7 @@ static int stl_write(struct tty_struct *
 	unsigned char	*chbuf;
 	char		*head, *tail;
 
-#ifdef DEBUG
-	printk("stl_write(tty=%x,buf=%x,count=%d)\n",
-		(int) tty, (int) buf, count);
-#endif
+	pr_debug("stl_write(tty=%p,buf=%p,count=%d)\n", tty, buf, count);
 
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
@@ -1231,9 +1215,7 @@ static void stl_putchar(struct tty_struc
 	unsigned int	len;
 	char		*head, *tail;
 
-#ifdef DEBUG
-	printk("stl_putchar(tty=%x,ch=%x)\n", (int) tty, (int) ch);
-#endif
+	pr_debug("stl_putchar(tty=%p,ch=%x)\n", tty, ch);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1269,9 +1251,7 @@ static void stl_flushchars(struct tty_st
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_flushchars(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_flushchars(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1291,9 +1271,7 @@ static int stl_writeroom(struct tty_stru
 	stlport_t	*portp;
 	char		*head, *tail;
 
-#ifdef DEBUG
-	printk("stl_writeroom(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_writeroom(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return 0;
@@ -1325,9 +1303,7 @@ static int stl_charsinbuffer(struct tty_
 	unsigned int	size;
 	char		*head, *tail;
 
-#ifdef DEBUG
-	printk("stl_charsinbuffer(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_charsinbuffer(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return 0;
@@ -1356,9 +1332,7 @@ static int stl_getserial(stlport_t *port
 	struct serial_struct	sio;
 	stlbrd_t		*brdp;
 
-#ifdef DEBUG
-	printk("stl_getserial(portp=%x,sp=%x)\n", (int) portp, (int) sp);
-#endif
+	pr_debug("stl_getserial(portp=%p,sp=%p)\n", portp, sp);
 
 	memset(&sio, 0, sizeof(struct serial_struct));
 	sio.line = portp->portnr;
@@ -1396,9 +1370,7 @@ static int stl_setserial(stlport_t *port
 {
 	struct serial_struct	sio;
 
-#ifdef DEBUG
-	printk("stl_setserial(portp=%x,sp=%x)\n", (int) portp, (int) sp);
-#endif
+	pr_debug("stl_setserial(portp=%p,sp=%p)\n", portp, sp);
 
 	if (copy_from_user(&sio, sp, sizeof(struct serial_struct)))
 		return -EFAULT;
@@ -1471,10 +1443,8 @@ static int stl_ioctl(struct tty_struct *
 	int		rc;
 	void __user *argp = (void __user *)arg;
 
-#ifdef DEBUG
-	printk("stl_ioctl(tty=%x,file=%x,cmd=%x,arg=%x)\n",
-		(int) tty, (int) file, cmd, (int) arg);
-#endif
+	pr_debug("stl_ioctl(tty=%p,file=%p,cmd=%x,arg=%lx)\n", tty, file, cmd,
+			arg);
 
 	if (tty == (struct tty_struct *) NULL)
 		return -ENODEV;
@@ -1536,9 +1506,7 @@ static void stl_settermios(struct tty_st
 	stlport_t	*portp;
 	struct termios	*tiosp;
 
-#ifdef DEBUG
-	printk("stl_settermios(tty=%x,old=%x)\n", (int) tty, (int) old);
-#endif
+	pr_debug("stl_settermios(tty=%p,old=%p)\n", tty, old);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1573,9 +1541,7 @@ static void stl_throttle(struct tty_stru
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_throttle(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_throttle(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1595,9 +1561,7 @@ static void stl_unthrottle(struct tty_st
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_unthrottle(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_unthrottle(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1618,9 +1582,7 @@ static void stl_stop(struct tty_struct *
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_stop(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_stop(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1640,9 +1602,7 @@ static void stl_start(struct tty_struct 
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_start(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_start(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1664,9 +1624,7 @@ static void stl_hangup(struct tty_struct
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_hangup(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_hangup(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1700,9 +1658,7 @@ static void stl_flushbuffer(struct tty_s
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_flushbuffer(tty=%x)\n", (int) tty);
-#endif
+	pr_debug("stl_flushbuffer(tty=%p)\n", tty);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1720,9 +1676,7 @@ static void stl_breakctl(struct tty_stru
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_breakctl(tty=%x,state=%d)\n", (int) tty, state);
-#endif
+	pr_debug("stl_breakctl(tty=%p,state=%d)\n", tty, state);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1740,9 +1694,7 @@ static void stl_waituntilsent(struct tty
 	stlport_t	*portp;
 	unsigned long	tend;
 
-#ifdef DEBUG
-	printk("stl_waituntilsent(tty=%x,timeout=%d)\n", (int) tty, timeout);
-#endif
+	pr_debug("stl_waituntilsent(tty=%p,timeout=%d)\n", tty, timeout);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1769,9 +1721,7 @@ static void stl_sendxchar(struct tty_str
 {
 	stlport_t	*portp;
 
-#ifdef DEBUG
-	printk("stl_sendxchar(tty=%x,ch=%x)\n", (int) tty, ch);
-#endif
+	pr_debug("stl_sendxchar(tty=%p,ch=%x)\n", tty, ch);
 
 	if (tty == (struct tty_struct *) NULL)
 		return;
@@ -1850,11 +1800,8 @@ static int stl_readproc(char *page, char
 	int		curoff, maxoff;
 	char		*pos;
 
-#ifdef DEBUG
-	printk("stl_readproc(page=%x,start=%x,off=%x,count=%d,eof=%x,"
-		"data=%x\n", (int) page, (int) start, (int) off, count,
-		(int) eof, (int) data);
-#endif
+	pr_debug("stl_readproc(page=%p,start=%p,off=%lx,count=%d,eof=%p,"
+		"data=%p\n", page, start, off, count, eof, data);
 
 	pos = page;
 	totalport = 0;
@@ -1931,9 +1878,7 @@ static irqreturn_t stl_intr(int irq, voi
 {
 	stlbrd_t	*brdp = (stlbrd_t *) dev_id;
 
-#ifdef DEBUG
-	printk("stl_intr(brdp=%x,irq=%d)\n", (int) brdp, irq);
-#endif
+	pr_debug("stl_intr(brdp=%p,irq=%d)\n", brdp, irq);
 
 	return IRQ_RETVAL((* brdp->isr)(brdp));
 }
@@ -2089,9 +2034,7 @@ static void stl_offintr(void *private)
 
 	portp = private;
 
-#ifdef DEBUG
-	printk("stl_offintr(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_offintr(portp=%p)\n", portp);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -2129,9 +2072,7 @@ static int __init stl_initports(stlbrd_t
 	stlport_t	*portp;
 	int		chipmask, i;
 
-#ifdef DEBUG
-	printk("stl_initports(brdp=%x,panelp=%x)\n", (int) brdp, (int) panelp);
-#endif
+	pr_debug("stl_initports(brdp=%p,panelp=%p)\n", brdp, panelp);
 
 	chipmask = stl_panelinit(brdp, panelp);
 
@@ -2182,9 +2123,7 @@ static inline int stl_initeio(stlbrd_t *
 	char		*name;
 	int		rc;
 
-#ifdef DEBUG
-	printk("stl_initeio(brdp=%x)\n", (int) brdp);
-#endif
+	pr_debug("stl_initeio(brdp=%p)\n", brdp);
 
 	brdp->ioctrl = brdp->ioaddr1 + 1;
 	brdp->iostatus = brdp->ioaddr1 + 2;
@@ -2325,9 +2264,7 @@ static inline int stl_initech(stlbrd_t *
 	int		panelnr, banknr, i;
 	char		*name;
 
-#ifdef DEBUG
-	printk("stl_initech(brdp=%x)\n", (int) brdp);
-#endif
+	pr_debug("stl_initech(brdp=%p)\n", brdp);
 
 	status = 0;
 	conflict = 0;
@@ -2535,9 +2472,7 @@ static int __init stl_brdinit(stlbrd_t *
 {
 	int	i;
 
-#ifdef DEBUG
-	printk("stl_brdinit(brdp=%x)\n", (int) brdp);
-#endif
+	pr_debug("stl_brdinit(brdp=%p)\n", brdp);
 
 	switch (brdp->brdtype) {
 	case BRD_EASYIO:
@@ -2609,10 +2544,8 @@ static inline int stl_initpcibrd(int brd
 {
 	stlbrd_t	*brdp;
 
-#ifdef DEBUG
-	printk("stl_initpcibrd(brdtype=%d,busnr=%x,devnr=%x)\n", brdtype,
+	pr_debug("stl_initpcibrd(brdtype=%d,busnr=%x,devnr=%x)\n", brdtype,
 		devp->bus->number, devp->devfn);
-#endif
 
 	if (pci_enable_device(devp))
 		return(-EIO);
@@ -2629,11 +2562,9 @@ #endif
  *	Different Stallion boards use the BAR registers in different ways,
  *	so set up io addresses based on board type.
  */
-#ifdef DEBUG
-	printk("%s(%d): BAR[]=%x,%x,%x,%x IRQ=%x\n", __FILE__, __LINE__,
+	pr_debug("%s(%d): BAR[]=%Lx,%Lx,%Lx,%Lx IRQ=%x\n", __FILE__, __LINE__,
 		pci_resource_start(devp, 0), pci_resource_start(devp, 1),
 		pci_resource_start(devp, 2), pci_resource_start(devp, 3), devp->irq);
-#endif
 
 /*
  *	We have all resources from the board, so let's setup the actual
@@ -2676,9 +2607,7 @@ static inline int stl_findpcibrds(void)
 	struct pci_dev	*dev = NULL;
 	int		i, rc;
 
-#ifdef DEBUG
-	printk("stl_findpcibrds()\n");
-#endif
+	pr_debug("stl_findpcibrds()\n");
 
 	for (i = 0; (i < stl_nrpcibrds); i++)
 		while ((dev = pci_find_device(stl_pcibrds[i].vendid,
@@ -2715,9 +2644,7 @@ static inline int stl_initbrds(void)
 	stlconf_t	*confp;
 	int		i;
 
-#ifdef DEBUG
-	printk("stl_initbrds()\n");
-#endif
+	pr_debug("stl_initbrds()\n");
 
 	if (stl_nrbrds > STL_MAXBRDS) {
 		printk("STALLION: too many boards in configuration table, "
@@ -2958,10 +2885,7 @@ static int stl_memioctl(struct inode *ip
 	int	brdnr, rc;
 	void __user *argp = (void __user *)arg;
 
-#ifdef DEBUG
-	printk("stl_memioctl(ip=%x,fp=%x,cmd=%x,arg=%x)\n", (int) ip,
-		(int) fp, cmd, (int) arg);
-#endif
+	pr_debug("stl_memioctl(ip=%p,fp=%p,cmd=%x,arg=%lx)\n", ip, fp, cmd,arg);
 
 	brdnr = iminor(ip);
 	if (brdnr >= STL_MAXBRDS)
@@ -3112,9 +3036,7 @@ static int stl_cd1400panelinit(stlbrd_t 
 	int		nrchips, uartaddr, ioaddr;
 	unsigned long   flags;
 
-#ifdef DEBUG
-	printk("stl_panelinit(brdp=%x,panelp=%x)\n", (int) brdp, (int) panelp);
-#endif
+	pr_debug("stl_panelinit(brdp=%p,panelp=%p)\n", brdp, panelp);
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(panelp->brdnr, panelp->pagenr);
@@ -3167,10 +3089,8 @@ #endif
 static void stl_cd1400portinit(stlbrd_t *brdp, stlpanel_t *panelp, stlport_t *portp)
 {
 	unsigned long flags;
-#ifdef DEBUG
-	printk("stl_cd1400portinit(brdp=%x,panelp=%x,portp=%x)\n",
-		(int) brdp, (int) panelp, (int) portp);
-#endif
+	pr_debug("stl_cd1400portinit(brdp=%p,panelp=%p,portp=%p)\n", brdp,
+			panelp, portp);
 
 	if ((brdp == (stlbrd_t *) NULL) || (panelp == (stlpanel_t *) NULL) ||
 	    (portp == (stlport_t *) NULL))
@@ -3384,18 +3304,16 @@ static void stl_cd1400setport(stlport_t 
  *	them all up.
  */
 
-#ifdef DEBUG
-	printk("SETPORT: portnr=%d panelnr=%d brdnr=%d\n",
+	pr_debug("SETPORT: portnr=%d panelnr=%d brdnr=%d\n",
 		portp->portnr, portp->panelnr, portp->brdnr);
-	printk("    cor1=%x cor2=%x cor3=%x cor4=%x cor5=%x\n",
+	pr_debug("    cor1=%x cor2=%x cor3=%x cor4=%x cor5=%x\n",
 		cor1, cor2, cor3, cor4, cor5);
-	printk("    mcor1=%x mcor2=%x rtpr=%x sreron=%x sreroff=%x\n",
+	pr_debug("    mcor1=%x mcor2=%x rtpr=%x sreron=%x sreroff=%x\n",
 		mcor1, mcor2, rtpr, sreron, sreroff);
-	printk("    tcor=%x tbpr=%x rcor=%x rbpr=%x\n", clk, div, clk, div);
-	printk("    schr1=%x schr2=%x schr3=%x schr4=%x\n",
+	pr_debug("    tcor=%x tbpr=%x rcor=%x rbpr=%x\n", clk, div, clk, div);
+	pr_debug("    schr1=%x schr2=%x schr3=%x schr4=%x\n",
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP],
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP]);
-#endif
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -3448,10 +3366,8 @@ static void stl_cd1400setsignals(stlport
 	unsigned char	msvr1, msvr2;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400setsignals(portp=%x,dtr=%d,rts=%d)\n",
-		(int) portp, dtr, rts);
-#endif
+	pr_debug("stl_cd1400setsignals(portp=%p,dtr=%d,rts=%d)\n",
+			portp, dtr, rts);
 
 	msvr1 = 0;
 	msvr2 = 0;
@@ -3483,9 +3399,7 @@ static int stl_cd1400getsignals(stlport_
 	unsigned long	flags;
 	int		sigs;
 
-#ifdef DEBUG
-	printk("stl_cd1400getsignals(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_cd1400getsignals(portp=%p)\n", portp);
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -3520,10 +3434,8 @@ static void stl_cd1400enablerxtx(stlport
 	unsigned char	ccr;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400enablerxtx(portp=%x,rx=%d,tx=%d)\n",
-		(int) portp, rx, tx);
-#endif
+	pr_debug("stl_cd1400enablerxtx(portp=%p,rx=%d,tx=%d)\n", portp, rx, tx);
+
 	ccr = 0;
 
 	if (tx == 0)
@@ -3556,10 +3468,7 @@ static void stl_cd1400startrxtx(stlport_
 	unsigned char	sreron, sreroff;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400startrxtx(portp=%x,rx=%d,tx=%d)\n",
-		(int) portp, rx, tx);
-#endif
+	pr_debug("stl_cd1400startrxtx(portp=%p,rx=%d,tx=%d)\n", portp, rx, tx);
 
 	sreron = 0;
 	sreroff = 0;
@@ -3595,9 +3504,8 @@ static void stl_cd1400disableintrs(stlpo
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400disableintrs(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_cd1400disableintrs(portp=%p)\n", portp);
+
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
@@ -3612,9 +3520,7 @@ static void stl_cd1400sendbreak(stlport_
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400sendbreak(portp=%x,len=%d)\n", (int) portp, len);
-#endif
+	pr_debug("stl_cd1400sendbreak(portp=%p,len=%d)\n", portp, len);
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -3640,9 +3546,7 @@ static void stl_cd1400flowctrl(stlport_t
 	struct tty_struct	*tty;
 	unsigned long		flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400flowctrl(portp=%x,state=%x)\n", (int) portp, state);
-#endif
+	pr_debug("stl_cd1400flowctrl(portp=%p,state=%x)\n", portp, state);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -3704,9 +3608,7 @@ static void stl_cd1400sendflow(stlport_t
 	struct tty_struct	*tty;
 	unsigned long		flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400sendflow(portp=%x,state=%x)\n", (int) portp, state);
-#endif
+	pr_debug("stl_cd1400sendflow(portp=%p,state=%x)\n", portp, state);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -3738,9 +3640,7 @@ static void stl_cd1400flush(stlport_t *p
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_cd1400flush(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_cd1400flush(portp=%p)\n", portp);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -3767,9 +3667,7 @@ #endif
 
 static int stl_cd1400datastate(stlport_t *portp)
 {
-#ifdef DEBUG
-	printk("stl_cd1400datastate(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_cd1400datastate(portp=%p)\n", portp);
 
 	if (portp == (stlport_t *) NULL)
 		return 0;
@@ -3787,10 +3685,7 @@ static void stl_cd1400eiointr(stlpanel_t
 {
 	unsigned char	svrtype;
 
-#ifdef DEBUG
-	printk("stl_cd1400eiointr(panelp=%x,iobase=%x)\n",
-		(int) panelp, iobase);
-#endif
+	pr_debug("stl_cd1400eiointr(panelp=%p,iobase=%x)\n", panelp, iobase);
 
 	spin_lock(&brd_lock);
 	outb(SVRR, iobase);
@@ -3820,10 +3715,7 @@ static void stl_cd1400echintr(stlpanel_t
 {
 	unsigned char	svrtype;
 
-#ifdef DEBUG
-	printk("stl_cd1400echintr(panelp=%x,iobase=%x)\n", (int) panelp,
-		iobase);
-#endif
+	pr_debug("stl_cd1400echintr(panelp=%p,iobase=%x)\n", panelp, iobase);
 
 	outb(SVRR, iobase);
 	svrtype = inb(iobase + EREG_DATA);
@@ -3894,9 +3786,7 @@ static void stl_cd1400txisr(stlpanel_t *
 	char		*head, *tail;
 	unsigned char	ioack, srer;
 
-#ifdef DEBUG
-	printk("stl_cd1400txisr(panelp=%x,ioaddr=%x)\n", (int) panelp, ioaddr);
-#endif
+	pr_debug("stl_cd1400txisr(panelp=%p,ioaddr=%x)\n", panelp, ioaddr);
 
 	ioack = inb(ioaddr + EREG_TXACK);
 	if (((ioack & panelp->ackmask) != 0) ||
@@ -3976,9 +3866,7 @@ static void stl_cd1400rxisr(stlpanel_t *
 	unsigned char		status;
 	char			ch;
 
-#ifdef DEBUG
-	printk("stl_cd1400rxisr(panelp=%x,ioaddr=%x)\n", (int) panelp, ioaddr);
-#endif
+	pr_debug("stl_cd1400rxisr(panelp=%p,ioaddr=%x)\n", panelp, ioaddr);
 
 	ioack = inb(ioaddr + EREG_RXACK);
 	if ((ioack & panelp->ackmask) != 0) {
@@ -4074,9 +3962,7 @@ static void stl_cd1400mdmisr(stlpanel_t 
 	unsigned int	ioack;
 	unsigned char	misr;
 
-#ifdef DEBUG
-	printk("stl_cd1400mdmisr(panelp=%x)\n", (int) panelp);
-#endif
+	pr_debug("stl_cd1400mdmisr(panelp=%p)\n", panelp);
 
 	ioack = inb(ioaddr + EREG_MDACK);
 	if (((ioack & panelp->ackmask) != 0) ||
@@ -4163,10 +4049,7 @@ static int stl_sc26198panelinit(stlbrd_t
 	int	chipmask, i;
 	int	nrchips, ioaddr;
 
-#ifdef DEBUG
-	printk("stl_sc26198panelinit(brdp=%x,panelp=%x)\n",
-		(int) brdp, (int) panelp);
-#endif
+	pr_debug("stl_sc26198panelinit(brdp=%p,panelp=%p)\n", brdp, panelp);
 
 	BRDENABLE(panelp->brdnr, panelp->pagenr);
 
@@ -4208,10 +4091,8 @@ #endif
 
 static void stl_sc26198portinit(stlbrd_t *brdp, stlpanel_t *panelp, stlport_t *portp)
 {
-#ifdef DEBUG
-	printk("stl_sc26198portinit(brdp=%x,panelp=%x,portp=%x)\n",
-		(int) brdp, (int) panelp, (int) portp);
-#endif
+	pr_debug("stl_sc26198portinit(brdp=%p,panelp=%p,portp=%p)\n", brdp,
+			panelp, portp);
 
 	if ((brdp == (stlbrd_t *) NULL) || (panelp == (stlpanel_t *) NULL) ||
 	    (portp == (stlport_t *) NULL))
@@ -4385,15 +4266,13 @@ static void stl_sc26198setport(stlport_t
  *	them all up.
  */
 
-#ifdef DEBUG
-	printk("SETPORT: portnr=%d panelnr=%d brdnr=%d\n",
+	pr_debug("SETPORT: portnr=%d panelnr=%d brdnr=%d\n",
 		portp->portnr, portp->panelnr, portp->brdnr);
-	printk("    mr0=%x mr1=%x mr2=%x clk=%x\n", mr0, mr1, mr2, clk);
-	printk("    iopr=%x imron=%x imroff=%x\n", iopr, imron, imroff);
-	printk("    schr1=%x schr2=%x schr3=%x schr4=%x\n",
+	pr_debug("    mr0=%x mr1=%x mr2=%x clk=%x\n", mr0, mr1, mr2, clk);
+	pr_debug("    iopr=%x imron=%x imroff=%x\n", iopr, imron, imroff);
+	pr_debug("    schr1=%x schr2=%x schr3=%x schr4=%x\n",
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP],
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP]);
-#endif
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -4436,10 +4315,8 @@ static void stl_sc26198setsignals(stlpor
 	unsigned char	iopioron, iopioroff;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_sc26198setsignals(portp=%x,dtr=%d,rts=%d)\n",
-		(int) portp, dtr, rts);
-#endif
+	pr_debug("stl_sc26198setsignals(portp=%p,dtr=%d,rts=%d)\n", portp,
+			dtr, rts);
 
 	iopioron = 0;
 	iopioroff = 0;
@@ -4472,9 +4349,7 @@ static int stl_sc26198getsignals(stlport
 	unsigned long	flags;
 	int		sigs;
 
-#ifdef DEBUG
-	printk("stl_sc26198getsignals(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_sc26198getsignals(portp=%p)\n", portp);
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -4502,10 +4377,7 @@ static void stl_sc26198enablerxtx(stlpor
 	unsigned char	ccr;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_sc26198enablerxtx(portp=%x,rx=%d,tx=%d)\n",
-		(int) portp, rx, tx);
-#endif
+	pr_debug("stl_sc26198enablerxtx(portp=%p,rx=%d,tx=%d)\n", portp, rx,tx);
 
 	ccr = portp->crenable;
 	if (tx == 0)
@@ -4536,10 +4408,7 @@ static void stl_sc26198startrxtx(stlport
 	unsigned char	imr;
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_sc26198startrxtx(portp=%x,rx=%d,tx=%d)\n",
-		(int) portp, rx, tx);
-#endif
+	pr_debug("stl_sc26198startrxtx(portp=%p,rx=%d,tx=%d)\n", portp, rx, tx);
 
 	imr = portp->imr;
 	if (tx == 0)
@@ -4571,9 +4440,7 @@ static void stl_sc26198disableintrs(stlp
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_sc26198disableintrs(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_sc26198disableintrs(portp=%p)\n", portp);
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -4589,9 +4456,7 @@ static void stl_sc26198sendbreak(stlport
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_sc26198sendbreak(portp=%x,len=%d)\n", (int) portp, len);
-#endif
+	pr_debug("stl_sc26198sendbreak(portp=%p,len=%d)\n", portp, len);
 
 	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
@@ -4617,9 +4482,7 @@ static void stl_sc26198flowctrl(stlport_
 	unsigned long		flags;
 	unsigned char		mr0;
 
-#ifdef DEBUG
-	printk("stl_sc26198flowctrl(portp=%x,state=%x)\n", (int) portp, state);
-#endif
+	pr_debug("stl_sc26198flowctrl(portp=%p,state=%x)\n", portp, state);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -4688,9 +4551,7 @@ static void stl_sc26198sendflow(stlport_
 	unsigned long		flags;
 	unsigned char		mr0;
 
-#ifdef DEBUG
-	printk("stl_sc26198sendflow(portp=%x,state=%x)\n", (int) portp, state);
-#endif
+	pr_debug("stl_sc26198sendflow(portp=%p,state=%x)\n", portp, state);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -4727,9 +4588,7 @@ static void stl_sc26198flush(stlport_t *
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("stl_sc26198flush(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_sc26198flush(portp=%p)\n", portp);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -4758,9 +4617,7 @@ static int stl_sc26198datastate(stlport_
 	unsigned long	flags;
 	unsigned char	sr;
 
-#ifdef DEBUG
-	printk("stl_sc26198datastate(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_sc26198datastate(portp=%p)\n", portp);
 
 	if (portp == (stlport_t *) NULL)
 		return 0;
@@ -4787,9 +4644,7 @@ static void stl_sc26198wait(stlport_t *p
 {
 	int	i;
 
-#ifdef DEBUG
-	printk("stl_sc26198wait(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_sc26198wait(portp=%p)\n", portp);
 
 	if (portp == (stlport_t *) NULL)
 		return;
@@ -4869,9 +4724,7 @@ static void stl_sc26198txisr(stlport_t *
 	int		len, stlen;
 	char		*head, *tail;
 
-#ifdef DEBUG
-	printk("stl_sc26198txisr(portp=%x)\n", (int) portp);
-#endif
+	pr_debug("stl_sc26198txisr(portp=%p)\n", portp);
 
 	ioaddr = portp->ioaddr;
 	head = portp->tx.head;
@@ -4930,9 +4783,7 @@ static void stl_sc26198rxisr(stlport_t *
 	struct tty_struct	*tty;
 	unsigned int		len, buflen, ioaddr;
 
-#ifdef DEBUG
-	printk("stl_sc26198rxisr(portp=%x,iack=%x)\n", (int) portp, iack);
-#endif
+	pr_debug("stl_sc26198rxisr(portp=%p,iack=%x)\n", portp, iack);
 
 	tty = portp->tty;
 	ioaddr = portp->ioaddr;
@@ -5076,9 +4927,7 @@ static void stl_sc26198otherisr(stlport_
 {
 	unsigned char	cir, ipr, xisr;
 
-#ifdef DEBUG
-	printk("stl_sc26198otherisr(portp=%x,iack=%x)\n", (int) portp, iack);
-#endif
+	pr_debug("stl_sc26198otherisr(portp=%p,iack=%x)\n", portp, iack);
 
 	cir = stl_sc26198getglobreg(portp, CIR);
 
