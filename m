Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSFRA4y>; Mon, 17 Jun 2002 20:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSFRA4x>; Mon, 17 Jun 2002 20:56:53 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:45769 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317232AbSFRA4v>;
	Mon, 17 Jun 2002 20:56:51 -0400
Date: Tue, 18 Jun 2002 02:56:52 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206180056.CAA11551@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.22] sound/oss/sb_audio.c copy_from_user buglets
Cc: trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fallout of copy_from_user() cleanups. sb16_copy_from_user()
returns void not int, so it can't return -EFAULT.

/Mikael

--- linux-2.5.22/sound/oss/sb_audio.c.~1~	Wed May 22 14:50:44 2002
+++ linux-2.5.22/sound/oss/sb_audio.c	Tue Jun 18 00:40:08 2002
@@ -851,7 +851,7 @@
 	{
 		if (copy_from_user(localbuf + localoffs,
 				   userbuf + useroffs, len))
-			return -EFAULT;
+			return;
 		*used = len;
 		*returned = len;
 	}
@@ -874,7 +874,7 @@
 			if (copy_from_user(lbuf16,
 					   userbuf + useroffs + (p << 1),
 					   locallen << 1))
-				return -EFAULT;
+				return;
 			for (i = 0; i < locallen; i++)
 			{
 				buf8[p+i] = ~((lbuf16[i] >> 8) & 0xff) ^ 0x80;
@@ -904,7 +904,7 @@
 			if (copy_from_user(lbuf8,
 					   userbuf+useroffs + p,
 					   locallen))
-				return -EFAULT;
+				return;
 			for (i = 0; i < locallen; i++)
 			{
 				buf16[p+i] = (~lbuf8[i] ^ 0x80) << 8;
