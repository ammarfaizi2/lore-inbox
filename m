Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVDLUOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVDLUOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVDLUMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:12:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:30920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262146AbVDLKbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:36 -0400
Message-Id: <200504121031.j3CAVRhc005320@shell0.pdx.osdl.net>
Subject: [patch 049/198] ppc64: fix export of wrong symbol
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Mackerras <paulus@samba.org>

In arch/ppc64/kernel/ppc_ksyms.c, we are still exporting
flush_icache_range, but that has been changed to be an inline in
include/asm-ppc64/cacheflush.h which calls __flush_icache_range (defined in
arch/ppc64/kernel/misc.S).

This patch changes the export to __flush_icache_range, thus allowing
modules to use the inline flush_icache_range.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/ppc_ksyms.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc64/kernel/ppc_ksyms.c~ppc64-fix-export-of-wrong-symbol arch/ppc64/kernel/ppc_ksyms.c
--- 25/arch/ppc64/kernel/ppc_ksyms.c~ppc64-fix-export-of-wrong-symbol	2005-04-12 03:21:15.267815840 -0700
+++ 25-akpm/arch/ppc64/kernel/ppc_ksyms.c	2005-04-12 03:21:15.270815384 -0700
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(giveup_fpu);
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
 #endif
-EXPORT_SYMBOL(flush_icache_range);
+EXPORT_SYMBOL(__flush_icache_range);
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PPC_ISERIES
_
