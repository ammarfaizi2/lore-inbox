Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSLFJ17>; Fri, 6 Dec 2002 04:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSLFJ16>; Fri, 6 Dec 2002 04:27:58 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:961 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262394AbSLFJ0t>; Fri, 6 Dec 2002 04:26:49 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Make `hash_long' function work if bits parameter is 0.
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021206093351.9413736F6@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri,  6 Dec 2002 18:33:51 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the bits parameter of hash_long (in <linux/hash.h>) is 0, then it
ends up right-shifting by BITS_PER_LONG, which is undefined in C (and
often is a nop).

This patch just handles that case explicitly.

diff -ruN -X../cludes ../orig/linux-2.5.50-uc0/include/linux/hash.h include/linux/hash.h
--- ../orig/linux-2.5.50-uc0/include/linux/hash.h	2002-09-18 09:59:18.000000000 +0900
+++ include/linux/hash.h	2002-12-06 13:22:00.000000000 +0900
@@ -27,6 +27,9 @@
 {
 	unsigned long hash = val;
 
+	if (bits == 0)
+		return 0;
+
 #if BITS_PER_LONG == 64
 	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
 	unsigned long n = hash;
