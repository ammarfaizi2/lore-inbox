Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVDLLPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVDLLPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVDLLPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:15:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:15050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVDLKc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:58 -0400
Message-Id: <200504121032.j3CAWqMW005704@shell0.pdx.osdl.net>
Subject: [patch 140/198] efi: eliminate bad section references
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, janitor@sternwelten.at,
       rddunlap@osdl.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: maximilian attems <janitor@sternwelten.at>

Randy please double check especially this one.
there may be a better solution.

Fix efi section references:
 remove __initdata for struct efi efi_phys 
 and struct efi_memory_map memmap

Error: ./arch/i386/kernel/efi.o .text refers to 000000d3 R_386_32
.init.data
Error: ./arch/i386/kernel/efi.o .text refers to 000000ff R_386_32
.init.data

efi_memmap_walk (which is not __init nor static) 
accesses both efi_phys and memmap.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/efi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/efi.c~efi-eliminate-bad-section-references arch/i386/kernel/efi.c
--- 25/arch/i386/kernel/efi.c~efi-eliminate-bad-section-references	2005-04-12 03:21:37.121493576 -0700
+++ 25-akpm/arch/i386/kernel/efi.c	2005-04-12 03:21:37.124493120 -0700
@@ -46,8 +46,8 @@ extern efi_status_t asmlinkage efi_call_
 
 struct efi efi;
 EXPORT_SYMBOL(efi);
-static struct efi efi_phys __initdata;
-struct efi_memory_map memmap __initdata;
+static struct efi efi_phys;
+struct efi_memory_map memmap;
 
 /*
  * We require an early boot_ioremap mapping mechanism initially
_
