Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVDEGOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVDEGOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDEGOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:14:46 -0400
Received: from terminus.zytor.com ([209.128.68.124]:4780 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261570AbVDEGO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:14:27 -0400
Message-ID: <42522CB8.1010007@zytor.com>
Date: Mon, 04 Apr 2005 23:14:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] biarch compiler support for i386
Content-Type: multipart/mixed;
 boundary="------------040705080309000807070702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705080309000807070702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This allows the i386 architecture to be built on a system with a biarch 
compiler that defaults to x86-64, merely by specifying ARCH=i386.

As previously discussed, this uses the equivalent logic to the ppc port.

	-hpa

Signed-Off-By: H. Peter Anvin <hpa@zytor.com>

--------------040705080309000807070702
Content-Type: text/x-patch;
 name="i386-biarch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-biarch.patch"

Index: linux-2.5/arch/i386/Makefile
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/Makefile,v
retrieving revision 1.75
diff -u -r1.75 Makefile
--- linux-2.5/arch/i386/Makefile	12 Mar 2005 22:03:27 -0000	1.75
+++ linux-2.5/arch/i386/Makefile	5 Apr 2005 05:29:20 -0000
@@ -17,6 +17,13 @@
 #           Kianusch Sayah Karadji <kianusch@sk-tech.net>
 #           Added support for GEODE CPU
 
+HAS_BIARCH      := $(call cc-option-yn, -m32)
+ifeq ($(HAS_BIARCH),y)
+AS              := $(AS) --32
+LD              := $(LD) -m elf_i386
+CC              := $(CC) -m32
+endif
+
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=

--------------040705080309000807070702--
