Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbUKXAJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbUKXAJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKWRes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:34:48 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41647 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261363AbUKWQTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:19:07 -0500
Date: Tue, 23 Nov 2004 09:19:04 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix uninitialized PPC40x vars
Message-ID: <20041123091904.B24513@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix more uninitialized variables in the PPC40x code.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/boot/simple/misc-embedded.c 1.14 vs edited =====
--- 1.14/arch/ppc/boot/simple/misc-embedded.c	2004-09-07 23:33:06 -07:00
+++ edited/arch/ppc/boot/simple/misc-embedded.c	2004-11-23 09:15:34 -07:00
@@ -218,7 +218,7 @@
 	puts("done.\n");
 	{
 		struct bi_record *rec;
-		unsigned long initrd_loc;
+		unsigned long initrd_loc = 0;
 		unsigned long rec_loc = _ALIGN((unsigned long)(zimage_size) +
 				(1 << 20) - 1, (1 << 20));
 		rec = (struct bi_record *)rec_loc;
===== arch/ppc/syslib/ppc405_pci.c 1.9 vs edited =====
--- 1.9/arch/ppc/syslib/ppc405_pci.c	2004-05-14 19:00:24 -07:00
+++ edited/arch/ppc/syslib/ppc405_pci.c	2004-11-23 09:15:03 -07:00
@@ -82,8 +82,8 @@
 	unsigned int tmp_addr;
 	unsigned int tmp_size;
 	unsigned int reg_index;
-	unsigned int new_pmm_max;
-	unsigned int new_pmm_min;
+	unsigned int new_pmm_max = 0;
+	unsigned int new_pmm_min = 0;
 
 	isa_io_base = 0;
 	isa_mem_base = 0;
