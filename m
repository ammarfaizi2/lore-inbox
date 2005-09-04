Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVIDXa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVIDXa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVIDX34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:29:56 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:23425 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932089AbVIDX3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:29:55 -0400
Message-Id: <20050904232316.585134000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:01 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
Content-Disposition: inline; filename=dvb-remove-version_h_dependencies.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 02/54] remove version.h dependencies
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olh@suse.de>

Remove all #include <linux/version.h> and all references
to LINUX_VERSION_CODE and KERNEL_VERSION. Based on
patch by Olaf Hering.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/common/saa7146_fops.c     |    1 -
 drivers/media/common/saa7146_i2c.c      |    5 -----
 drivers/media/dvb/cinergyT2/cinergyT2.c |    1 -
 drivers/media/dvb/dvb-core/dvb_net.c    |    5 -----
 drivers/media/dvb/frontends/dib3000mb.c |    1 -
 drivers/media/dvb/frontends/dib3000mc.c |    1 -
 drivers/media/dvb/ttusb-dec/ttusb_dec.c |    1 -
 include/media/saa7146.h                 |   13 +------------
 8 files changed, 1 insertion(+), 27 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/common/saa7146_fops.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/common/saa7146_fops.c	2005-09-04 22:43:19.000000000 +0200
@@ -1,5 +1,4 @@
 #include <media/saa7146_vv.h>
-#include <linux/version.h>
 
 #define BOARD_CAN_DO_VBI(dev)   (dev->revision != 0 && dev->vv_data->vbi_minor != -1) 
 
--- linux-2.6.13-git4.orig/drivers/media/common/saa7146_i2c.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/common/saa7146_i2c.c	2005-09-04 22:43:19.000000000 +0200
@@ -1,4 +1,3 @@
-#include <linux/version.h>
 #include <media/saa7146_vv.h>
 
 static u32 saa7146_i2c_func(struct i2c_adapter *adapter)
@@ -404,12 +403,8 @@ int saa7146_i2c_adapter_prepare(struct s
 	saa7146_i2c_reset(dev);
 
 	if( NULL != i2c_adapter ) {
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-		i2c_adapter->data = dev;
-#else
 		BUG_ON(!i2c_adapter->class);
 		i2c_set_adapdata(i2c_adapter,dev);
-#endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id		   = I2C_ALGO_SAA7146;
--- linux-2.6.13-git4.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-09-04 22:43:19.000000000 +0200
@@ -25,7 +25,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/pci.h>
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_net.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_net.c	2005-09-04 22:43:19.000000000 +0200
@@ -62,7 +62,6 @@
 #include <linux/uio.h>
 #include <asm/uaccess.h>
 #include <linux/crc32.h>
-#include <linux/version.h>
 
 #include "dvb_demux.h"
 #include "dvb_net.h"
@@ -171,11 +170,7 @@ static unsigned short dvb_net_eth_type_t
 
 	skb->mac.raw=skb->data;
 	skb_pull(skb,dev->hard_header_len);
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,8)
-	eth = skb->mac.ethernet;
-#else
 	eth = eth_hdr(skb);
-#endif
 
 	if (*eth->h_dest & 1) {
 		if(memcmp(eth->h_dest,dev->broadcast, ETH_ALEN)==0)
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/dib3000mb.c	2005-09-04 22:43:19.000000000 +0200
@@ -23,7 +23,6 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/dib3000mc.c	2005-09-04 22:43:19.000000000 +0200
@@ -22,7 +22,6 @@
  */
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-09-04 22:43:19.000000000 +0200
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
-#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
 #include <linux/crc32.h>
--- linux-2.6.13-git4.orig/include/media/saa7146.h	2005-09-04 22:31:17.000000000 +0200
+++ linux-2.6.13-git4/include/media/saa7146.h	2005-09-04 22:45:22.000000000 +0200
@@ -1,7 +1,6 @@
 #ifndef __SAA7146__
 #define __SAA7146__
 
-#include <linux/version.h>	/* for version macros */
 #include <linux/module.h>	/* for module-version */
 #include <linux/delay.h>	/* for delay-stuff */
 #include <linux/slab.h>		/* for kmalloc/kfree */
@@ -15,12 +14,7 @@
 #include <linux/vmalloc.h>	/* for vmalloc() */
 #include <linux/mm.h>		/* for vmalloc_to_page() */
 
-/* ugly, but necessary to build the dvb stuff under 2.4. */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "dvb_functions.h"
-#endif
-
-#define SAA7146_VERSION_CODE KERNEL_VERSION(0,5,0)
+#define SAA7146_VERSION_CODE 0x000500   /* 0.5.0 */
 
 #define saa7146_write(sxy,adr,dat)    writel((dat),(sxy->mem+(adr)))
 #define saa7146_read(sxy,adr)         readl(sxy->mem+(adr))
@@ -33,13 +27,8 @@ extern unsigned int saa7146_debug;
 	#define DEBUG_VARIABLE saa7146_debug
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-#define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_BASENAME),__FUNCTION__)
-#define INFO(x) { printk("%s: ",__stringify(KBUILD_BASENAME)); printk x; }
-#else
 #define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_MODNAME),__FUNCTION__)
 #define INFO(x) { printk("%s: ",__stringify(KBUILD_MODNAME)); printk x; }
-#endif
 
 #define ERR(x) { DEBUG_PROLOG; printk x; }
 

--

