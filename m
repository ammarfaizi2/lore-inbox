Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267940AbTBSDev>; Tue, 18 Feb 2003 22:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTBSDeu>; Tue, 18 Feb 2003 22:34:50 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:20197 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267940AbTBSDee>; Tue, 18 Feb 2003 22:34:34 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Force v850 interrupt vector parts into their correct locations
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030219034427.4B94E3728@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed, 19 Feb 2003 12:44:27 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise a if one them is partially empty, the following input section
can end up in the wrong place.

diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/vmlinux.lds.S linux-2.5.62-uc0/arch/v850/vmlinux.lds.S
--- linux-2.5.62-uc0.orig/arch/v850/vmlinux.lds.S	2003-01-22 10:16:27.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/vmlinux.lds.S	2003-02-19 11:41:13.000000000 +0900
@@ -24,9 +26,12 @@
 	
 /* Interrupt vectors.  */
 #define INTV_CONTENTS							      \
+		. = ALIGN (0x10) ;					      \
 		__intv_start = . ;					      \
 			*(.intv.reset)	/* Reset vector */		      \
+		. = __intv_start + 0x10 ;				      \
 			*(.intv.common)	/* Vectors common to all v850e proc */\
+		. = __intv_start + 0x80 ;				      \
 			*(.intv.mach)	/* Machine-specific int. vectors.  */ \
 		__intv_end = . ;
 
