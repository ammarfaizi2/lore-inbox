Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTDGWxz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTDGWxq (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:53:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44928
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263777AbTDGWw7 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:52:59 -0400
Date: Tue, 8 Apr 2003 01:11:51 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080011.h380Bpx8008975@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: MOD_* can go for floppy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Bob Miller)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/block/floppy.c linux-2.5.67-ac1/drivers/block/floppy.c
--- linux-2.5.67/drivers/block/floppy.c	2003-03-26 19:59:50.000000000 +0000
+++ linux-2.5.67-ac1/drivers/block/floppy.c	2003-04-03 23:36:23.000000000 +0100
@@ -4396,11 +4396,9 @@
 		return 0;
 	}
 	spin_unlock_irqrestore(&floppy_usage_lock, flags);
-	MOD_INC_USE_COUNT;
 	if (fd_request_irq()) {
 		DPRINT("Unable to grab IRQ%d for the floppy driver\n",
 			FLOPPY_IRQ);
-		MOD_DEC_USE_COUNT;
 		spin_lock_irqsave(&floppy_usage_lock, flags);
 		usage_count--;
 		spin_unlock_irqrestore(&floppy_usage_lock, flags);
@@ -4410,7 +4408,6 @@
 		DPRINT("Unable to grab DMA%d for the floppy driver\n",
 			FLOPPY_DMA);
 		fd_free_irq();
-		MOD_DEC_USE_COUNT;
 		spin_lock_irqsave(&floppy_usage_lock, flags);
 		usage_count--;
 		spin_unlock_irqrestore(&floppy_usage_lock, flags);
@@ -4459,7 +4456,6 @@
 		release_region(FDCS->address + 2, 4);
 		release_region(FDCS->address + 7, 1);
 	}
-	MOD_DEC_USE_COUNT;
 	spin_lock_irqsave(&floppy_usage_lock, flags);
 	usage_count--;
 	spin_unlock_irqrestore(&floppy_usage_lock, flags);
@@ -4527,7 +4523,6 @@
 			release_region(FDCS->address+7, 1);
 		}
 	fdc = old_fdc;
-	MOD_DEC_USE_COUNT;
 }
 
 
