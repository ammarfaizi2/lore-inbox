Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUKFSga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUKFSga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbUKFSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:36:29 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:33203 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261411AbUKFSgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:36:22 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, james4765@verizon.net
Message-Id: <20041106183621.22771.88728.72801@localhost.localdomain>
Subject: [PATCH][resend] hw_random: Update printk()'s in hw_random.c
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [68.238.31.6] at Sat, 6 Nov 2004 12:36:21 -0600
Date: Sat, 6 Nov 2004 12:36:22 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/hw_random.c linux-2.6.9/drivers/char/hw_random.c
--- linux-2.6.9-original/drivers/char/hw_random.c	2004-10-18 17:53:50.000000000 -0400
+++ linux-2.6.9/drivers/char/hw_random.c	2004-11-06 13:30:17.682633097 -0500
@@ -21,6 +21,7 @@
 
  */
 
+#undef DEBUG /* define to enable copious debugging info */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -56,31 +57,27 @@
 /*
  * debugging macros
  */
-#undef RNG_DEBUG /* define to enable copious debugging info */
 
-#ifdef RNG_DEBUG
-/* note: prints function name for you */
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
+/* pr_debug() collapses to a no-op if DEBUG is not defined */
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## args)
+
 
-#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
 #ifdef RNG_NDEBUG
-#define assert(expr)
+#define assert(expr)							\
+		if(!(expr)) {						\
+		pr_debug(PFX "Assertion failed! %s,%s,%s,line=%d\n",	\
+		#expr,__FILE__,__FUNCTION__,__LINE__);			\
+		}
 #else
-#define assert(expr) \
-        if(!(expr)) {                                   \
-        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
-        #expr,__FILE__,__FUNCTION__,__LINE__);          \
-        }
+#define assert(expr)
 #endif
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
 static int rng_dev_open (struct inode *inode, struct file *filp);
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
-			     loff_t * offp);
+                 loff_t * offp);
 
 static int __init intel_init (struct pci_dev *dev);
 static void intel_cleanup(void);
@@ -322,7 +319,7 @@
 	rnen |= (1 << 7);	/* PMIO enable */
 	pci_write_config_byte(dev, 0x41, rnen);
 
-	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
+	pr_info(PFX "AMD768 system management I/O registers at 0x%X.\n",pmbase);
 
 	amd_dev = dev;
 
@@ -606,7 +603,7 @@
 	if (rc)
 		return rc;
 
-	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
+	pr_info (RNG_DRIVER_NAME " loaded\n");
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
