Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVDDSMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVDDSMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDDSMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:12:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20880 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261313AbVDDSLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:11:40 -0400
Date: Mon, 4 Apr 2005 20:11:36 +0200
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch 3/3] efi eliminate bad section references
Message-ID: <20050404181136.GC12394@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


--- linux-2.6.12-rc1-bk5/arch/i386/kernel/efi.c.orig	2005-04-04 19:41:13.109877906 +0200
+++ linux-2.6.12-rc1-bk5/arch/i386/kernel/efi.c	2005-04-04 19:34:23.886343763 +0200
@@ -46,8 +46,8 @@
 
 struct efi efi;
 EXPORT_SYMBOL(efi);
-static struct efi efi_phys __initdata;
-struct efi_memory_map memmap __initdata;
+static struct efi efi_phys;
+struct efi_memory_map memmap;
 
 /*
  * We require an early boot_ioremap mapping mechanism initially
