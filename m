Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVDEGgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDEGgC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVDEGgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:36:02 -0400
Received: from ozlabs.org ([203.10.76.45]:4759 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261577AbVDEGf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:35:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.12739.212317.106222@cargo.ozlabs.ibm.com>
Date: Tue, 5 Apr 2005 16:35:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: fix export of wrong symbol
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/ppc64/kernel/ppc_ksyms.c, we are still exporting
flush_icache_range, but that has been changed to be an inline in
include/asm-ppc64/cacheflush.h which calls __flush_icache_range
(defined in arch/ppc64/kernel/misc.S).

This patch changes the export to __flush_icache_range, thus allowing
modules to use the inline flush_icache_range.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/ppc_ksyms.c test/arch/ppc64/kernel/ppc_ksyms.c
--- linux-2.5/arch/ppc64/kernel/ppc_ksyms.c	2005-03-07 10:46:38.000000000 +1100
+++ test/arch/ppc64/kernel/ppc_ksyms.c	2005-04-04 08:20:26.000000000 +1000
@@ -74,7 +74,7 @@
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
 #endif
-EXPORT_SYMBOL(flush_icache_range);
+EXPORT_SYMBOL(__flush_icache_range);
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PPC_ISERIES
