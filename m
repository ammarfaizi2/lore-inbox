Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbULMCpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbULMCpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 21:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbULMCpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 21:45:21 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:27910 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262195AbULMCpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 21:45:12 -0500
Date: Mon, 13 Dec 2004 02:45:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-iops: Use platform-dependent port I/O operations
Message-ID: <Pine.LNX.4.58L.0412130227420.8571@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Given the contents of <asm-generic/ide_iops.h> and platform-specific
peculiarities (like address-dependent hardware byte lane swappers), I
believe ide-iops should use __ide_* for port I/O string operations,
similarly to __ide_mm_* that are already used for memory-mapped I/O ones.  

 Please consider.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@mips.com>

patch-mips-2.6.10-rc3-20041212-ide-iops-0
diff -up --recursive --new-file linux-mips-2.6.10-rc3-20041212.macro/drivers/ide/ide-iops.c linux-mips-2.6.10-rc3-20041212/drivers/ide/ide-iops.c
--- linux-mips-2.6.10-rc3-20041212.macro/drivers/ide/ide-iops.c	Tue Nov 16 05:56:44 2004
+++ linux-mips-2.6.10-rc3-20041212/drivers/ide/ide-iops.c	Mon Dec 13 01:33:39 2004
@@ -46,7 +46,7 @@ static u16 ide_inw (unsigned long port)
 
 static void ide_insw (unsigned long port, void *addr, u32 count)
 {
-	insw(port, addr, count);
+	__ide_insw(port, addr, count);
 }
 
 static u32 ide_inl (unsigned long port)
@@ -56,7 +56,7 @@ static u32 ide_inl (unsigned long port)
 
 static void ide_insl (unsigned long port, void *addr, u32 count)
 {
-	insl(port, addr, count);
+	__ide_insl(port, addr, count);
 }
 
 static void ide_outb (u8 val, unsigned long port)
@@ -76,7 +76,7 @@ static void ide_outw (u16 val, unsigned 
 
 static void ide_outsw (unsigned long port, void *addr, u32 count)
 {
-	outsw(port, addr, count);
+	__ide_outsw(port, addr, count);
 }
 
 static void ide_outl (u32 val, unsigned long port)
@@ -86,7 +86,7 @@ static void ide_outl (u32 val, unsigned 
 
 static void ide_outsl (unsigned long port, void *addr, u32 count)
 {
-	outsl(port, addr, count);
+	__ide_outsl(port, addr, count);
 }
 
 void default_hwif_iops (ide_hwif_t *hwif)
