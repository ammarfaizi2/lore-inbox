Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbTDAQhx>; Tue, 1 Apr 2003 11:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTDAQhx>; Tue, 1 Apr 2003 11:37:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:30082 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262656AbTDAQhw>;
	Tue, 1 Apr 2003 11:37:52 -0500
Date: Tue, 1 Apr 2003 08:49:18 -0800
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [Trivial 2.5.66] Remove MOD_*_USE_COUNT from floppy driver.
Message-ID: <20030401164918.GA11907@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By registering with genhd the floppy driver no longer needs
to manage its own module use count.


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17



diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Fri Mar 28 10:55:41 2003
+++ b/drivers/block/floppy.c	Fri Mar 28 10:55:41 2003
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
 
 
