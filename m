Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWLBL10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWLBL10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162965AbWLBL10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:27:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:27717 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162958AbWLBL1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:27:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=SJEAJYevVVy5SrovW34j95iScFGjXSUne3zSN8vHHxWPcMbgIZzX+S550Zjjp0VR2VvR17dG8byWDgOXGHO1yBJzN7g4fwTUpRE4l2Ub12sL4tzJEZNVOu2dxBwaKMGwt2AStV9ns50jFHVFxa9AalMCBhI7ch6MbgXwouEdf1M=
Subject: [PATCH 2.6.19] m68k: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: geert@linux-m68k.org, zippel@linux-m68k.org, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:29:24 +0200
Message-Id: <1165058964.4523.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc 

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/arch/m68k/amiga/chipram.c linux-2.6.19-rc5_kzalloc/arch/m68k/amiga/chipram.c
--- linux-2.6.19-rc5_orig/arch/m68k/amiga/chipram.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/m68k/amiga/chipram.c	2006-11-11 22:44:04.000000000 +0200
@@ -52,10 +52,9 @@ void *amiga_chip_alloc(unsigned long siz
 #ifdef DEBUG
     printk("amiga_chip_alloc: allocate %ld bytes\n", size);
 #endif
-    res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+    res = kzalloc(sizeof(struct resource), GFP_KERNEL);
     if (!res)
 	return NULL;
-    memset(res, 0, sizeof(struct resource));
     res->name = name;
 
     if (allocate_resource(&chipram_res, res, size, 0, UINT_MAX, PAGE_SIZE, NULL, NULL) < 0) {

diff -rubp linux-2.6.19-rc5_orig/arch/m68k/atari/hades-pci.c linux-2.6.19-rc5_kzalloc/arch/m68k/atari/hades-pci.c
--- linux-2.6.19-rc5_orig/arch/m68k/atari/hades-pci.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/m68k/atari/hades-pci.c	2006-11-11 22:44:04.000000000 +0200
@@ -375,10 +375,9 @@ struct pci_bus_info * __init init_hades_
 	 * Allocate memory for bus info structure.
 	 */
 
-	bus = kmalloc(sizeof(struct pci_bus_info), GFP_KERNEL);
+	bus = kzalloc(sizeof(struct pci_bus_info), GFP_KERNEL);
 	if (!bus)
 		return NULL;
-	memset(bus, 0, sizeof(struct pci_bus_info));
 
 	/*
 	 * Claim resources. The m68k has no separate I/O space, both



