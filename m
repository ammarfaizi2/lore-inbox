Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFXRMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTFXRMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:12:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38610 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262153AbTFXRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:12:37 -0400
Date: Tue, 24 Jun 2003 19:26:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dwmw2@redhat.com, mtd@infradead.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] two small MTD fixes
Message-ID: <20030624172639.GR3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following fixes for MTD in 2.5.73:
- postfix a constat in mptbase.c with ULL
- add an extern declaration for a function that is later called in
  gen_probe.c

Please apply
Adrian

--- linux-2.5.73-not-full/drivers/message/fusion/mptbase.c.old	2003-06-23 23:07:57.000000000 +0200
+++ linux-2.5.73-not-full/drivers/message/fusion/mptbase.c	2003-06-23 23:08:27.000000000 +0200
@@ -1279,7 +1279,7 @@
 	u32		 psize;
 	int		 ii;
 	int		 r = -ENODEV;
-	u64		 mask = 0xffffffffffffffff;
+	u64		 mask = 0xffffffffffffffffULL;
 
 	if (pci_enable_device(pdev))
 		return r;
--- linux-2.5.73-not-full/drivers/mtd/chips/gen_probe.c.old	2003-06-23 23:16:23.000000000 +0200
+++ linux-2.5.73-not-full/drivers/mtd/chips/gen_probe.c	2003-06-23 23:16:45.000000000 +0200
@@ -281,6 +281,7 @@
 
 extern cfi_cmdset_fn_t cfi_cmdset_0001;
 extern cfi_cmdset_fn_t cfi_cmdset_0002;
+extern cfi_cmdset_fn_t cfi_cmdset_0020;
 
 static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map, 
 						  int primary)
