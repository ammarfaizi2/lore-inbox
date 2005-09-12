Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVILNNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVILNNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVILNNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:13:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:45739 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750810AbVILNNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:13:10 -0400
Date: Mon, 12 Sep 2005 17:12:43 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [1/1] crc16: remove w1 specific comments.
Message-ID: <20050912131242.GA19896@2ka.mipt.ru>
References: <20050908222105.GA6633@kroah.com> <1126222209.5286.74.camel@blade> <20050909033036.GB11369@suse.de> <20050909050825.GA16668@2ka.mipt.ru> <20050909211619.GA28696@kroah.com> <20050909215814.GA6022@2ka.mipt.ru> <20050909221158.GA30321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20050909221158.GA30321@kroah.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 12 Sep 2005 17:12:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove w1 comments from crc16.h and move 
specific constants into w1_ds2433.c where they are used.
Replace %d with %zd.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

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

-- 
	Evgeniy Polyakov
