Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTH0DMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTH0DMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:12:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:41958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263056AbTH0DL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:11:58 -0400
Date: Tue, 26 Aug 2003 20:10:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: chas@cmf.nrl.navy.mil, paulkf@microgate.com, hch@infradead.org
Subject: [PATCH] remove gcc warnings on printk (size_t)
Message-Id: <20030826201001.3e5ea6ab.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes warnings on non-matching parameter types to printk
and incorrect function types (n_hdlc).

Please apply.

--
~Randy


patch_name:	printk_sizes.patch
patch_version:	2003-08-26.19:23:02
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	use %Zd on printk size_t parameters to remove type warnings;
product:	Linux
product_versions: 260-test4
maintainer:	chas@cmf.nrl.navy.mil (ATM), paulkf@microgate.com (HDLC),
		hch@infradead.org (FREEVXFS)
diffstat:	=
 drivers/atm/eni.c        |    2 +-
 drivers/atm/firestream.c |   12 ++++++------
 drivers/char/n_hdlc.c    |   12 ++++++------
 fs/freevxfs/vxfs_inode.c |    2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)


diff -Naur ./drivers/char/n_hdlc.c~prtsize ./drivers/char/n_hdlc.c
--- ./drivers/char/n_hdlc.c~prtsize	Fri Aug 22 16:53:43 2003
+++ ./drivers/char/n_hdlc.c	Tue Aug 26 14:38:10 2003
@@ -182,9 +182,9 @@
 
 /* TTY callbacks */
 
-static int n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
+static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 			   __u8 *buf, size_t nr);
-static int n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
+static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			    const __u8 *buf, size_t nr);
 static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 			    unsigned int cmd, unsigned long arg);
@@ -572,7 +572,7 @@
  * 	
  * Returns the number of bytes returned or error code.
  */
-static int n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
+static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 			   __u8 *buf, size_t nr)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
@@ -649,7 +649,7 @@
  * 		
  * Returns the number of bytes written (or error code).
  */
-static int n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
+static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			    const __u8 *data, size_t count)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
@@ -658,7 +658,7 @@
 	struct n_hdlc_buf *tbuf;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_write() called count=%d\n",
+		printk("%s(%d)n_hdlc_tty_write() called count=%Zd\n",
 			__FILE__,__LINE__,count);
 		
 	/* Verify pointers */
@@ -673,7 +673,7 @@
 		if (debuglevel & DEBUG_LEVEL_INFO)
 			printk (KERN_WARNING
 				"n_hdlc_tty_write: truncating user packet "
-				"from %lu to %d\n", (unsigned long) count,
+				"from %lu to %Zd\n", (unsigned long) count,
 				maxframe );
 		count = maxframe;
 	}
