Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUBIQkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUBIQkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:40:41 -0500
Received: from mail.timesys.com ([65.117.135.102]:14715 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S265253AbUBIQkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:40:37 -0500
Message-ID: <4027B7D3.2020107@timesys.com>
Date: Mon, 09 Feb 2004 11:39:47 -0500
From: Pratik Solanki <pratik.solanki@timesys.com>
Organization: TimeSys Corporation
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Minor cross-compile issues
Content-Type: multipart/mixed;
 boundary="------------060205020302080404050200"
X-OriginalArrivalTime: 09 Feb 2004 16:34:07.0578 (UTC) FILETIME=[89C85BA0:01C3EF2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205020302080404050200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached are 2 patches

asm-boot.patch - Fixes include path for build.c so that it finds 
asm/boot.h. /usr/include/asm/boot.h may not be present when 
cross-compiling on a non-Linux machine.

shell.patch - Use $(CONFIG_SHELL) instead of sh.

Pratik.

--------------060205020302080404050200
Content-Type: text/plain;
 name="asm-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asm-boot.patch"

===== arch/i386/boot/Makefile 1.28 vs edited =====
--- 1.28/arch/i386/boot/Makefile	Thu Sep 11 06:01:23 2003
+++ edited/arch/i386/boot/Makefile	Thu Feb  5 15:56:28 2004
@@ -31,6 +31,8 @@
 
 host-progs	:= tools/build
 
+HOSTCFLAGS_build.o := -I$(TOPDIR)/include
+
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000

--------------060205020302080404050200
Content-Type: text/plain;
 name="shell.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shell.patch"

===== init/Makefile 1.26 vs edited =====
--- 1.26/init/Makefile	Sat Apr 26 14:43:03 2003
+++ edited/init/Makefile	Thu Feb  5 15:43:29 2004
@@ -23,4 +23,4 @@
 
 include/linux/compile.h: FORCE
 	@echo '  CHK     $@'
-	@sh $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
+	@$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"

--------------060205020302080404050200--
