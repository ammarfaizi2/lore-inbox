Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbSJHS7t>; Tue, 8 Oct 2002 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSJHS6s>; Tue, 8 Oct 2002 14:58:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14096 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262602AbSJHS6l>; Tue, 8 Oct 2002 14:58:41 -0400
Subject: PATCH: (forwarded) fix atm errors with gcc 3.2
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:55:50 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzWI-0004rd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/atm/firestream.c linux.2.5.41-ac1/drivers/atm/firestream.c
--- linux.2.5.41/drivers/atm/firestream.c	2002-10-02 21:33:21.000000000 +0100
+++ linux.2.5.41-ac1/drivers/atm/firestream.c	2002-10-03 13:45:25.000000000 +0100
@@ -330,8 +330,8 @@
 #define FS_DEBUG_QSIZE   0x00001000
 
 
-#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " __FUNCTION__ "\n")
-#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  " __FUNCTION__ "\n")
+#define func_enter() fs_dprintk(FS_DEBUG_FLOW, "fs: enter %s\n", __FUNCTION__ )
+#define func_exit()  fs_dprintk(FS_DEBUG_FLOW, "fs: exit %s\n", __FUNCTION__ )
 
 
 struct fs_dev *fs_boards = NULL;
@@ -814,7 +814,7 @@
 				skb_put (skb, qe->p1 & 0xffff); 
 				ATM_SKB(skb)->vcc = atm_vcc;
 				atomic_inc(&atm_vcc->stats->rx);
-				skb->stamp = xtime;
+				do_gettimeofday(&skb->stamp);
 				fs_dprintk (FS_DEBUG_ALLOC, "Free rec-skb: %p (pushed)\n", skb);
 				atm_vcc->push (atm_vcc, skb);
 				fs_dprintk (FS_DEBUG_ALLOC, "Free rec-d: %p\n", pe);
