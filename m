Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUI1Sj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUI1Sj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 14:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUI1Sj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 14:39:29 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:7340 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268028AbUI1Sj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 14:39:27 -0400
To: akpm@osdl.org, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Tue, 28 Sep 2004 11:39:25 -0700
Message-ID: <52is9yb5lu.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] Fix ppc64 cross-compilation
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Sep 2004 18:39:26.0494 (UTC) FILETIME=[7B3DE3E0:01C4A58A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the "ppc64 monster cleanup," I get

    powerpc-750-linux-gnu-strip: vmlinux: File format not recognized

from my ppc32 strip command when cross-compiling a ppc64 kernel, since
vmlinux is a 64-bit ELF file.  This patch fixes my build (and the
resulting kernel boots fine).

Thanks,
  Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/arch/ppc64/boot/Makefile
===================================================================
--- linux-bk.orig/arch/ppc64/boot/Makefile	2004-09-28 11:22:48.000000000 -0700
+++ linux-bk/arch/ppc64/boot/Makefile	2004-09-28 11:23:07.000000000 -0700
@@ -31,7 +31,7 @@
 BOOTLD		:= $(CROSS32_COMPILE)ld
 BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
 BOOTOBJCOPY	:= $(CROSS32_COMPILE)objcopy
-BOOTSTRIP	:= $(CROSS32_COMPILE)strip
+BOOTSTRIP	:= $(CROSS_COMPILE)strip
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
 
 src-boot := crt0.S string.S prom.c main.c zlib.c imagesize.c div64.S
