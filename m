Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274427AbRITLfZ>; Thu, 20 Sep 2001 07:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274330AbRITLfP>; Thu, 20 Sep 2001 07:35:15 -0400
Received: from CPE-61-9-150-168.vic.bigpond.net.au ([61.9.150.168]:2432 "EHLO
	wagner") by vger.kernel.org with ESMTP id <S274428AbRITLfH>;
	Thu, 20 Sep 2001 07:35:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 vsnprintf fix.
Date: Thu, 20 Sep 2001 21:29:05 +1000
Message-Id: <E15k20v-00008w-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch fixes calling vsnprintf with (NULL, 0) to get the
length of the string.  The problem is that the end ptr is set to
0xFFFFFFFF in this case, causing a write into address 0 as start <
end.

Cheers,
Rusty. 
--
Premature optmztion is rt of all evl. --DK

--- working-pmac-module/lib/vsprintf.c.~1~	Mon Sep 17 08:53:56 2001
+++ working-pmac-module/lib/vsprintf.c	Thu Sep 20 21:26:05 2001
@@ -246,6 +246,8 @@
 				/* 'z' support added 23/7/1999 S.H.    */
 				/* 'z' changed to 'Z' --davidm 1/25/99 */
 
+	/* buf = NULL, size = 0 is common for getting length */
+	if (size == 0) buf = (void *)1;
 	str = buf;
 	end = buf + size - 1;
