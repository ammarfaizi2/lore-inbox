Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTEFQ0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTEFQZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:25:56 -0400
Received: from mail.convergence.de ([212.84.236.4]:9929 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263945AbTEFQOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:14:02 -0400
Message-ID: <3EB7E18B.5080701@convergence.de>
Date: Tue, 06 May 2003 18:23:39 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][10-11] update analog saa7146 drivers mxb and dpc7146
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050107090509070303030205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050107090509070303030205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch updates the mxb and dpc7146 drivers.

- add MODULE_DEVICE_TABLE entries, so that /sbin/hotplug can handle the 
devices
- fixup due to the latest i2c changes

Please apply.

Thanks
Michael Hunold.












--------------050107090509070303030205
Content-Type: text/plain;
 name="10-saa7146-analog-video-drivers-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10-saa7146-analog-video-drivers-update.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/video/dpc7146.c linux-2.5.69.patch/drivers/media/video/dpc7146.c
--- linux-2.5.69/drivers/media/video/dpc7146.c	2003-05-06 13:15:34.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/video/dpc7146.c	2003-04-22 18:30:31.000000000 +0200
@@ -23,10 +23,6 @@
 #include <media/saa7146_vv.h>
 #include <linux/video_decoder.h>	/* for saa7111a */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME dpc7146
-#endif
-
 #define I2C_SAA7111A            0x24
 
 /* All unused bytes are reserverd. */
@@ -340,6 +336,8 @@
 	}
 };
 
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
 static
 struct saa7146_ext_vv vv_data = {
 	.inputs		= DPC_INPUTS,
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/video/mxb.c linux-2.5.69.patch/drivers/media/video/mxb.c
--- linux-2.5.69/drivers/media/video/mxb.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/video/mxb.c	2003-04-28 19:44:54.000000000 +0200
@@ -26,10 +26,6 @@
 #include <media/saa7146_vv.h>
 #include <linux/video_decoder.h>	/* for saa7111a */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME mxb
-#endif
-
 #include "mxb.h"
 #include "tea6415c.h"
 #include "tea6420.h"
@@ -436,10 +432,11 @@
 		   polling method ... */
 		extension.flags &= ~SAA7146_USE_I2C_IRQ;
 		for(i = 1;;i++) {
-			msg.len = mxb_saa7740_init[i].length;		
-			if (msg.len == -1U) {
+			if( -1 == mxb_saa7740_init[i].length ) {
 				break;
 			}
+
+			msg.len = mxb_saa7740_init[i].length;		
 			msg.buf = &mxb_saa7740_init[i].data[0];
 			if( 1 != (err = i2c_transfer(&mxb->i2c_adapter, &msg, 1))) {
 				DEB_D(("failed to initialize 'sound arena module'.\n"));

--------------050107090509070303030205--


