Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270366AbUJTCJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270366AbUJTCJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUJTCF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:05:59 -0400
Received: from pxy6allmi.all.mi.charter.com ([24.247.15.57]:53671 "EHLO
	proxy6-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S270288AbUJTCBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:01:36 -0400
Message-ID: <4175C6E2.1080201@quark.didntduck.org>
Date: Tue, 19 Oct 2004 22:01:06 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove last reference to LDFLAGS_BLOB
Content-Type: multipart/mixed;
 boundary="------------080005050008020202060506"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005050008020202060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nothing uses LDFLAGS_BLOB anymore, now that the arm binutils are fixed.

--
				Brian Gerst

--------------080005050008020202060506
Content-Type: text/plain;
 name="ldflags_blob"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ldflags_blob"

diff -urN linux-2.6.9-bk/arch/m32r/Makefile linux/arch/m32r/Makefile
--- linux-2.6.9-bk/arch/m32r/Makefile	2004-10-18 20:34:14.000000000 -0400
+++ linux/arch/m32r/Makefile	2004-10-19 17:40:55.614157644 -0400
@@ -5,7 +5,6 @@
 LDFLAGS		:=
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux	:= -e startup_32
-LDFLAGS_BLOB	:= --format binary --oformat elf32-m32r
 
 CFLAGS += -pipe -fno-schedule-insns
 CFLAGS_KERNEL += -mmodel=medium
diff -urN linux-2.6.9-bk/usr/initramfs_data.S linux/usr/initramfs_data.S
--- linux-2.6.9-bk/usr/initramfs_data.S	2003-12-17 21:59:42.000000000 -0500
+++ linux/usr/initramfs_data.S	2004-10-19 17:41:16.191659582 -0400
@@ -1,28 +1,6 @@
 /*
   initramfs_data includes the compressed binary that is the
   filesystem used for early user space.
-  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
-  released on 2001-07-14) dit not support .incbin.
-  If you are forced to use older binutils than that then the
-  following trick can be applied to create the resulting binary:
-
-
-  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
-  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
-   ld -m elf_i386  -r -o built-in.o initramfs_data.o
-
-  initramfs_data.scr looks like this:
-SECTIONS
-{
-       .init.ramfs : { *(.data) }
-}
-
-  The above example is for i386 - the parameters vary from architectures.
-  Eventually look up LDFLAGS_BLOB in an older version of the
-  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
-
-  Using .incbin has the advantage over ld that the correct flags are set
-  in the ELF header, as required by certain architectures.
 */
 
 .section .init.ramfs,"a"

--------------080005050008020202060506--
