Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVAWHGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVAWHGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVAWHEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:04:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:31666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261239AbVAWHEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:04:24 -0500
Date: Sat, 22 Jan 2005 22:54:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ak@suse.de, akpm <akpm@osdl.org>
Subject: [PATCH] x86_64: use UL on large  MODULE_addr constants
Message-Id: <20050122225449.3d57c667.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use UL on large constants, to kill sparse warnings (5 of each):

arch/x86_64/kernel/time.c:198:18: warning: constant 0xffffffff88000000 is so big it is unsigned long
arch/x86_64/kernel/time.c:198:49: warning: constant 0xfffffffffff00000 is so big it is unsigned long

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 include/asm-x86_64/pgtable.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./include/asm-x86_64/pgtable.h~module_addr_long ./include/asm-x86_64/pgtable.h
--- ./include/asm-x86_64/pgtable.h~module_addr_long	2005-01-22 19:06:33.765150024 -0800
+++ ./include/asm-x86_64/pgtable.h	2005-01-22 21:40:33.487498720 -0800
@@ -119,8 +119,8 @@ extern inline void pgd_clear (pgd_t * pg
 #define MAXMEM		 0x3fffffffffffUL
 #define VMALLOC_START    0xffffc20000000000UL
 #define VMALLOC_END      0xffffe1ffffffffffUL
-#define MODULES_VADDR    0xffffffff88000000
-#define MODULES_END      0xfffffffffff00000
+#define MODULES_VADDR    0xffffffff88000000UL
+#define MODULES_END      0xfffffffffff00000UL
 #define MODULES_LEN   (MODULES_END - MODULES_VADDR)
 
 #define _PAGE_BIT_PRESENT	0

--
