Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319080AbSIJJXX>; Tue, 10 Sep 2002 05:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSIJJWX>; Tue, 10 Sep 2002 05:22:23 -0400
Received: from dp.samba.org ([66.70.73.150]:44507 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319090AbSIJJWC>;
	Tue, 10 Sep 2002 05:22:02 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] 2.5.31_drivers_char_lp.c
Date: Tue, 10 Sep 2002 19:20:15 +1000
Message-Id: <20020910092648.E88382C38D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ As per 2.4.19 AC kernel tree, makes sense --RR ]
From:  Lucas Correia Villa Real <lucasvr@terra.com.br>

  Hi,
  
  This is a trivial patch already applied in the -ac tree for the 2.4.19 kernel.
  Patch for lp.c avoid +/- operations with 0 and explicit some debug information
  as KERN_INFO or KERN_ERR.
  
  Comments?
  
  Lucas
  
  
  

--- trivial-2.5.34/drivers/char/lp.c.orig	2002-09-10 19:10:55.000000000 +1000
+++ trivial-2.5.34/drivers/char/lp.c	2002-09-10 19:10:55.000000000 +1000
@@ -335,7 +335,7 @@
 	do {
 		/* Write the data. */
 		written = parport_write (port, kbuf, copy_size);
-		if (written >= 0) {
+		if (written > 0) {
 			copy_size -= written;
 			count -= written;
 			buf  += written;
@@ -840,7 +840,7 @@
 		    port->probe_info[0].class != PARPORT_CLASS_PRINTER)
 			return;
 		if (lp_count == LP_NO) {
-			printk("lp: ignoring parallel port (max. %d)\n",LP_NO);
+			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n",LP_NO);
 			return;
 		}
 		if (!lp_register(lp_count, port))
@@ -904,14 +904,14 @@
 	}
 
 	if (register_chrdev (LP_MAJOR, "lp", &lp_fops)) {
-		printk ("lp: unable to get major %d\n", LP_MAJOR);
+		printk (KERN_ERR "lp: unable to get major %d\n", LP_MAJOR);
 		return -EIO;
 	}
 
 	devfs_handle = devfs_mk_dir (NULL, "printers", NULL);
 
 	if (parport_register_driver (&lp_driver)) {
-		printk ("lp: unable to register with parport\n");
+		printk (KERN_ERR "lp: unable to register with parport\n");
 		return -EIO;
 	}
 
-- 
  Don't blame me: the Monkey is driving
  File: Lucas Correia Villa Real <lucasvr@terra.com.br>: [PATCH] 2.5.31_drivers_char_lp.c
