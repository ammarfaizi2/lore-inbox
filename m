Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbRBNXie>; Wed, 14 Feb 2001 18:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130263AbRBNXiY>; Wed, 14 Feb 2001 18:38:24 -0500
Received: from jalon.able.es ([212.97.163.2]:58597 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130030AbRBNXiK>;
	Wed, 14 Feb 2001 18:38:10 -0500
Date: Thu, 15 Feb 2001 00:38:02 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] i2c 2.5.5
Message-ID: <20010215003802.A21100@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone...

Kernel 2.4 looks like including the updated i2c package. But the diff
automatic generator from i25 2.5.5 still gives this diffs against 2.4.1-ac13.
Think about them for inclussion...(I do not know if some of them are not
valid, like the change of <slab.h> for <malloc.h>, but the #ifdefs CONFIG_XXXX
perhaps matter)

============ patch follows ===============

--- linux-old/Documentation/i2c/dev-interface	Thu Feb 15 00:26:02 CET
2001
+++ linux/Documentation/i2c/dev-interface	Thu Feb 15 00:26:02 CET 2001
@@ -71,4 +71,7 @@
   }
 
+IMPORTANT: because of the use of inline functions, you *have* to use
+'-O' or some variation when you compile your program!
+
 
 Full interface description
--- linux-old/Documentation/i2c/smbus-protocol	Thu Feb 15 00:26:03 CET
2001
+++ linux/Documentation/i2c/smbus-protocol	Thu Feb 15 00:26:03 CET 2001
@@ -32,5 +32,5 @@
 =================
 
-This sends a single byte to the device, at the place of the Rd/Wr bit.
+This sends a single bit to the device, at the place of the Rd/Wr bit.
 There is no equivalent Read Quick command.
 
--- linux-old/drivers/i2c/i2c-algo-bit.c	Thu Feb 15 00:26:06 CET 2001
+++ linux/drivers/i2c/i2c-algo-bit.c	Thu Feb 15 00:26:06 CET 2001
@@ -22,10 +22,10 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.27 2000/07/09 15:16:16 frodo Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.28 2001/01/09 20:10:57 frodo Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/version.h>
 #include <linux/init.h>
--- linux-old/drivers/i2c/i2c-algo-pcf.c	Thu Feb 15 00:26:07 CET 2001
+++ linux/drivers/i2c/i2c-algo-pcf.c	Thu Feb 15 00:26:07 CET 2001
@@ -30,5 +30,5 @@
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/version.h>
 #include <linux/init.h>
--- linux-old/drivers/i2c/i2c-core.c	Thu Feb 15 00:26:10 CET 2001
+++ linux/drivers/i2c/i2c-core.c	Thu Feb 15 00:26:10 CET 2001
@@ -26,5 +26,5 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/proc_fs.h>
 #include <linux/config.h>
@@ -1278,12 +1278,29 @@
 
 #ifndef MODULE
+#ifdef CONFIG_I2C_CHARDEV
 	extern int i2c_dev_init(void);
+#endif
+#ifdef CONFIG_I2C_ALGOBIT
 	extern int i2c_algo_bit_init(void);
+#endif
+#ifdef CONFIG_I2C_BITLP
 	extern int i2c_bitlp_init(void);
+#endif
+#ifdef CONFIG_I2C_BITELV
 	extern int i2c_bitelv_init(void);
+#endif
+#ifdef CONFIG_I2C_BITVELLE
 	extern int i2c_bitvelle_init(void);
+#endif
+#ifdef CONFIG_I2C_BITVIA
 	extern int i2c_bitvia_init(void);
+#endif
+
+#ifdef CONFIG_I2C_ALGOPCF
 	extern int i2c_algo_pcf_init(void);	
+#endif
+#ifdef CONFIG_I2C_PCFISA
 	extern int i2c_pcfisa_init(void);
+#endif
 
 /* This is needed for automatic patch generation: sensors code starts here */
--- linux-old/drivers/i2c/i2c-dev.c	Thu Feb 15 00:26:11 CET 2001
+++ linux/drivers/i2c/i2c-dev.c	Thu Feb 15 00:26:11 CET 2001
@@ -29,5 +29,5 @@
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.36 2000/09/22 02:19:35 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.37 2001/01/09 20:10:57 frodo Exp $ */
 
 #include <linux/config.h>
@@ -35,5 +35,5 @@
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/version.h>
 #if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
--- linux-old/drivers/i2c/i2c-elektor.c	Thu Feb 15 00:26:12 CET 2001
+++ linux/drivers/i2c/i2c-elektor.c	Thu Feb 15 00:26:12 CET 2001
@@ -29,5 +29,5 @@
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/version.h>
 #include <linux/init.h>
--- linux-old/drivers/i2c/i2c-elv.c	Thu Feb 15 00:26:12 CET 2001
+++ linux/drivers/i2c/i2c-elv.c	Thu Feb 15 00:26:12 CET 2001
@@ -27,5 +27,5 @@
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/version.h>
 #include <linux/init.h>
--- linux-old/include/linux/i2c-id.h	Thu Feb 15 00:26:13 CET 2001
+++ linux/include/linux/i2c-id.h	Thu Feb 15 00:26:13 CET 2001
@@ -21,5 +21,5 @@
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.25 2000/10/12 07:27:29 simon Exp $ */
+/* $Id: i2c-id.h,v 1.27 2000/12/23 16:59:38 mds Exp $ */
 
 #ifndef I2C_ID_H

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac10 #1 SMP Sun Feb 11 23:36:46 CET 2001 i686

