Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVAYGbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVAYGbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVAYGbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:31:18 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:6599 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261835AbVAYGbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:31:07 -0500
Date: Mon, 24 Jan 2005 22:31:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial fix for i386 cross compile
Message-ID: <20050125063110.GA22266@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I used to be be able to cross compile for i386 on my x86_64 machine,
but recently something (gcc/binutils?) changed, and it stopped working.

Following patch makes cross compile work with:

make ARCH=i386 CFLAGS_KERNEL="-m32" AFLAGS_KERNEL="-m32" bzImage

Without the patch I'm getting the following error:

  SYSCALL arch/i386/kernel/vsyscall-syms.o
/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.3/../../../../x86_64-pc-linux-gnu/bin/ld:
Relocatable linking with relocations from format elf32-i386
(arch/i386/kernel/vsyscall-sysenter.o) to format elf64-x86-64
(arch/i386/kernel/vsyscall-syms.o) is not supported
collect2: ld returned 1 exit status

Regards,

Tony


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-cross-compile-i386

--- a/arch/i386/kernel/Makefile	2004-10-28 00:39:50 -07:00
+++ b/arch/i386/kernel/Makefile	2005-01-22 22:57:49 -08:00
@@ -46,7 +46,7 @@
 
 # The DSO images are built using a special linker script.
 quiet_cmd_syscall = SYSCALL $@
-      cmd_syscall = $(CC) -nostdlib $(SYSCFLAGS_$(@F)) \
+      cmd_syscall = $(CC) -m elf_i386 -nostdlib $(SYSCFLAGS_$(@F)) \
 		          -Wl,-T,$(filter-out FORCE,$^) -o $@
 
 export CPPFLAGS_vsyscall.lds += -P -C -U$(ARCH)

--9jxsPFA5p3P2qPhR--
