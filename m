Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbSJFRN0>; Sun, 6 Oct 2002 13:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSJFRMC>; Sun, 6 Oct 2002 13:12:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48388 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261710AbSJFRLr>; Sun, 6 Oct 2002 13:11:47 -0400
Subject: PATCH: 2.5.40 flush the right thing in the rd cache
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:08:45 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEtZ-0001rl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(From Matthew Wilcox)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/block/rd.c linux.2.5.40-ac5/drivers/block/rd.c
--- linux.2.5.40/drivers/block/rd.c	2002-10-02 21:34:05.000000000 +0100
+++ linux.2.5.40-ac5/drivers/block/rd.c	2002-10-03 00:17:22.000000000 +0100
@@ -213,7 +213,7 @@
 		kunmap(vec->bv_page);
 
 		if (rw == READ) {
-			flush_dcache_page(page);
+			flush_dcache_page(sbh->b_page);
 		} else {
 			SetPageDirty(page);
 		}
