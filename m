Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbUKPBTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUKPBTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUKPBTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:19:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261749AbUKPBS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:18:57 -0500
Date: Tue, 16 Nov 2004 02:18:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alex Woods <linux-dvb@giblets.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove some unneeded #ifdefs from dvb/ttusb-dec/ttusb_dec.c (fwd)
Message-ID: <20041116011824.GD4946@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies against 2.6.10-rc1-mm5.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Mon, 30 Aug 2004 00:47:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alex Woods <linux-dvb@giblets.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove some unneeded #ifdefs from dvb/ttusb-dec/ttusb_dec.c


DVB_TTUSB_DEC selects CRC32, do the #ifdefs can be removed.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full-3.4/drivers/media/dvb/ttusb-dec/ttusb_dec.c.old	2004-08-29 21:09:21.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-08-29 21:09:57.000000000 +0200
@@ -28,11 +28,7 @@
 #include <linux/usb.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
-#if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
 #include <linux/crc32.h>
-#else
-#warning "CRC checking of firmware not available"
-#endif
 #include <linux/init.h>
 
 #include "dmxdev.h"
@@ -1165,9 +1161,7 @@
 	u16 firmware_csum = 0;
 	u16 firmware_csum_ns;
 	u32 firmware_size_nl;
-#if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
 	u32 crc32_csum, crc32_check, tmp;
-#endif
 	const struct firmware *fw_entry = NULL;
 	dprintk("%s\n", __FUNCTION__);
 
@@ -1189,7 +1183,6 @@
 	/* a 32 bit checksum over the first 56 bytes of the DSP Code is stored
 	   at offset 56 of file, so use it to check if the firmware file is
 	   valid. */
-#if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
 	crc32_csum = crc32(~0L, firmware, 56) ^ ~0L;
 	memcpy(&tmp, &firmware[56], 4);
 	crc32_check = htonl(tmp);
@@ -1199,7 +1192,6 @@
 			__FUNCTION__, crc32_csum, crc32_check);
 		return -1;
 	}
-#endif
 	memcpy(idstring, &firmware[36], 20);
 	idstring[20] = '\0';
 	printk(KERN_INFO "ttusb_dec: found DSP code \"%s\".\n", idstring);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

