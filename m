Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVHNBZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVHNBZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 21:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVHNBZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 21:25:08 -0400
Received: from itapoa.terra.com.br ([200.176.10.194]:29842 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP
	id S1751369AbVHNBZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 21:25:07 -0400
X-Terra-Karma: -2%
X-Terra-Hash: 34ea2582f34bb80fe882ba9ec6ec592e
Message-ID: <42FE9C7A.8000509@terra.com.br>
Date: Sat, 13 Aug 2005 22:20:58 -0300
From: Piter PUNK <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problems with ABNT2 USB keyboards
Content-Type: multipart/mixed;
 boundary="------------090909080000060501000208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090909080000060501000208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

	I got problems trying to use ABNT2 USB keyboards with the
"." key in numeric keypad. The problem only appears in USB
keyboards (not in PS/2) and in 2.4 series (not in 2.6).

	The solution is very simple, and only need to change one line
and add other in pc_keyb.c. And, in my tests, don't affect any other
keyboards.

						Thanks a lot,

							Piter PUNK

--------------090909080000060501000208
Content-Type: text/plain;
 name="dot_in_ABNT2_keyboard.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dot_in_ABNT2_keyboard.patch"

--- linux/drivers/char/pc_keyb.c	2005-07-26 21:16:40.000000000 -0300
+++ linux-my/drivers/char/pc_keyb.c	2005-07-26 21:16:33.000000000 -0300
@@ -231,6 +231,12 @@
 #define E0_MSLW	125
 #define E0_MSRW	126
 #define E0_MSTM	127
+/* piterpk@terra.com.br:
+ * Brazilian ABNT2 had 18 keys in numeric keypad
+ * instead 17 in other keyboards. The 18th key is
+ * a "."
+ */
+#define E0_KPPT 121
 
 static unsigned char e0_keys[128] = {
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
@@ -247,7 +253,7 @@
   0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, 0,	      /* 0x58-0x5f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x60-0x67 */
   0, 0, 0, 0, 0, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x70-0x77 */
+  0, 0, 0, 0, 0, E0_KPPT, 0, 0,			      /* 0x70-0x77 */
   0, 0, 0, 0, 0, 0, 0, 0			      /* 0x78-0x7f */
 };
 

--------------090909080000060501000208--
