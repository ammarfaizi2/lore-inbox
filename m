Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263265AbTCYUCJ>; Tue, 25 Mar 2003 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbTCYUCJ>; Tue, 25 Mar 2003 15:02:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263265AbTCYUCI>;
	Tue, 25 Mar 2003 15:02:08 -0500
Subject: [TRIVIAL PATCH][2.5.66] fix for link-error in i810fb_imageblit
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: jsimmons@infradead.org
Content-Type: text/plain
Organization: 
Message-Id: <1048623198.14000.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 12:13:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is one way to fix a link-error found in the i810 FB driver as
found in pure 2.5.66.

The error is reported as an undefined reference to __memcpy() inside
i810fb_imageblit().

The error:
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o: In function `i810fb_imageblit':
drivers/built-in.o(.text+0xb59c1): undefined reference to `__memcpy'
make: *** [.tmp_vmlinux1] Error 1


The diff:

diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Tue Mar 25 12:02:29 2003
+++ b/include/linux/fb.h	Tue Mar 25 12:02:29 2003
@@ -4,6 +4,7 @@
 #include <linux/tty.h>
 #include <asm/types.h>
 #include <asm/io.h>
+#include <asm/string.h>
 
 /* Definitions of frame buffers						*/
 