diff -Naur ./drivers/atm/eni.c~prtsize ./drivers/atm/eni.c
--- ./drivers/atm/eni.c~prtsize	Fri Aug 22 16:53:08 2003
+++ ./drivers/atm/eni.c	Tue Aug 26 15:41:55 2003
@@ -2345,7 +2345,7 @@
 	struct sk_buff *skb; /* dummy for sizeof */
 
 	if (sizeof(skb->cb) < sizeof(struct eni_skb_prv)) {
-		printk(KERN_ERR "eni_detect: skb->cb is too small (%d < %d)\n",
+		printk(KERN_ERR "eni_detect: skb->cb is too small (%Zd < %Zd)\n",
 		    sizeof(skb->cb),sizeof(struct eni_skb_prv));
 		return -EIO;
 	}
diff -Naur ./drivers/atm/firestream.c~prtsize ./drivers/atm/firestream.c
--- ./drivers/atm/firestream.c~prtsize	Fri Aug 22 16:52:21 2003
+++ ./drivers/atm/firestream.c	Tue Aug 26 15:52:49 2003
@@ -895,7 +895,7 @@
 	/* XXX handle qos parameters (rate limiting) ? */
 
 	vcc = kmalloc(sizeof(struct fs_vcc), GFP_KERNEL);
-	fs_dprintk (FS_DEBUG_ALLOC, "Alloc VCC: %p(%d)\n", vcc, sizeof(struct fs_vcc));
+	fs_dprintk (FS_DEBUG_ALLOC, "Alloc VCC: %p(%Zd)\n", vcc, sizeof(struct fs_vcc));
 	if (!vcc) {
 		clear_bit(ATM_VF_ADDR, &atm_vcc->flags);
 		return -ENOMEM;
@@ -946,7 +946,7 @@
 
 	if (DO_DIRECTION (txtp)) {
 		tc = kmalloc (sizeof (struct fs_transmit_config), GFP_KERNEL);
-		fs_dprintk (FS_DEBUG_ALLOC, "Alloc tc: %p(%d)\n", 
+		fs_dprintk (FS_DEBUG_ALLOC, "Alloc tc: %p(%Zd)\n", 
 			    tc, sizeof (struct fs_transmit_config));
 		if (!tc) {
 			fs_dprintk (FS_DEBUG_OPEN, "fs: can't alloc transmit_config.\n");
@@ -1180,7 +1180,7 @@
 	vcc->last_skb = skb;
 
 	td = kmalloc (sizeof (struct FS_BPENTRY), GFP_ATOMIC);
-	fs_dprintk (FS_DEBUG_ALLOC, "Alloc transd: %p(%d)\n", td, sizeof (struct FS_BPENTRY));
+	fs_dprintk (FS_DEBUG_ALLOC, "Alloc transd: %p(%Zd)\n", td, sizeof (struct FS_BPENTRY));
 	if (!td) {
 		/* Oops out of mem */
 		return -ENOMEM;
@@ -1487,7 +1487,7 @@
 		fs_dprintk (FS_DEBUG_ALLOC, "Alloc rec-skb: %p(%d)\n", skb, fp->bufsize);
 		if (!skb) break;
 		ne = kmalloc (sizeof (struct FS_BPENTRY), gfp_flags);
-		fs_dprintk (FS_DEBUG_ALLOC, "Alloc rec-d: %p(%d)\n", ne, sizeof (struct FS_BPENTRY));
+		fs_dprintk (FS_DEBUG_ALLOC, "Alloc rec-d: %p(%Zd)\n", ne, sizeof (struct FS_BPENTRY));
 		if (!ne) {
 			fs_dprintk (FS_DEBUG_ALLOC, "Free rec-skb: %p\n", skb);
 			dev_kfree_skb_any (skb);
@@ -1792,7 +1792,7 @@
 	}
 	dev->atm_vccs = kmalloc (dev->nchannels * sizeof (struct atm_vcc *), 
 				 GFP_KERNEL);
-	fs_dprintk (FS_DEBUG_ALLOC, "Alloc atmvccs: %p(%d)\n", 
+	fs_dprintk (FS_DEBUG_ALLOC, "Alloc atmvccs: %p(%Zd)\n", 
 		    dev->atm_vccs, dev->nchannels * sizeof (struct atm_vcc *));
 
 	if (!dev->atm_vccs) {
@@ -1900,7 +1900,7 @@
 		goto err_out;
 
 	fs_dev = kmalloc (sizeof (struct fs_dev), GFP_KERNEL);
-	fs_dprintk (FS_DEBUG_ALLOC, "Alloc fs-dev: %p(%d)\n", 
+	fs_dprintk (FS_DEBUG_ALLOC, "Alloc fs-dev: %p(%Zd)\n", 
 		    fs_dev, sizeof (struct fs_dev));
 	if (!fs_dev)
 		goto err_out;
diff -Naur ./fs/freevxfs/vxfs_inode.c~prtsize ./fs/freevxfs/vxfs_inode.c
--- ./fs/freevxfs/vxfs_inode.c~prtsize	Tue Aug 26 16:01:08 2003
+++ ./fs/freevxfs/vxfs_inode.c	Tue Aug 26 16:01:29 2003
@@ -171,7 +171,7 @@
 	return NULL;
 
 fail:
-	printk(KERN_WARNING "vxfs: unable to read inode %ld\n", ino);
+	printk(KERN_WARNING "vxfs: unable to read inode %ld\n", (unsigned long)ino);
 	vxfs_put_page(pp);
 	return NULL;
 }
