Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316370AbSETU4H>; Mon, 20 May 2002 16:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316371AbSETU4G>; Mon, 20 May 2002 16:56:06 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:28944 "HELO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S316369AbSETU4E>; Mon, 20 May 2002 16:56:04 -0400
Date: Mon, 20 May 2002 22:56:04 +0200 (CEST)
From: Martin Decky <deckm1am@ss1000.ms.mff.cuni.cz>
X-X-Sender: <deckm1am@u-pl3>
To: <linux-kernel@vger.kernel.org>
Cc: <martin@decky.cz>
Subject: [PATCH] 2.4.19-pre8 include/asm-i386/bitops.h ffs() bug
Message-ID: <Pine.LNX.4.33.0205202249280.11776-100000@u-pl3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

asm-i386/bitops.h contains assembler definition of ffs() (find first bit
set), which has wrong operand declaration. The instruction "bsfl" accepts
only memory or register as its first operand, not a direct value.

The bug has stayed unnoticed in the kernel for many months. It expressed
on my system while compiling Gentoo's 2.4.19-r1 patched kernel with XFS
included and using GCC 3.1.


--- bitops.h	2001-11-22 20:46:18.000000000 +0100
+++ bitops.h.working	2002-05-20 22:42:45.000000000 +0200
@@ -347,7 +347,7 @@
 	__asm__("bsfl %1,%0\n\t"
 		"jnz 1f\n\t"
 		"movl $-1,%0\n"
-		"1:" : "=r" (r) : "g" (x));
+		"1:" : "=r" (r) : "rm" (x));
 	return r+1;
 }


-- 

    ------------------------------------------------------------------
    Martin Decky
     Faculty of Mathematics and Physics,
     Charles University in Prague,
     Czech Republic

    deckm1am@ss1000.ms.mff.cuni.cz                     martin@decky.cz
    http://www.ms.mff.cuni.cz/~deckm1am/           http://www.decky.cz
    ------------------------------------------------------------------

