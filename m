Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287484AbSAEDH4>; Fri, 4 Jan 2002 22:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287478AbSAEDHv>; Fri, 4 Jan 2002 22:07:51 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:12675 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287475AbSAEDHh>; Fri, 4 Jan 2002 22:07:37 -0500
Date: Fri, 4 Jan 2002 19:07:35 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre7/drivers/char kdev_t compilation fixes
Message-ID: <20020104190735.A25710@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is a pile of kdev_t compilation fixes for
linux-2.5.2-pre7/drivers/char/ (including subdirectories).  With
these changes, I believe that everying in the "char" directory tree
compiles, at least on the x86 architecture.  I do not know if the
code actually works, but the changes are pretty mechanical, so that
is reason for a little confidence.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="char.diffs"

Index: linux/drivers/char/amiserial.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/amiserial.c,v
retrieving revision 1.1.1.14
diff -u -r1.1.1.14 amiserial.c
--- linux/drivers/char/amiserial.c	2001/09/20 08:56:29	1.1.1.14
+++ linux/drivers/char/amiserial.c	2002/01/05 02:54:36
@@ -1904,7 +1904,7 @@
 	unsigned long		page;
 
 	MOD_INC_USE_COUNT;
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= NR_PORTS)) {
 		MOD_DEC_USE_COUNT;
 		return -ENODEV;
@@ -2328,7 +2328,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64);
+	return mk_kdev(TTY_MAJOR, 64);
 }
 
 static struct console sercons = {
Index: linux/drivers/char/cyclades.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/cyclades.c,v
retrieving revision 1.21
diff -u -r1.21 cyclades.c
--- linux/drivers/char/cyclades.c	2001/09/20 09:10:18	1.21
+++ linux/drivers/char/cyclades.c	2002/01/05 02:54:36
@@ -2607,7 +2607,7 @@
   unsigned long page;
 
     MOD_INC_USE_COUNT;
-    line = MINOR(tty->device) - tty->driver.minor_start;
+    line = minor(tty->device) - tty->driver.minor_start;
     if ((line < 0) || (NR_PORTS <= line)){
 	MOD_DEC_USE_COUNT;
         return -ENODEV;
Index: linux/drivers/char/dsp56k.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/dsp56k.c,v
retrieving revision 1.1.1.19
diff -u -r1.1.1.19 dsp56k.c
--- linux/drivers/char/dsp56k.c	2001/12/31 23:52:16	1.1.1.19
+++ linux/drivers/char/dsp56k.c	2002/01/05 02:54:36
@@ -207,7 +207,7 @@
 			   loff_t *ppos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	int dev = MINOR(inode->i_rdev) & 0x0f;
+	int dev = minor(inode->i_rdev) & 0x0f;
 
 	switch(dev)
 	{
@@ -270,7 +270,7 @@
 			    loff_t *ppos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	int dev = MINOR(inode->i_rdev) & 0x0f;
+	int dev = minor(inode->i_rdev) & 0x0f;
 
 	switch(dev)
 	{
@@ -331,7 +331,7 @@
 static int dsp56k_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	int dev = MINOR(inode->i_rdev) & 0x0f;
+	int dev = minor(inode->i_rdev) & 0x0f;
 
 	switch(dev)
 	{
@@ -424,7 +424,7 @@
 #if 0
 static unsigned int dsp56k_poll(struct file *file, poll_table *wait)
 {
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev) & 0x0f;
+	int dev = minor(file->f_dentry->d_inode->i_rdev) & 0x0f;
 
 	switch(dev)
 	{
@@ -441,7 +441,7 @@
 
 static int dsp56k_open(struct inode *inode, struct file *file)
 {
-	int dev = MINOR(inode->i_rdev) & 0x0f;
+	int dev = minor(inode->i_rdev) & 0x0f;
 
 	switch(dev)
 	{
@@ -472,7 +472,7 @@
 
 static int dsp56k_release(struct inode *inode, struct file *file)
 {
-	int dev = MINOR(inode->i_rdev) & 0x0f;
+	int dev = minor(inode->i_rdev) & 0x0f;
 
 	switch(dev)
 	{
Index: linux/drivers/char/dtlk.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/dtlk.c,v
retrieving revision 1.1.1.21
diff -u -r1.1.1.21 dtlk.c
--- linux/drivers/char/dtlk.c	2001/12/31 23:52:20	1.1.1.21
+++ linux/drivers/char/dtlk.c	2002/01/05 02:54:36
@@ -125,7 +125,7 @@
 static ssize_t dtlk_read(struct file *file, char *buf,
 			 size_t count, loff_t * ppos)
 {
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	unsigned int minor = minor(file->f_dentry->d_inode->i_rdev);
 	char ch;
 	int i = 0, retries;
 
@@ -185,7 +185,7 @@
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
 
-	if (MINOR(file->f_dentry->d_inode->i_rdev) != DTLK_MINOR)
+	if (minor(file->f_dentry->d_inode->i_rdev) != DTLK_MINOR)
 		return -EINVAL;
 
 	while (1) {
@@ -304,7 +304,7 @@
 {
 	TRACE_TEXT("(dtlk_open");
 
-	switch (MINOR(inode->i_rdev)) {
+	switch (minor(inode->i_rdev)) {
 	case DTLK_MINOR:
 		if (dtlk_busy)
 			return -EBUSY;
@@ -319,7 +319,7 @@
 {
 	TRACE_TEXT("(dtlk_release");
 
-	switch (MINOR(inode->i_rdev)) {
+	switch (minor(inode->i_rdev)) {
 	case DTLK_MINOR:
 		break;
 
Index: linux/drivers/char/dz.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/dz.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 dz.c
--- linux/drivers/char/dz.c	2001/12/26 19:13:24	1.1.1.15
+++ linux/drivers/char/dz.c	2002/01/05 02:54:36
@@ -1273,7 +1273,7 @@
 	struct dz_serial *info;
 	int retval, line;
 
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 
 	/*
 	 * The dz lines for the mouse/keyboard must be opened using their
@@ -1508,7 +1508,7 @@
 
 static kdev_t dz_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 static int __init dz_console_setup(struct console *co, char *options)
Index: linux/drivers/char/epca.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/epca.c,v
retrieving revision 1.1.1.23
diff -u -r1.1.1.23 epca.c
--- linux/drivers/char/epca.c	2001/12/31 23:52:16	1.1.1.23
+++ linux/drivers/char/epca.c	2002/01/05 02:54:36
@@ -1384,7 +1384,7 @@
 		return (0) ;
 	}
 
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if (line < 0 || line >= nbdevs) 
 	{
 		printk(KERN_ERR "<Error> - pc_open : line out of range in pc_open\n");
@@ -2895,7 +2895,7 @@
 	if (bc->orun) 
 	{
 		bc->orun = 0;
-		printk(KERN_WARNING "overrun! DigiBoard device minor = %d\n",MINOR(tty->device));
+		printk(KERN_WARNING "overrun! DigiBoard device minor = %d\n",minor(tty->device));
 	}
 
 	rxwinon(ch);
Index: linux/drivers/char/esp.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/esp.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 esp.c
--- linux/drivers/char/esp.c	2001/12/31 23:52:11	1.1.1.16
+++ linux/drivers/char/esp.c	2002/01/05 02:54:36
@@ -2354,7 +2354,7 @@
 	struct esp_struct	*info;
 	int 			retval, line;
 
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= NR_PORTS))
 		return -ENODEV;
 
Index: linux/drivers/char/ip2main.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/ip2main.c,v
retrieving revision 1.11
diff -u -r1.11 ip2main.c
--- linux/drivers/char/ip2main.c	2002/01/01 00:01:56	1.11
+++ linux/drivers/char/ip2main.c	2002/01/05 02:54:36
@@ -1601,9 +1601,9 @@
 	wait_queue_t wait;
 	int rc = 0;
 	int do_clocal = 0;
-	i2ChanStrPtr  pCh = DevTable[MINOR(tty->device)];
+	i2ChanStrPtr  pCh = DevTable[minor(tty->device)];
 
-	ip2trace (MINOR(tty->device), ITRC_OPEN, ITRC_ENTER, 0 );
+	ip2trace (minor(tty->device), ITRC_OPEN, ITRC_ENTER, 0 );
 
 	if ( pCh == NULL ) {
 		return -ENODEV;
@@ -1616,7 +1616,7 @@
 #ifdef IP2DEBUG_OPEN
 	printk(KERN_DEBUG \
 			"IP2:open(tty=%p,pFile=%p):dev=%x,maj=%d,min=%d,ch=%d,idx=%d\n",
-	       tty, pFile, tty->device, MAJOR(tty->device), MINOR(tty->device),
+	       tty, pFile, tty->device, major(tty->device), minor(tty->device),
 			 pCh->infl.hd.i2sChannel, pCh->port_index);
 	open_sanity_check ( pCh, pCh->pMyBord );
 #endif
@@ -1808,7 +1808,7 @@
 	ip2trace (CHANN, ITRC_CLOSE, ITRC_ENTER, 0 );
 
 #ifdef IP2DEBUG_OPEN
-	printk(KERN_DEBUG "IP2:close ttyF%02X:\n",MINOR(tty->device));
+	printk(KERN_DEBUG "IP2:close ttyF%02X:\n",minor(tty->device));
 #endif
 
 	if ( tty_hung_up_p ( pFile ) ) {
@@ -2217,7 +2217,7 @@
 static void
 ip2_start ( PTTY tty )
 {
- 	i2ChanStrPtr  pCh = DevTable[MINOR(tty->device)];
+ 	i2ChanStrPtr  pCh = DevTable[minor(tty->device)];
 
  	i2QueueCommands(PTYPE_BYPASS, pCh, 0, 1, CMD_RESUME);
  	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_UNSUSPEND);
@@ -2230,7 +2230,7 @@
 static void
 ip2_stop ( PTTY tty )
 {
- 	i2ChanStrPtr  pCh = DevTable[MINOR(tty->device)];
+ 	i2ChanStrPtr  pCh = DevTable[minor(tty->device)];
 
  	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_SUSPEND);
 #ifdef IP2DEBUG_WRITE
@@ -2258,7 +2258,7 @@
 ip2_ioctl ( PTTY tty, struct file *pFile, UINT cmd, ULONG arg )
 {
 	wait_queue_t wait;
-	i2ChanStrPtr pCh = DevTable[MINOR(tty->device)];
+	i2ChanStrPtr pCh = DevTable[minor(tty->device)];
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct *p_cuser;	/* user space */
 	int rc = 0;
@@ -3022,12 +3022,12 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)
 int
 ip2_ipl_read(struct inode *pInode, char *pData, size_t count, loff_t *off )
-	unsigned int minor = MINOR( pInode->i_rdev );
+	unsigned int minor = minor( pInode->i_rdev );
 #else
 ssize_t
 ip2_ipl_read(struct file *pFile, char *pData, size_t count, loff_t *off )
 {
-	unsigned int minor = MINOR( pFile->f_dentry->d_inode->i_rdev );
+	unsigned int minor = minor( pFile->f_dentry->d_inode->i_rdev );
 #endif
 	int rc = 0;
 
@@ -3158,7 +3158,7 @@
 static int
 ip2_ipl_ioctl ( struct inode *pInode, struct file *pFile, UINT cmd, ULONG arg )
 {
-	unsigned int iplminor = MINOR(pInode->i_rdev);
+	unsigned int iplminor = minor(pInode->i_rdev);
 	int rc = 0;
 	ULONG *pIndex = (ULONG*)arg;
 	i2eBordStrPtr pB = i2BoardPtrTable[iplminor / 4];
@@ -3293,7 +3293,7 @@
 static int
 ip2_ipl_open( struct inode *pInode, struct file *pFile )
 {
-	unsigned int iplminor = MINOR(pInode->i_rdev);
+	unsigned int iplminor = minor(pInode->i_rdev);
 	i2eBordStrPtr pB;
 	i2ChanStrPtr  pCh;
 
Index: linux/drivers/char/isicom.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/isicom.c,v
retrieving revision 1.20
diff -u -r1.20 isicom.c
--- linux/drivers/char/isicom.c	2002/01/01 00:01:52	1.20
+++ linux/drivers/char/isicom.c	2002/01/05 02:54:36
@@ -1021,7 +1021,7 @@
 #ifdef ISICOM_DEBUG	
 	printk(KERN_DEBUG "ISICOM: open start!!!.\n");
 #endif	
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	
 #ifdef ISICOM_DEBUG	
 	printk(KERN_DEBUG "line = %d.\n", line);
Index: linux/drivers/char/istallion.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/istallion.c,v
retrieving revision 1.25
diff -u -r1.25 istallion.c
--- linux/drivers/char/istallion.c	2001/10/31 13:10:21	1.25
+++ linux/drivers/char/istallion.c	2002/01/05 02:54:36
@@ -1034,7 +1034,7 @@
 		(int) filp, tty->device);
 #endif
 
-	minordev = MINOR(tty->device);
+	minordev = minor(tty->device);
 	brdnr = MINOR2BRD(minordev);
 	if (brdnr >= stli_nrbrds)
 		return(-ENODEV);
@@ -4859,7 +4859,7 @@
 			(int) fp, (int) buf, count, (int) offp);
 #endif
 
-	brdnr = MINOR(fp->f_dentry->d_inode->i_rdev);
+	brdnr = minor(fp->f_dentry->d_inode->i_rdev);
 	if (brdnr >= stli_nrbrds)
 		return(-ENODEV);
 	brdp = stli_brds[brdnr];
@@ -4910,7 +4910,7 @@
 			(int) fp, (int) buf, count, (int) offp);
 #endif
 
-	brdnr = MINOR(fp->f_dentry->d_inode->i_rdev);
+	brdnr = minor(fp->f_dentry->d_inode->i_rdev);
 	if (brdnr >= stli_nrbrds)
 		return(-ENODEV);
 	brdp = stli_brds[brdnr];
@@ -5247,7 +5247,7 @@
  *	Now handle the board specific ioctls. These all depend on the
  *	minor number of the device they were called from.
  */
-	brdnr = MINOR(ip->i_rdev);
+	brdnr = minor(ip->i_rdev);
 	if (brdnr >= STL_MAXBRDS)
 		return(-ENODEV);
 	brdp = stli_brds[brdnr];
Index: linux/drivers/char/ite_gpio.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/ite_gpio.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ite_gpio.c
--- linux/drivers/char/ite_gpio.c	2001/09/10 09:01:33	1.1.1.1
+++ linux/drivers/char/ite_gpio.c	2002/01/05 02:54:36
@@ -238,7 +238,7 @@
 
 static int ite_gpio_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = MINOR(inode->i_rdev); 
+	unsigned int minor = minor(inode->i_rdev); 
 	if (minor != GPIO_MINOR)
 		return -ENODEV;
 
Index: linux/drivers/char/lp.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/lp.c,v
retrieving revision 1.19
diff -u -r1.19 lp.c
--- linux/drivers/char/lp.c	2002/01/04 04:12:10	1.19
+++ linux/drivers/char/lp.c	2002/01/05 02:54:36
@@ -690,7 +690,7 @@
 
 static kdev_t lp_console_device (struct console *c)
 {
-	return MKDEV(LP_MAJOR, CONSOLE_LP);
+	return mk_kdev(LP_MAJOR, CONSOLE_LP);
 }
 
 static struct console lpcons = {
Index: linux/drivers/char/moxa.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/moxa.c,v
retrieving revision 1.12
diff -u -r1.12 moxa.c
--- linux/drivers/char/moxa.c	2002/01/01 00:01:58	1.12
+++ linux/drivers/char/moxa.c	2002/01/05 02:54:36
@@ -189,7 +189,7 @@
 
 #define WAKEUP_CHARS		256
 
-#define PORTNO(x)		(MINOR((x)->device) - (x)->driver.minor_start)
+#define PORTNO(x)		(minor((x)->device) - (x)->driver.minor_start)
 
 static int verbose = 0;
 static int ttymajor = MOXAMAJOR;
@@ -648,7 +648,7 @@
 	}
 	if (--ch->count < 0) {
 		printk("moxa_close: bad serial port count, minor=%d\n",
-		       MINOR(tty->device));
+		       minor(tty->device));
 		ch->count = 0;
 	}
 	if (ch->count) {
Index: linux/drivers/char/mxser.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/mxser.c,v
retrieving revision 1.20
diff -u -r1.20 mxser.c
--- linux/drivers/char/mxser.c	2002/01/01 00:01:54	1.20
+++ linux/drivers/char/mxser.c	2002/01/05 02:54:36
@@ -92,7 +92,7 @@
 #define 	UART_MCR_AFE		0x20
 #define 	UART_LSR_SPECIAL	0x1E
 
-#define PORTNO(x)		(MINOR((x)->device) - (x)->driver.minor_start)
+#define PORTNO(x)		(minor((x)->device) - (x)->driver.minor_start)
 
 #define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
 
Index: linux/drivers/char/n_hdlc.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/n_hdlc.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 n_hdlc.c
--- linux/drivers/char/n_hdlc.c	2001/12/31 23:52:14	1.1.1.16
+++ linux/drivers/char/n_hdlc.c	2002/01/05 02:54:36
@@ -327,7 +327,7 @@
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
 		printk("%s(%d)n_hdlc_tty_open() called (major=%u,minor=%u)\n",
 		__FILE__,__LINE__,
-		MAJOR(tty->device), MINOR(tty->device));
+		major(tty->device), minor(tty->device));
 		
 	/* There should not be an existing table for this slot. */
 	if (n_hdlc) {
Index: linux/drivers/char/pcxx.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/pcxx.c,v
retrieving revision 1.1.1.19
diff -u -r1.1.1.19 pcxx.c
--- linux/drivers/char/pcxx.c	2001/09/20 07:45:10	1.1.1.19
+++ linux/drivers/char/pcxx.c	2002/01/05 02:54:36
@@ -406,7 +406,7 @@
 	int boardnum;
 	int retval;
 
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 
 	if(line < 0 || line >= nbdevs) {
 		printk("line out of range in pcxe_open\n");
@@ -2080,7 +2080,7 @@
 
 	if(bc->orun) {
 		bc->orun = 0;
-		printk("overrun! DigiBoard device minor=%d\n",MINOR(tty->device));
+		printk("overrun! DigiBoard device minor=%d\n",minor(tty->device));
 	}
 
 	rxwinon(ch);
Index: linux/drivers/char/riscom8.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/riscom8.c,v
retrieving revision 1.13
diff -u -r1.13 riscom8.c
--- linux/drivers/char/riscom8.c	2001/09/20 07:53:09	1.13
+++ linux/drivers/char/riscom8.c	2002/01/05 02:54:36
@@ -1090,12 +1090,12 @@
 	struct riscom_board * bp;
 	unsigned long flags;
 	
-	board = RC_BOARD(MINOR(tty->device));
+	board = RC_BOARD(minor(tty->device));
 	if (board > RC_NBOARD || !(rc_board[board].flags & RC_BOARD_PRESENT))
 		return -ENODEV;
 	
 	bp = &rc_board[board];
-	port = rc_port + board * RC_NPORT + RC_PORT(MINOR(tty->device));
+	port = rc_port + board * RC_NPORT + RC_PORT(minor(tty->device));
 	if (rc_paranoia_check(port, tty->device, "rc_open"))
 		return -ENODEV;
 	
Index: linux/drivers/char/sbc60xxwdt.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/sbc60xxwdt.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 sbc60xxwdt.c
--- linux/drivers/char/sbc60xxwdt.c	2001/11/29 02:37:08	1.1.1.15
+++ linux/drivers/char/sbc60xxwdt.c	2002/01/05 02:54:36
@@ -196,7 +196,7 @@
 
 static int fop_open(struct inode * inode, struct file * file)
 {
-	switch(MINOR(inode->i_rdev)) 
+	switch(minor(inode->i_rdev)) 
 	{
 		case WATCHDOG_MINOR:
 			/* Just in case we're already talking to someone... */
@@ -214,7 +214,7 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	if(MINOR(inode->i_rdev) == WATCHDOG_MINOR) 
+	if(minor(inode->i_rdev) == WATCHDOG_MINOR) 
 	{
 		if(wdt_expect_close)
 			wdt_turnoff();
Index: linux/drivers/char/ser_a2232.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/ser_a2232.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 ser_a2232.c
--- linux/drivers/char/ser_a2232.c	2001/09/20 07:45:18	1.1.1.4
+++ linux/drivers/char/ser_a2232.c	2002/01/05 02:54:36
@@ -460,7 +460,7 @@
 	int retval;
 	struct a2232_port *port;
 
-	line = MINOR(tty->device);
+	line = minor(tty->device);
 	port = &a2232_ports[line];
 	
 	tty->driver_data = port;
Index: linux/drivers/char/serial.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/serial.c,v
retrieving revision 1.25
diff -u -r1.25 serial.c
--- linux/drivers/char/serial.c	2002/01/02 00:18:07	1.25
+++ linux/drivers/char/serial.c	2002/01/05 02:54:36
@@ -6108,7 +6108,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 /*
Index: linux/drivers/char/serial167.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/serial167.c,v
retrieving revision 1.1.1.14
diff -u -r1.1.1.14 serial167.c
--- linux/drivers/char/serial167.c	2001/12/31 23:52:19	1.1.1.14
+++ linux/drivers/char/serial167.c	2002/01/05 02:54:36
@@ -248,18 +248,18 @@
 	"Warning: cyclades_port out of range for (%d, %d) in %s\n";
 
     if (!info) {
-	printk(badinfo, MAJOR(device), MINOR(device), routine);
+	printk(badinfo, major(device), minor(device), routine);
 	return 1;
     }
 
     if( (long)info < (long)(&cy_port[0])
     || (long)(&cy_port[NR_PORTS]) < (long)info ){
-	printk(badrange, MAJOR(device), MINOR(device), routine);
+	printk(badrange, major(device), minor(device), routine);
 	return 1;
     }
 
     if (info->magic != CYCLADES_MAGIC) {
-	printk(badmagic, MAJOR(device), MINOR(device), routine);
+	printk(badmagic, major(device), minor(device), routine);
 	return 1;
     }
 #endif
@@ -2132,7 +2132,7 @@
   int retval, line;
 
 /* CP('O'); */
-    line = MINOR(tty->device) - tty->driver.minor_start;
+    line = minor(tty->device) - tty->driver.minor_start;
     if ((line < 0) || (NR_PORTS <= line)){
         return -ENODEV;
     }
@@ -2807,7 +2807,7 @@
 
 static kdev_t serial167_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 
Index: linux/drivers/char/serial_21285.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/serial_21285.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 serial_21285.c
--- linux/drivers/char/serial_21285.c	2001/12/26 19:13:29	1.1.1.7
+++ linux/drivers/char/serial_21285.c	2002/01/05 02:54:36
@@ -264,7 +264,7 @@
 	int line;
 
 	MOD_INC_USE_COUNT;
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if (line) {
 		MOD_DEC_USE_COUNT;
 		return -ENODEV;
@@ -391,7 +391,7 @@
 
 static kdev_t rs285_console_device(struct console *c)
 {
-	return MKDEV(SERIAL_21285_MAJOR, SERIAL_21285_MINOR);
+	return mk_kdev(SERIAL_21285_MAJOR, SERIAL_21285_MINOR);
 }
 
 static int __init rs285_console_setup(struct console *co, char *options)
Index: linux/drivers/char/serial_amba.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/serial_amba.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 serial_amba.c
--- linux/drivers/char/serial_amba.c	2001/12/26 19:13:24	1.1.1.8
+++ linux/drivers/char/serial_amba.c	2002/01/05 02:54:36
@@ -953,7 +953,7 @@
 
 #if DEBUG
 	printk("ambauart_flush_buffer(%d) called\n",
-	       MINOR(tty->device) - tty->driver.minor_start);
+	       minor(tty->device) - tty->driver.minor_start);
 #endif
 	save_flags(flags); cli();
 	info->xmit.head = info->xmit.tail = 0;
@@ -1515,7 +1515,7 @@
 	expire = jiffies + timeout;
 #if DEBUG
 	printk("ambauart_wait_until_sent(%d), jiff=%lu, expire=%lu...\n",
-	       MINOR(tty->device) - tty->driver.minor_start, jiffies,
+	       minor(tty->device) - tty->driver.minor_start, jiffies,
 	       expire);
 #endif
 	while (UART_GET_FR(info->port) & AMBA_UARTFR_BUSY) {
@@ -1690,7 +1690,7 @@
 static int ambauart_open(struct tty_struct *tty, struct file *filp)
 {
 	struct amba_info *info;
-	int retval, line = MINOR(tty->device) - tty->driver.minor_start;
+	int retval, line = minor(tty->device) - tty->driver.minor_start;
 
 #if DEBUG
 	printk("ambauart_open(%d) called\n", line);
@@ -1923,7 +1923,7 @@
 
 static kdev_t ambauart_console_device(struct console *c)
 {
-	return MKDEV(SERIAL_AMBA_MAJOR, SERIAL_AMBA_MINOR + c->index);
+	return mk_kdev(SERIAL_AMBA_MAJOR, SERIAL_AMBA_MINOR + c->index);
 }
 
 static int __init ambauart_console_setup(struct console *co, char *options)
Index: linux/drivers/char/serial_tx3912.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/serial_tx3912.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 serial_tx3912.c
--- linux/drivers/char/serial_tx3912.c	2001/12/26 19:13:30	1.1.1.3
+++ linux/drivers/char/serial_tx3912.c	2002/01/05 02:54:36
@@ -548,7 +548,7 @@
 		return -EIO;
 	}
 
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	rs_dprintk (TX3912_UART_DEBUG_OPEN, "%d: opening line %d. tty=%p ctty=%p)\n", 
 	            (int) current->pid, line, tty, current->tty);
 
@@ -1007,7 +1007,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 static __init int serial_console_setup(struct console *co, char *options)
Index: linux/drivers/char/sh-sci.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/sh-sci.c,v
retrieving revision 1.1.1.21
diff -u -r1.1.1.21 sh-sci.c
--- linux/drivers/char/sh-sci.c	2001/12/26 19:13:21	1.1.1.21
+++ linux/drivers/char/sh-sci.c	2002/01/05 02:54:36
@@ -813,7 +813,7 @@
 	struct sci_port *port;
 	int retval, line;
 
-	line = MINOR(tty->device) - SCI_MINOR_START;
+	line = minor(tty->device) - SCI_MINOR_START;
 
 	if ((line < 0) || (line >= SCI_NPORTS))
 		return -ENODEV;
@@ -1183,7 +1183,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(SCI_MAJOR, SCI_MINOR_START + c->index);
+	return mk_kdev(SCI_MAJOR, SCI_MINOR_START + c->index);
 }
 
 /*
Index: linux/drivers/char/shwdt.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/shwdt.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 shwdt.c
--- linux/drivers/char/shwdt.c	2001/12/12 11:51:50	1.1.1.2
+++ linux/drivers/char/shwdt.c	2002/01/05 02:54:36
@@ -131,7 +131,7 @@
  */
 static int sh_wdt_open(struct inode *inode, struct file *file)
 {
-	switch (MINOR(inode->i_rdev)) {
+	switch (minor(inode->i_rdev)) {
 		case WATCHDOG_MINOR:
 			if (sh_is_open) {
 				return -EBUSY;
@@ -160,7 +160,7 @@
 {
 	lock_kernel();
 	
-	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
+	if (minor(inode->i_rdev) == WATCHDOG_MINOR) {
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 		sh_wdt_stop();
 #endif
Index: linux/drivers/char/specialix.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/specialix.c,v
retrieving revision 1.16
diff -u -r1.16 specialix.c
--- linux/drivers/char/specialix.c	2001/11/14 23:56:57	1.16
+++ linux/drivers/char/specialix.c	2002/01/05 02:54:36
@@ -1456,17 +1456,17 @@
 	struct specialix_board * bp;
 	unsigned long flags;
 	
-	board = SX_BOARD(MINOR(tty->device));
+	board = SX_BOARD(minor(tty->device));
 
 	if (board > SX_NBOARD || !(sx_board[board].flags & SX_BOARD_PRESENT))
 		return -ENODEV;
 	
 	bp = &sx_board[board];
-	port = sx_port + board * SX_NPORT + SX_PORT(MINOR(tty->device));
+	port = sx_port + board * SX_NPORT + SX_PORT(minor(tty->device));
 
 #ifdef DEBUG_SPECIALIX
 	printk (KERN_DEBUG "Board = %d, bp = %p, port = %p, portno = %d.\n", 
-	        board, bp, port, SX_PORT(MINOR(tty->device)));
+	        board, bp, port, SX_PORT(minor(tty->device)));
 #endif
 
 	if (sx_paranoia_check(port, tty->device, "sx_open"))
Index: linux/drivers/char/stallion.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/stallion.c,v
retrieving revision 1.10
diff -u -r1.10 stallion.c
--- linux/drivers/char/stallion.c	2001/09/22 19:46:11	1.10
+++ linux/drivers/char/stallion.c	2002/01/05 02:54:36
@@ -1028,7 +1028,7 @@
 		(int) filp, tty->device);
 #endif
 
-	minordev = MINOR(tty->device);
+	minordev = minor(tty->device);
 	brdnr = MINOR2BRD(minordev);
 	if (brdnr >= stl_nrbrds)
 		return(-ENODEV);
@@ -3143,7 +3143,7 @@
 		(int) fp, cmd, (int) arg);
 #endif
 
-	brdnr = MINOR(ip->i_rdev);
+	brdnr = minor(ip->i_rdev);
 	if (brdnr >= STL_MAXBRDS)
 		return(-ENODEV);
 	rc = 0;
Index: linux/drivers/char/sx.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/sx.c,v
retrieving revision 1.25
diff -u -r1.25 sx.c
--- linux/drivers/char/sx.c	2001/11/15 13:31:13	1.25
+++ linux/drivers/char/sx.c	2002/01/05 02:54:36
@@ -1420,7 +1420,7 @@
 		return -EIO;
 	}
 
-	line = MINOR(tty->device);
+	line = minor(tty->device);
 	sx_dprintk (SX_DEBUG_OPEN, "%d: opening line %d. tty=%p ctty=%p, np=%d)\n", 
 	            current->pid, line, tty, current->tty, sx_nports);
 
Index: linux/drivers/char/synclink.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/synclink.c,v
retrieving revision 1.1.1.24
diff -u -r1.1.1.24 synclink.c
--- linux/drivers/char/synclink.c	2001/12/31 23:52:19	1.1.1.24
+++ linux/drivers/char/synclink.c	2002/01/05 02:54:36
@@ -3600,7 +3600,7 @@
 	unsigned long flags;
 
 	/* verify range of specified line number */	
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= mgsl_device_count)) {
 		printk("%s(%d):mgsl_open with illegal line #%d.\n",
 			__FILE__,__LINE__,line);
Index: linux/drivers/char/tpqic02.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/tpqic02.c,v
retrieving revision 1.1.1.22
diff -u -r1.1.1.22 tpqic02.c
--- linux/drivers/char/tpqic02.c	2001/11/29 02:37:02	1.1.1.22
+++ linux/drivers/char/tpqic02.c	2002/01/05 02:54:36
@@ -1830,7 +1830,7 @@
 		/* can't print a ``long long'' (for filp->f_pos), so chop it */
 		printk(TPQIC02_NAME
 		       ": request READ, minor=%x, buf=%p, count=%lx"
-		       ", pos=%lx, flags=%x\n", MINOR(dev), buf,
+		       ", pos=%lx, flags=%x\n", minor(dev), buf,
 		       (long) count, (unsigned long) filp->f_pos, flags);
 
 	if (count % TAPE_BLKSIZE) {	/* Only allow mod 512 bytes at a time. */
@@ -2027,7 +2027,7 @@
 		/* can't print a ``long long'' (for filp->f_pos), so chop it */
 		printk(TPQIC02_NAME ": request WRITE, minor=%x, buf=%p"
 		       ", count=%lx, pos=%lx, flags=%x\n",
-		       MINOR(dev), buf,
+		       minor(dev), buf,
 		       (long) count, (unsigned long) filp->f_pos, flags);
 	}
 
@@ -2203,7 +2203,7 @@
 		       kdevname(dev), flags);
 	}
 
-	if (MINOR(dev) == 255) {	/* special case for resetting */
+	if (minor(dev) == 255) {	/* special case for resetting */
 		if (capable(CAP_SYS_ADMIN)) {
 			return (tape_reset(1) == TE_OK) ? -EAGAIN : -ENXIO;
 		} else {
@@ -2383,7 +2383,7 @@
 	}
 	if (s != 0) {
 		status_dead = YES;	/* force reset */
-		current_tape_dev = 0;	/* earlier 0xff80 */
+		current_tape_dev = NODEV;/* earlier 0xff80 */
 		return -EIO;
 	}
 
@@ -2522,7 +2522,7 @@
 			    unsigned int iocmd, unsigned long ioarg)
 {
 	int error;
-	int dev_maj = MAJOR(inode->i_rdev);
+	int dev_maj = major(inode->i_rdev);
 	int c;
 	struct mtop operation;
 	unsigned char blk_addr[6];
@@ -2828,7 +2828,7 @@
 		return -ENODEV;
 	}
 
-	current_tape_dev = MKDEV(QIC02_TAPE_MAJOR, 0);
+	current_tape_dev = mk_kdev(QIC02_TAPE_MAJOR, 0);
 
 #ifndef CONFIG_QIC02_DYNCONF
 	printk(TPQIC02_NAME ": IRQ %d, DMA %d, IO 0x%x, IFC %s, %s, %s\n",
Index: linux/drivers/char/vme_scc.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/vme_scc.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 vme_scc.c
--- linux/drivers/char/vme_scc.c	2001/12/26 19:13:26	1.1.1.9
+++ linux/drivers/char/vme_scc.c	2002/01/05 02:54:36
@@ -833,7 +833,7 @@
 
 static int scc_open (struct tty_struct * tty, struct file * filp)
 {
-	int line = MINOR(tty->device) - SCC_MINOR_BASE;
+	int line = minor(tty->device) - SCC_MINOR_BASE;
 	int retval;
 	struct scc_port *port = &scc_ports[line];
 	int i, channel = port->channel;
@@ -1067,7 +1067,7 @@
 
 static kdev_t scc_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, SCC_MINOR_BASE + c->index);
+	return mk_kdev(TTY_MAJOR, SCC_MINOR_BASE + c->index);
 }
 
 
Index: linux/drivers/char/w83877f_wdt.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/w83877f_wdt.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 w83877f_wdt.c
--- linux/drivers/char/w83877f_wdt.c	2001/11/29 02:37:12	1.1.1.6
+++ linux/drivers/char/w83877f_wdt.c	2002/01/05 02:54:36
@@ -196,7 +196,7 @@
 
 static int fop_open(struct inode * inode, struct file * file)
 {
-	switch(MINOR(inode->i_rdev)) 
+	switch(minor(inode->i_rdev)) 
 	{
 		case WATCHDOG_MINOR:
 			/* Just in case we're already talking to someone... */
@@ -214,7 +214,7 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	if(MINOR(inode->i_rdev) == WATCHDOG_MINOR) 
+	if(minor(inode->i_rdev) == WATCHDOG_MINOR) 
 	{
 		if(wdt_expect_close)
 			wdt_turnoff();
Index: linux/drivers/char/ftape/zftape/zftape-init.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/ftape/zftape/zftape-init.c,v
retrieving revision 1.1.1.17
diff -u -r1.1.1.17 zftape-init.c
--- linux/drivers/char/ftape/zftape/zftape-init.c	2001/12/31 23:52:28	1.1.1.17
+++ linux/drivers/char/ftape/zftape/zftape-init.c	2002/01/05 02:54:36
@@ -112,11 +112,11 @@
 	int result;
 	TRACE_FUN(ft_t_flow);
 
-	TRACE(ft_t_flow, "called for minor %d", MINOR(ino->i_rdev));
+	TRACE(ft_t_flow, "called for minor %d", minor(ino->i_rdev));
 	if ( test_and_set_bit(0,&busy_flag) ) {
 		TRACE_ABORT(-EBUSY, ft_t_warn, "failed: already busy");
 	}
-	if ((MINOR(ino->i_rdev) & ~(ZFT_MINOR_OP_MASK | FTAPE_NO_REWIND))
+	if ((minor(ino->i_rdev) & ~(ZFT_MINOR_OP_MASK | FTAPE_NO_REWIND))
 	     > 
 	    FTAPE_SEL_D) {
 		clear_bit(0,&busy_flag);
@@ -124,7 +124,7 @@
 	}
 	orig_sigmask = current->blocked;
 	sigfillset(&current->blocked);
-	result = _zft_open(MINOR(ino->i_rdev), filep->f_flags & O_ACCMODE);
+	result = _zft_open(minor(ino->i_rdev), filep->f_flags & O_ACCMODE);
 	if (result < 0) {
 		current->blocked = orig_sigmask; /* restore mask */
 		clear_bit(0,&busy_flag);
@@ -146,7 +146,7 @@
 	int result;
 	TRACE_FUN(ft_t_flow);
 
-	if ( !test_bit(0,&busy_flag) || MINOR(ino->i_rdev) != zft_unit) {
+	if ( !test_bit(0,&busy_flag) || minor(ino->i_rdev) != zft_unit) {
 		TRACE(ft_t_err, "failed: not busy or wrong unit");
 		TRACE_EXIT 0;
 	}
@@ -169,7 +169,7 @@
 	sigset_t old_sigmask;
 	TRACE_FUN(ft_t_flow);
 
-	if ( !test_bit(0,&busy_flag) || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
+	if ( !test_bit(0,&busy_flag) || minor(ino->i_rdev) != zft_unit || ft_failure) {
 		TRACE_ABORT(-EIO, ft_t_err,
 			    "failed: not busy, failure or wrong unit");
 	}
@@ -190,7 +190,7 @@
 	TRACE_FUN(ft_t_flow);
 
 	if ( !test_bit(0,&busy_flag) || 
-	    MINOR(filep->f_dentry->d_inode->i_rdev) != zft_unit || 
+	    minor(filep->f_dentry->d_inode->i_rdev) != zft_unit || 
 	    ft_failure)
 	{
 		TRACE_ABORT(-EIO, ft_t_err,
@@ -219,7 +219,7 @@
 	TRACE_FUN(ft_t_flow);
 
 	TRACE(ft_t_data_flow, "called with count: %ld", (unsigned long)req_len);
-	if (!test_bit(0,&busy_flag)  || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
+	if (!test_bit(0,&busy_flag)  || minor(ino->i_rdev) != zft_unit || ft_failure) {
 		TRACE_ABORT(-EIO, ft_t_err,
 			    "failed: not busy, failure or wrong unit");
 	}
@@ -242,7 +242,7 @@
 	TRACE_FUN(ft_t_flow);
 
 	TRACE(ft_t_flow, "called with count: %ld", (unsigned long)req_len);
-	if (!test_bit(0,&busy_flag) || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
+	if (!test_bit(0,&busy_flag) || minor(ino->i_rdev) != zft_unit || ft_failure) {
 		TRACE_ABORT(-EIO, ft_t_err,
 			    "failed: not busy, failure or wrong unit");
 	}
Index: linux/drivers/char/rio/rio_linux.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/rio/rio_linux.c,v
retrieving revision 1.8
diff -u -r1.8 rio_linux.c
--- linux/drivers/char/rio/rio_linux.c	2001/10/31 03:41:03	1.8
+++ linux/drivers/char/rio/rio_linux.c	2002/01/05 02:54:36
@@ -387,16 +387,16 @@
 
 int rio_minor (kdev_t device)
 {
-  return MINOR (device) + 
-    256 * ((MAJOR (device) == RIO_NORMAL_MAJOR1) ||
-	   (MAJOR (device) == RIO_CALLOUT_MAJOR1));
+  return minor (device) + 
+    256 * ((major (device) == RIO_NORMAL_MAJOR1) ||
+	   (major (device) == RIO_CALLOUT_MAJOR1));
 }
 
 
 int rio_ismodem (kdev_t device)
 {
-  return (MAJOR (device) == RIO_NORMAL_MAJOR0) ||
-         (MAJOR (device) == RIO_NORMAL_MAJOR1);
+  return (major (device) == RIO_NORMAL_MAJOR0) ||
+         (major (device) == RIO_NORMAL_MAJOR1);
 }
 
 
@@ -436,7 +436,7 @@
 
   tty = ((struct Port *)ptr)->gs.tty;
 
-  modem = (MAJOR(tty->device) == RIO_NORMAL_MAJOR0) || (MAJOR(tty->device) == RIO_NORMAL_MAJOR1);
+  modem = (major(tty->device) == RIO_NORMAL_MAJOR0) || (major(tty->device) == RIO_NORMAL_MAJOR1);
 
   rv = RIOParam( (struct Port *) ptr, CONFIG, modem, 1);
 
Index: linux/drivers/char/rio/rioctrl.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/char/rio/rioctrl.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 rioctrl.c
--- linux/drivers/char/rio/rioctrl.c	2001/04/28 04:51:51	1.1.1.6
+++ linux/drivers/char/rio/rioctrl.c	2002/01/05 02:54:36
@@ -1737,15 +1737,15 @@
 
 					switch ( (uint)arg & RIO_DEV_MASK ) {
 						case RIO_DEV_DIRECT:
-							arg = (caddr_t)drv_makedev(major(dev), port);
+							arg = (caddr_t)drv_makedev(MAJOR(dev), port);
 							rio_dprintk (RIO_DEBUG_CTRL, "Makedev direct 0x%x is 0x%x\n",port, (int)arg);
 							return (int)arg;
 					 	case RIO_DEV_MODEM:
-							arg =  (caddr_t)drv_makedev(major(dev), (port|RIO_MODEM_BIT) );
+							arg =  (caddr_t)drv_makedev(MAJOR(dev), (port|RIO_MODEM_BIT) );
 							rio_dprintk (RIO_DEBUG_CTRL, "Makedev modem 0x%x is 0x%x\n",port, (int)arg);
 							return (int)arg;
 						case RIO_DEV_XPRINT:
-							arg = (caddr_t)drv_makedev(major(dev), port);
+							arg = (caddr_t)drv_makedev(MAJOR(dev), port);
 							rio_dprintk (RIO_DEBUG_CTRL, "Makedev printer 0x%x is 0x%x\n",port, (int)arg);
 							return (int)arg;
 					}

--liOOAslEiF7prFVr--
