Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317635AbSGVOK6>; Mon, 22 Jul 2002 10:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317686AbSGVOK6>; Mon, 22 Jul 2002 10:10:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19466 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317635AbSGVOK5>; Mon, 22 Jul 2002 10:10:57 -0400
Message-ID: <3D3C11DE.7010000@evision.ag>
Date: Mon, 22 Jul 2002 16:08:30 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 read_write
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070503070101060006010507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070503070101060006010507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- This is making the read_write.c C.

- It is fixing completely confused wild casting to 32 bits.

- Actually adding a comment explaining the obscure code, which is
   relying on integer arithmetics overflow.

--------------070503070101060006010507
Content-Type: text/plain;
 name="read_write-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="read_write-2.5.27.diff"

diff -urN linux-2.5.27/fs/read_write.c linux/fs/read_write.c
--- linux-2.5.27/fs/read_write.c	2002-07-22 13:08:04.000000000 +0200
+++ linux/fs/read_write.c	2002-07-22 13:44:04.000000000 +0200
@@ -307,11 +307,11 @@
 	ret = -EINVAL;
 	for (i = 0 ; i < count ; i++) {
 		size_t tmp = tot_len;
-		int len = iov[i].iov_len;
-		if (len < 0)
-			goto out;
-		(u32)tot_len += len;
-		if (tot_len < tmp || tot_len < (u32)len)
+		size_t len = iov[i].iov_len;
+
+		tot_len += len;
+		/* check for overflows */
+		if (tot_len < tmp || tot_len < len)
 			goto out;
 	}
 

--------------070503070101060006010507--

