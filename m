Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVILUPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVILUPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVILUPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:15:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:25541 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932202AbVILUPX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:15:23 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] crc16: remove w1 specific comments.
In-Reply-To: <112655586576@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 12 Sep 2005 13:11:05 -0700
Message-Id: <11265558653993@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] crc16: remove w1 specific comments.

Remove w1 comments from crc16.h and move
specific constants into w1_ds2433.c where they are used.
Replace %d with %zd.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 877599fdef5ea4a7dd1956e22fa9d6923add97f8
tree 344fe19205957f6f002a8bcb93022de13754f6dc
parent 8ccc457722ba226ea72fca6f9ba3b54535d4749e
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Mon, 12 Sep 2005 17:12:43 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 12 Sep 2005 12:35:17 -0700

 drivers/w1/w1_ds2433.c |    6 +++++-
 include/linux/crc16.h  |   16 +---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/w1/w1_ds2433.c b/drivers/w1/w1_ds2433.c
--- a/drivers/w1/w1_ds2433.c
+++ b/drivers/w1/w1_ds2433.c
@@ -15,6 +15,10 @@
 #include <linux/delay.h>
 #ifdef CONFIG_W1_F23_CRC
 #include <linux/crc16.h>
+
+#define CRC16_INIT		0
+#define CRC16_VALID		0xb001
+
 #endif
 
 #include "w1.h"
@@ -214,7 +218,7 @@ static ssize_t w1_f23_write_bin(struct k
 #ifdef CONFIG_W1_F23_CRC
 	/* can only write full blocks in cached mode */
 	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
-		dev_err(&sl->dev, "invalid offset/count off=%d cnt=%d\n",
+		dev_err(&sl->dev, "invalid offset/count off=%d cnt=%zd\n",
 			(int)off, count);
 		return -EINVAL;
 	}
diff --git a/include/linux/crc16.h b/include/linux/crc16.h
--- a/include/linux/crc16.h
+++ b/include/linux/crc16.h
@@ -1,22 +1,11 @@
 /*
  *	crc16.h - CRC-16 routine
  *
- * Implements the standard CRC-16, as used with 1-wire devices:
+ * Implements the standard CRC-16:
  *   Width 16
  *   Poly  0x8005 (x^16 + x^15 + x^2 + 1)
  *   Init  0
  *
- * For 1-wire devices, the CRC is stored inverted, LSB-first
- *
- * Example buffer with the CRC attached:
- *   31 32 33 34 35 36 37 38 39 C2 44
- *
- * The CRC over a buffer with the CRC attached is 0xB001.
- * So, if (crc16(0, buf, size) == 0xB001) then the buffer is valid.
- *
- * Refer to "Application Note 937: Book of iButton Standards" for details.
- * http://www.maxim-ic.com/appnotes.cfm/appnote_number/937
- *
  * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
  *
  * This source code is licensed under the GNU General Public License,
@@ -28,9 +17,6 @@
 
 #include <linux/types.h>
 
-#define CRC16_INIT		0
-#define CRC16_VALID		0xb001
-
 extern u16 const crc16_table[256];
 
 extern u16 crc16(u16 crc, const u8 *buffer, size_t len);

