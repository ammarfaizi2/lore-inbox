Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTFXRF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFXRF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:05:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29907 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262148AbTFXRFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:05:24 -0400
Date: Tue, 24 Jun 2003 19:19:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] small cleanups for amd-k8-agp.c
Message-ID: <20030624171926.GP3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

the patch below does the following trivial cleanups to 
drivers/char/agp/amd-k8-agp.c:
- postfix three constants with ULL
- remove a variable that isn't needed

Please apply
Adrian


--- linux-2.5.73-not-full/drivers/char/agp/amd-k8-agp.c.old	2003-06-23 22:26:27.000000000 +0200
+++ linux-2.5.73-not-full/drivers/char/agp/amd-k8-agp.c	2003-06-23 22:27:21.000000000 +0200
@@ -47,7 +47,6 @@
 static int x86_64_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	int i, j, num_entries;
-	long tmp;
 	u32 pte;
 	u64 addr;
 
@@ -78,10 +77,9 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = agp_bridge->driver->mask_memory(mem->memory[i], mem->type);
 
-		tmp = addr;
-		BUG_ON(tmp & 0xffffff0000000ffc);
-		pte = (tmp & 0x000000ff00000000) >> 28;
-		pte |=(tmp & 0x00000000fffff000);
+		BUG_ON(addr & 0xffffff0000000ffcULL);
+		pte = (addr & 0x000000ff00000000ULL) >> 28;
+		pte |=(addr & 0x00000000fffff000ULL);
 		pte |= 1<<1|1<<0;
 
 		agp_bridge->gatt_table[j] = pte;
