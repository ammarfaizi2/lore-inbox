Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316859AbSEVFMU>; Wed, 22 May 2002 01:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSEVFMT>; Wed, 22 May 2002 01:12:19 -0400
Received: from mail019.syd.optusnet.com.au ([210.49.20.160]:46509 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S316859AbSEVFMR>; Wed, 22 May 2002 01:12:17 -0400
Date: Wed, 22 May 2002 15:15:10 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Initialisation bug in IDE patch
Message-ID: <20020522151510.A2437@kira.glasswings.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest available kernel 2.2 IDE patch "ide-2.2.20.01102002.patch"
there is a bug that prevents ide_setup in drivers/block/ide.c
from accepting kernel parameters selecting special IDE hardware.

The ide_init_default_hwifs() function in include/asm-*/ide.h fails to
initialise the "hw_regs_t hw" variable, thus leaving uninitialised data
in some fields.  Specifically, the "chipset" field is uninitialised which
causes the "if (hwif->chipset != ide_unknown)" test in drivers/block/ide.c
to always fail with the error message " -- BAD OPTION".

Cheers,
	Andrew Pam

Patch follows:

diff -Nurd linux-2.2.20+ide-orig/include/asm-alpha/ide.h linux-2.2.20+ide/include/asm-alpha/ide.h
--- linux-2.2.20+ide-orig/include/asm-alpha/ide.h	Wed May 22 14:35:58 2002
+++ linux-2.2.20+ide/include/asm-alpha/ide.h	Wed May 22 14:47:15 2002
@@ -74,6 +74,11 @@
 	hw_regs_t hw;
 	int index;
 
+	/*
+	 * Initialise before use!
+	 * memset added 2002/05/22 by Andrew Pam <xanni@sericyb.com.au>
+	 */
+	memset(&hw, 0, sizeof(hw_regs_t));
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
diff -Nurd linux-2.2.20+ide-orig/include/asm-i386/ide.h linux-2.2.20+ide/include/asm-i386/ide.h
--- linux-2.2.20+ide-orig/include/asm-i386/ide.h	Wed May 22 14:35:59 2002
+++ linux-2.2.20+ide/include/asm-i386/ide.h	Wed May 22 14:46:49 2002
@@ -77,6 +77,11 @@
 	hw_regs_t hw;
 	int index;
 
+	/*
+	 * Initialise before use!
+	 * memset added 2002/05/22 by Andrew Pam <xanni@sericyb.com.au>
+	 */
+	memset(&hw, 0, sizeof(hw_regs_t));
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
diff -Nurd linux-2.2.20+ide-orig/include/asm-mips/ide.h linux-2.2.20+ide/include/asm-mips/ide.h
--- linux-2.2.20+ide-orig/include/asm-mips/ide.h	Wed May 22 14:36:00 2002
+++ linux-2.2.20+ide/include/asm-mips/ide.h	Wed May 22 14:48:54 2002
@@ -70,6 +70,11 @@
 	hw_regs_t hw;
 	int index;
 
+	/*
+	 * Initialise before use!
+	 * memset added 2002/05/22 by Andrew Pam <xanni@sericyb.com.au>
+	 */
+	memset(&hw, 0, sizeof(hw_regs_t));
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, 0);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
diff -Nurd linux-2.2.20+ide-orig/include/asm-ppc/ide.h linux-2.2.20+ide/include/asm-ppc/ide.h
--- linux-2.2.20+ide-orig/include/asm-ppc/ide.h	Wed May 22 14:36:00 2002
+++ linux-2.2.20+ide/include/asm-ppc/ide.h	Wed May 22 14:49:10 2002
@@ -89,6 +89,11 @@
 	hw_regs_t hw;
 	int index;
 
+	/*
+	 * Initialise before use!
+	 * memset added 2002/05/22 by Andrew Pam <xanni@sericyb.com.au>
+	 */
+	memset(&hw, 0, sizeof(hw_regs_t));
 	for(index = 0; index < MAX_HWIFS; index++) {
 		base = ide_default_io_base(index);
 		if (base == 0)
diff -Nurd linux-2.2.20+ide-orig/include/asm-sparc64/ide.h linux-2.2.20+ide/include/asm-sparc64/ide.h
--- linux-2.2.20+ide-orig/include/asm-sparc64/ide.h	Wed May 22 14:36:00 2002
+++ linux-2.2.20+ide/include/asm-sparc64/ide.h	Wed May 22 14:49:14 2002
@@ -57,6 +57,11 @@
 	hw_regs_t hw;
 	int index;
 
+	/*
+	 * Initialise before use!
+	 * memset added 2002/05/22 by Andrew Pam <xanni@sericyb.com.au>
+	 */
+	memset(&hw, 0, sizeof(hw_regs_t));
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, 0);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
