Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286605AbSABB1D>; Tue, 1 Jan 2002 20:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286528AbSABBZM>; Tue, 1 Jan 2002 20:25:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286541AbSABBVw>;
	Tue, 1 Jan 2002 20:21:52 -0500
Message-ID: <3C3260AE.8514DF5A@mandrakesoft.com>
Date: Tue, 01 Jan 2002 20:21:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: tim@cyberelk.net, Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.2.6: fix lp, ppdev builds
Content-Type: multipart/mixed;
 boundary="------------D7D32002FFFD22FF628AB49E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D7D32002FFFD22FF628AB49E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------D7D32002FFFD22FF628AB49E
Content-Type: text/plain; charset=us-ascii;
 name="lp-2.5.2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lp-2.5.2.6.patch"

? drivers/char/conmakehash
? drivers/char/consolemap_deftbl.c
Index: drivers/char/lp.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/char/lp.c,v
retrieving revision 1.2
diff -u -r1.2 lp.c
--- drivers/char/lp.c	2001/11/30 01:10:57	1.2
+++ drivers/char/lp.c	2002/01/02 01:15:40
@@ -294,7 +294,7 @@
 static ssize_t lp_write(struct file * file, const char * buf,
 		        size_t count, loff_t *ppos)
 {
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	unsigned int minor = minor(file->f_dentry->d_inode->i_rdev);
 	struct parport *port = lp_table[minor].dev->port;
 	char *kbuf = lp_table[minor].lp_buffer;
 	ssize_t retv = 0;
@@ -403,7 +403,7 @@
 static ssize_t lp_read(struct file * file, char * buf,
 		       size_t count, loff_t *ppos)
 {
-	unsigned int minor=MINOR(file->f_dentry->d_inode->i_rdev);
+	unsigned int minor=minor(file->f_dentry->d_inode->i_rdev);
 	struct parport *port = lp_table[minor].dev->port;
 	ssize_t retval = 0;
 	char *kbuf = lp_table[minor].lp_buffer;
@@ -430,7 +430,7 @@
 
 static int lp_open(struct inode * inode, struct file * file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 
 	if (minor >= LP_NO)
 		return -ENXIO;
@@ -488,7 +488,7 @@
 
 static int lp_release(struct inode * inode, struct file * file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 
 	lp_claim_parport_or_block (&lp_table[minor]);
 	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
@@ -503,7 +503,7 @@
 static int lp_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	int status;
 	int retval = 0;
 
Index: drivers/char/ppdev.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/char/ppdev.c,v
retrieving revision 1.2
diff -u -r1.2 ppdev.c
--- drivers/char/ppdev.c	2001/11/30 01:10:57	1.2
+++ drivers/char/ppdev.c	2002/01/02 01:15:40
@@ -103,7 +103,7 @@
 static ssize_t pp_read (struct file * file, char * buf, size_t count,
 			loff_t * ppos)
 {
-	unsigned int minor = MINOR (file->f_dentry->d_inode->i_rdev);
+	unsigned int minor = minor (file->f_dentry->d_inode->i_rdev);
 	struct pp_struct *pp = file->private_data;
 	char * kbuffer;
 	ssize_t bytes_read = 0;
@@ -183,7 +183,7 @@
 static ssize_t pp_write (struct file * file, const char * buf, size_t count,
 			 loff_t * ppos)
 {
-	unsigned int minor = MINOR (file->f_dentry->d_inode->i_rdev);
+	unsigned int minor = minor (file->f_dentry->d_inode->i_rdev);
 	struct pp_struct *pp = file->private_data;
 	char * kbuffer;
 	ssize_t bytes_written = 0;
@@ -315,7 +315,7 @@
 static int pp_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	struct pp_struct *pp = file->private_data;
 	struct parport * port;
 
@@ -613,7 +613,7 @@
 
 static int pp_open (struct inode * inode, struct file * file)
 {
-	unsigned int minor = MINOR (inode->i_rdev);
+	unsigned int minor = minor (inode->i_rdev);
 	struct pp_struct *pp;
 
 	if (minor >= PARPORT_MAX)
@@ -642,7 +642,7 @@
 
 static int pp_release (struct inode * inode, struct file * file)
 {
-	unsigned int minor = MINOR (inode->i_rdev);
+	unsigned int minor = minor (inode->i_rdev);
 	struct pp_struct *pp = file->private_data;
 	int compat_negot;
 

--------------D7D32002FFFD22FF628AB49E--

