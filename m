Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWHXBkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWHXBkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWHXBkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:40:40 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:48858 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1030187AbWHXBkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:40:39 -0400
Subject: [PATCH] Linux 2.6.17.11 - fix compilation error on IA64
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: gregkh@suse.de
Cc: dev@openvz.org, xemul@openvz.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Thu, 24 Aug 2006 10:40:36 +0900
Message-Id: <1156383636.1899.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8833ebaa3f4325820fe3338ccf6fae04f6669254 introduced a change that makes
the compilation of a IA64 kernel fail as follows:

  GEN     usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/ia64/kernel/acpi.o
  AS      arch/ia64/kernel/entry.o
include/asm/mman.h: Assembler messages:
include/asm/mman.h:13: Error: Unknown opcode `int ia64_map_check_rgn(unsigned long addr,unsigned long len,'
include/asm/mman.h:14: Error: Unknown opcode `unsigned long flags)'
make[1]: *** [arch/ia64/kernel/entry.o] Error 1
make: *** [arch/ia64/kernel] Error 2

This patch fixes this.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.17.11/include/asm-ia64/mman.h linux-2.6.17.11-fix/include/asm-ia64/mman.h
--- linux-2.6.17.11/include/asm-ia64/mman.h	2006-08-24 10:29:56.000000000 +0900
+++ linux-2.6.17.11-fix/include/asm-ia64/mman.h	2006-08-24 10:33:13.000000000 +0900
@@ -8,7 +8,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
 
-#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 #define arch_mmap_check	ia64_map_check_rgn
 int ia64_map_check_rgn(unsigned long addr, unsigned long len,
 		unsigned long flags);


