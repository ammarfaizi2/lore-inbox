Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUH1QCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUH1QCX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUH1QCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:02:23 -0400
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:50847 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S266538AbUH1QCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:02:21 -0400
Message-ID: <4130AC74.8010600@quark.didntduck.org>
Date: Sat, 28 Aug 2004 12:01:56 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix hardcoded value in vsyscall.lds
Content-Type: multipart/mixed;
 boundary="------------010506000608090905050808"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010506000608090905050808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The last attempt to clean this up still left a hardcoded constant (the 
offset from __FIXADDR_TOP).  This patch moves VSYSCALL_BASE to 
asm-offsets.c.

--
				Brian Gerst

--------------010506000608090905050808
Content-Type: text/plain;
 name="vsyscall-fixmap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vsyscall-fixmap"

diff -urN linux-2.6.9-rc1-bk/arch/i386/kernel/asm-offsets.c linux/arch/i386/kernel/asm-offsets.c
--- linux-2.6.9-rc1-bk/arch/i386/kernel/asm-offsets.c	2004-06-23 18:06:12.000000000 -0400
+++ linux/arch/i386/kernel/asm-offsets.c	2004-08-27 10:55:04.384806536 -0400
@@ -62,4 +62,5 @@
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
+	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
 }
diff -urN linux-2.6.9-rc1-bk/arch/i386/kernel/vsyscall.lds.S linux/arch/i386/kernel/vsyscall.lds.S
--- linux-2.6.9-rc1-bk/arch/i386/kernel/vsyscall.lds.S	2004-08-26 17:17:35.000000000 -0400
+++ linux/arch/i386/kernel/vsyscall.lds.S	2004-08-27 10:54:41.293818300 -0400
@@ -3,9 +3,7 @@
  * object prelinked to its virtual address, and with only one read-only
  * segment (that fits in one page).  This script controls its layout.
  */
-#include <asm/fixmap.h>
-
-VSYSCALL_BASE = __FIXADDR_TOP - 0x1000;
+#include <asm/asm_offsets.h>
 
 SECTIONS
 {

--------------010506000608090905050808--
