Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262261AbSJGAEw>; Sun, 6 Oct 2002 20:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJGAEw>; Sun, 6 Oct 2002 20:04:52 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:521 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S262261AbSJGAEv>;
	Sun, 6 Oct 2002 20:04:51 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.40 (-ac5) - fix unresolved symbols
Date: Sun, 6 Oct 2002 21:10:27 -0300
X-Mailer: KMail [version 1.4]
References: <200210021902.35813.carlos@techlinux.com.br> <07ea01c26c2b$7e1e6570$41368490@archaic>
In-Reply-To: <07ea01c26c2b$7e1e6570$41368490@archaic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210062110.27684.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -ur --exclude=*.o --exclude=.*.cmd --exclude=*~ linux-2.5.40-ac5/drivers/cdrom/mcdx.c linux-2.5/drivers/cdrom/mcdx.c
--- linux-2.5.40-ac5/drivers/cdrom/mcdx.c	Tue Oct  1 04:06:59 2002
+++ linux-2.5/drivers/cdrom/mcdx.c	Sun Oct  6 19:42:33 2002
@@ -1040,7 +1040,7 @@
 		kfree(stuffp);
 	}
 
-	if (devfs_unregister_blkdev(MAJOR_NR, "mcdx") != 0) {
+	if (unregister_blkdev(MAJOR_NR, "mcdx") != 0) {
 		xwarn("cleanup() unregister_blkdev() failed\n");
 	}
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
diff -ur --exclude=*.o --exclude=.*.cmd --exclude=*~ linux-2.5.40-ac5/drivers/ieee1394/raw1394.c linux-2.5/drivers/ieee1394/raw1394.c
--- linux-2.5.40-ac5/drivers/ieee1394/raw1394.c	Tue Oct  1 04:05:48 2002
+++ linux-2.5/drivers/ieee1394/raw1394.c	Sun Oct  6 20:55:57 2002
@@ -743,7 +743,7 @@
         }
 
         req->tq.data = req;
-        queue_task(&req->tq, &packet->complete_tq);
+        schedule_task(&req->tq);
 
         spin_lock_irq(&fi->reqlists_lock);
         list_add_tail(&req->list, &fi->req_pending);
@@ -786,7 +786,7 @@
         req->tq.data = req;
         req->tq.routine = (void (*)(void*))queue_complete_req;
         req->req.length = 0;
-        queue_task(&req->tq, &packet->complete_tq);
+        schedule_task(&req->tq);
 
         spin_lock_irq(&fi->reqlists_lock);
         list_add_tail(&req->list, &fi->req_pending);
--

http://www.techlinux.com.br/~carlos/tmp/2.5.40-2.diff
-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


