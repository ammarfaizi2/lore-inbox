Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWDML5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWDML5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWDML5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:57:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27918 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964892AbWDML5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:57:42 -0400
Date: Thu, 13 Apr 2006 13:57:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/hw_random.c: remove assert()'s
Message-ID: <20060413115742.GA8171@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the assert()'s from drivers/char/hw_random.c since
you both needed to enable a manual option in the driver source to make 
them effective and they only covered some obviously impossible cases.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/hw_random.c |   21 ---------------------
 1 file changed, 21 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/char/hw_random.c.old	2006-04-13 10:37:15.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/hw_random.c	2006-04-13 10:37:39.000000000 +0200
@@ -66,17 +66,6 @@
 #define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## args)
 
 
-#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
-#ifdef RNG_NDEBUG
-#define assert(expr)							\
-		if(!(expr)) {						\
-		printk(KERN_DEBUG PFX "Assertion failed! %s,%s,%s,"	\
-		"line=%d\n", #expr, __FILE__, __FUNCTION__, __LINE__);	\
-		}
-#else
-#define assert(expr)
-#endif
-
 #define RNG_MISCDEV_MINOR		183 /* official */
 
 static int rng_dev_open (struct inode *inode, struct file *filp);
@@ -211,29 +200,23 @@
 
 static inline u8 intel_hwstatus (void)
 {
-	assert (rng_mem != NULL);
 	return readb (rng_mem + INTEL_RNG_HW_STATUS);
 }
 
 static inline u8 intel_hwstatus_set (u8 hw_status)
 {
-	assert (rng_mem != NULL);
 	writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);
 	return intel_hwstatus ();
 }
 
 static unsigned int intel_data_present(void)
 {
-	assert (rng_mem != NULL);
-
 	return (readb (rng_mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT) ?
 		1 : 0;
 }
 
 static u32 intel_data_read(void)
 {
-	assert (rng_mem != NULL);
-
 	return readb (rng_mem + INTEL_RNG_DATA);
 }
 
@@ -495,7 +478,6 @@
 {
 	u32 val;
 
-	assert(geode_rng_base != NULL);
 	val = readl(geode_rng_base + GEODE_RNG_DATA_REG);
 	return val;
 }
@@ -504,7 +486,6 @@
 {
 	u32 val;
 
-	assert(geode_rng_base != NULL);
 	val = readl(geode_rng_base + GEODE_RNG_STATUS_REG);
 	return val;
 }
@@ -605,8 +586,6 @@
 
 	DPRINTK ("ENTER\n");
 
-	assert(rng_ops != NULL);
-
 	rc = rng_ops->init(dev);
 	if (rc)
 		goto err_out;

