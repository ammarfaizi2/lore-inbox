Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbQKFRQO>; Mon, 6 Nov 2000 12:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQKFRQE>; Mon, 6 Nov 2000 12:16:04 -0500
Received: from ns.sysgo.de ([213.68.67.98]:9456 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129381AbQKFRPt>;
	Mon, 6 Nov 2000 12:15:49 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: unresolved reference to hd_init (2.4.0-test10, ll_rw_blk.c)
Date: Mon, 6 Nov 2000 18:09:08 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00110618154301.11022@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just ran into a small problem trying to build the 2.4.0-test10 kernel with
only the "Old hard disk (MFM/RLL/IDE) driver" enabled. The following patch
fixed this for me, (though I'm not sure I haven't broken anything else with it).

diff -ur linux-2.4.0-test10/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.4.0-test10/drivers/block/ll_rw_blk.c	Fri Oct 27 08:35:47 2000
+++ linux/drivers/block/ll_rw_blk.c	Mon Nov  6 17:34:39 2000
@@ -1063,7 +1063,7 @@
 #if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_IDE)
 	ide_init();		/* this MUST precede hd_init */
 #endif
-#if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD)
+#if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD) && !defined(CONFIG_BLK_DEV_HD_ONLY)
 	hd_init();
 #endif
 #ifdef CONFIG_BLK_DEV_PS2


----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
