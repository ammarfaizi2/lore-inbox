Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUJQS4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUJQS4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUJQS4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:56:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:32432 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268253AbUJQSz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:55:59 -0400
Date: Sun, 17 Oct 2004 20:55:57 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc64-dev@ozlabs.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] allow kernel compile with native ppc64 compiler
Message-ID: <20041017185557.GA9619@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The zImage is a 32bit binary, but a native powerpc64-linux gcc will
produce 64bit objects in arch/ppc64/boot.
This patch fixes it.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.9-final/arch/ppc64/boot/Makefile linux-2.6.9-final.native/arch/ppc64/boot/Makefile
--- linux-2.6.9-final/arch/ppc64/boot/Makefile	2004-10-16 03:03:50.000000000 +0000
+++ linux-2.6.9-final.native/arch/ppc64/boot/Makefile	2004-10-17 18:44:33.229249956 +0000
@@ -23,14 +23,14 @@
 CROSS32_COMPILE ?=
 #CROSS32_COMPILE = /usr/local/ppc/bin/powerpc-linux-
 
-BOOTCC		:= $(CROSS32_COMPILE)gcc
+BOOTCC		:= $(CROSS32_COMPILE)gcc -m32
 HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) $(LINUXINCLUDE) -fno-builtin 
-BOOTAS		:= $(CROSS32_COMPILE)as
+BOOTAS		:= $(CROSS32_COMPILE)as -a32
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional
-BOOTLD		:= $(CROSS32_COMPILE)ld
+BOOTLD		:= $(CROSS32_COMPILE)ld -m elf32ppc
 BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
-BOOTOBJCOPY	:= $(CROSS32_COMPILE)objcopy
+BOOTOBJCOPY	:= $(CROSS32_COMPILE)objcopy --target elf32-powerpc
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
 
 src-boot := crt0.S string.S prom.c main.c zlib.c imagesize.c div64.S
diff -purN linux-2.6.9-final/arch/ppc64/boot/zImage.lds linux-2.6.9-final.native/arch/ppc64/boot/zImage.lds
--- linux-2.6.9-final/arch/ppc64/boot/zImage.lds	2004-10-16 03:01:55.000000000 +0000
+++ linux-2.6.9-final.native/arch/ppc64/boot/zImage.lds	2004-10-17 18:48:14.824288338 +0000
@@ -1,4 +1,4 @@
-OUTPUT_ARCH(powerpc)
+OUTPUT_ARCH(powerpc:common)
 SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
 /* Do we need any of these for elf?
    __DYNAMIC = 0;    */
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
