Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTHUEoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTHUEoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:44:55 -0400
Received: from front3.chartermi.net ([24.213.60.109]:11655 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S262420AbTHUEon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:44:43 -0400
Message-ID: <3F444E3A.2010507@quark.didntduck.org>
Date: Thu, 21 Aug 2003 00:44:42 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use .incbin for piggy.o
Content-Type: multipart/mixed;
 boundary="------------020905010706050702030002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020905010706050702030002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Simplify creation of piggy.o (i386 arch) using .incbin instead of an ld 
script.

Several other arches use the same method, and should be changed 
accordingly by the respective maintainers.

--
				Brian Gerst

--------------020905010706050702030002
Content-Type: text/plain;
 name="piggy-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="piggy-1"

diff -urN linux-2.6.0-test3-bk/arch/i386/boot/compressed/Makefile linux/arch/i386/boot/compressed/Makefile
--- linux-2.6.0-test3-bk/arch/i386/boot/compressed/Makefile	2003-07-27 13:06:05.000000000 -0400
+++ linux/arch/i386/boot/compressed/Makefile	2003-08-19 10:31:35.201669976 -0400
@@ -19,7 +19,4 @@
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
-
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
-	$(call if_changed,ld)
+$(obj)/piggy.o: $(obj)/vmlinux.bin.gz FORCE
diff -urN linux-2.6.0-test3-bk/arch/i386/boot/compressed/piggy.S linux/arch/i386/boot/compressed/piggy.S
--- linux-2.6.0-test3-bk/arch/i386/boot/compressed/piggy.S	1969-12-31 19:00:00.000000000 -0500
+++ linux/arch/i386/boot/compressed/piggy.S	2003-08-19 10:31:58.172177928 -0400
@@ -0,0 +1,7 @@
+.data
+.globl input_len, input_data, input_data_end
+input_len:
+	.long input_data_end - input_data;
+input_data:
+	.incbin "arch/i386/boot/compressed/vmlinux.bin.gz"
+input_data_end:
diff -urN linux-2.6.0-test3-bk/arch/i386/boot/compressed/vmlinux.scr linux/arch/i386/boot/compressed/vmlinux.scr
--- linux-2.6.0-test3-bk/arch/i386/boot/compressed/vmlinux.scr	2003-07-27 13:09:42.000000000 -0400
+++ linux/arch/i386/boot/compressed/vmlinux.scr	1969-12-31 19:00:00.000000000 -0500
@@ -1,9 +0,0 @@
-SECTIONS
-{
-  .data : { 
-	input_len = .;
-	LONG(input_data_end - input_data) input_data = .; 
-	*(.data) 
-	input_data_end = .; 
-	}
-}

--------------020905010706050702030002--

