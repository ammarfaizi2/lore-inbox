Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSGYN1j>; Thu, 25 Jul 2002 09:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSGYN1j>; Thu, 25 Jul 2002 09:27:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:253 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314284AbSGYN1V>; Thu, 25 Jul 2002 09:27:21 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251444.g6PEiWaw010392@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 fix umem compile
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:44:32 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoever updated it was coding without due care and attention 8)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/block/umem.c linux-2.5.28-ac1/drivers/block/umem.c
--- linux-2.5.28/drivers/block/umem.c	Thu Jul 25 11:09:40 2002
+++ linux-2.5.28-ac1/drivers/block/umem.c	Thu Jul 25 12:04:29 2002
@@ -819,7 +819,7 @@
 static int mm_revalidate(kdev_t i_rdev)
 {
 	int card_number = DEVICE_NR(i_rdev);
-	kdev_t device = mk_mdev(MAJOR_NR, card_number << MM_SHIFT);
+	kdev_t device = mk_kdev(MAJOR_NR, card_number << MM_SHIFT);
 	int res = dev_lock_part(device);
 	if (res < 0)
 		return res;
@@ -862,7 +862,7 @@
 		size = cards[card_number].mm_size * (1024 / MM_HARDSECT);
 		geo.heads     = 64;
 		geo.sectors   = 32;
-		geo.start     = get_start_sect(inode->i_bdev);
+		geo.start     = get_start_sect(i->i_bdev);
 		geo.cylinders = size / (geo.heads * geo.sectors);
 
 		if (copy_to_user((void *) arg, &geo, sizeof(geo)))
