Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbSI2TqW>; Sun, 29 Sep 2002 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSI2TqW>; Sun, 29 Sep 2002 15:46:22 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:1553 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261756AbSI2TqS>; Sun, 29 Sep 2002 15:46:18 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] use fff/ffff/fffffff instead of ff8/fff8/ffffff8 for EOF of FAT
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 30 Sep 2002 04:51:35 +0900
Message-ID: <87vg4ok20o.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For example on FAT12, the current FAT driver recognize 0xff8-0xfff as
EOF, and it writes in 0xff8 as EOF. This is right behavior. However,
the firmware of some MP3-Players recognize only 0xfff(standard EOF
which Micorsoft uses) as EOF.

So, we write 0xfff instead of 0xff8 as EOF, until the reason we need
values other than standard EOF is found.

[Randy Dunlap, I appreciate your help.]

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5/include/linux/msdos_fs.h~	2002-09-29 16:46:46.000000000 +0900
+++ linux-2.5/include/linux/msdos_fs.h	2002-09-29 16:47:04.000000000 +0900
@@ -68,9 +68,9 @@
 	MSDOS_SB(s)->fat_bits == 16 ? BAD_FAT16 : BAD_FAT12)
 
 /* standard EOF */
-#define EOF_FAT12 0xFF8
-#define EOF_FAT16 0xFFF8
-#define EOF_FAT32 0xFFFFFF8
+#define EOF_FAT12 0xFFF
+#define EOF_FAT16 0xFFFF
+#define EOF_FAT32 0xFFFFFFF
 #define EOF_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? EOF_FAT32 : \
 	MSDOS_SB(s)->fat_bits == 16 ? EOF_FAT16 : EOF_FAT12)
 
