Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUJIT7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUJIT7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUJIT7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:59:38 -0400
Received: from [145.85.127.2] ([145.85.127.2]:28387 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267341AbUJIT7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:59:35 -0400
Message-ID: <59743.217.121.83.210.1097351968.squirrel@217.121.83.210>
Date: Sat, 9 Oct 2004 21:59:28 +0200 (CEST)
Subject: [Patch 2/5] xbox: disable optimization for kernel decompressor
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using the kernel decompressor on a Microsoft Xbox, the system hangs
because of invalid paging requests. When compiling the decompressor with
-O0, we can safely avoid this problem.

You can also download this patch at:
http://linux.g-rave.nl/patches/patch-xbox-optimization.diff
---

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+)

diff -u -r --new-file linux-2.6.9-rc3/arch/i386/boot/compressed/Makefile
linux-2.6.9-rc3-ed0/arch/i386/boot/compressed/Makefile
--- linux-2.6.9-rc3/arch/i386/boot/compressed/Makefile	2004-09-30
05:05:20.000000000 +0200
+++ linux-2.6.9-rc3-ed0/arch/i386/boot/compressed/Makefile	2004-10-09
19:38:25.084610000 +0200
@@ -7,6 +7,13 @@
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional

+# Microsoft Xbox workaround:
+# Xbox v1.1+ crashes while decompressing the kernel when paging is off.
+# By disabling optimization we can fix this.
+ifeq ($(CONFIG_X86_XBOX),y)
+	CFLAGS_misc.o  := -O0
+endif
+
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32

 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
