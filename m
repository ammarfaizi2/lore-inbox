Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVCNDXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVCNDXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVCNDXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:23:09 -0500
Received: from ozlabs.org ([203.10.76.45]:20866 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261745AbVCNDXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.957.650893.747905@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 14:23:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Amos Waterland <apw@us.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 debugging symbols for boot wrapper
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Amos Waterland <apw@us.ibm.com>.

It is really useful when debugging early boot on simulator to have debug
symbols in the 32-bit code that uncompresses the kernel proper.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/boot/Makefile test/arch/ppc64/boot/Makefile
--- linux-2.5/arch/ppc64/boot/Makefile	2005-03-07 10:46:38.000000000 +1100
+++ test/arch/ppc64/boot/Makefile	2005-03-14 13:42:34.000000000 +1100
@@ -27,6 +27,11 @@
 BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
 
+ifdef CONFIG_DEBUG_INFO
+BOOTCFLAGS		+= -g
+BOOTAFLAGS		+= -g
+endif
+
 src-boot := crt0.S string.S prom.c main.c zlib.c imagesize.c div64.S
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
