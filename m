Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUAXIS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 03:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUAXIS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 03:18:56 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:34433 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S264441AbUAXISz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 03:18:55 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.2-rc1-mm2] drivers/usb/storage/dpcm.c
Cc: akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net
Message-Id: <20040124081801.D163013A354@mrhankey.megahappy.net>
Date: Sat, 24 Jan 2004 00:18:01 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix warning for unused var "ret".

--- drivers/usb/storage/dpcm.c.orig     2004-01-24 00:05:42.092064312 -0800
+++ drivers/usb/storage/dpcm.c  2004-01-24 00:07:06.262268496 -0800
@@ -56,7 +56,8 @@
     /*
      * LUN 0 corresponds to the CompactFlash card reader.
      */
-    return usb_stor_CB_transport(srb, us);
+    ret = usb_stor_CB_transport(srb, us);
+    break;
  
 #ifdef CONFIG_USB_STORAGE_SDDR09
   case 1:
@@ -72,11 +73,13 @@
     ret = sddr09_transport(srb, us);
     srb->device->lun = 1; us->srb->device->lun = 1;
  
-    return ret;
+    break;
 #endif
  
   default:
     US_DEBUGP("dpcm_transport: Invalid LUN %d\n", srb->device->lun);
-    return USB_STOR_TRANSPORT_ERROR;
+    ret = USB_STOR_TRANSPORT_ERROR;
+    break;
   }
+  return ret;
 }


--
Bryan Whitehead
driver@megahappy.net
