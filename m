Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSKZC0d>; Mon, 25 Nov 2002 21:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266053AbSKZC0d>; Mon, 25 Nov 2002 21:26:33 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:10945 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266043AbSKZC0c>; Mon, 25 Nov 2002 21:26:32 -0500
Date: Mon, 25 Nov 2002 21:26:39 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.49-ac1 : include/asm-386/io_apic.h
Message-ID: <Pine.LNX.4.44.0211252113260.1597-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch seems to fix the 'apic_sis_bug undeclared' error 
within include/asm-i386/io_apic.h . (I'm still compiling 
2.5.49-ac1). sis_apic_bug is defined in 
arch/i386/kernel/io_apic.c . Please review.

Regards,
Frank

--- linux/include/asm-i386/io_apic.h.old	Mon Nov 25 21:24:21 2002
+++ linux/include/asm-i386/io_apic.h	Mon Nov 25 21:22:17 2002
@@ -10,6 +10,7 @@
  *
  * Copyright (C) 1997, 1998, 1999, 2000 Ingo Molnar
  */
+extern int sis_apic_bug;
 
 #ifdef CONFIG_X86_IO_APIC
 
@@ -125,7 +126,7 @@
  */
 static inline void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int value)
 {
-	if(apic_sis_bug)
+	if(sis_apic_bug)
 		*IO_APIC_BASE(apic) = reg;
 	*(IO_APIC_BASE(apic)+4) = value;
 }

