Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757214AbWLCQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbWLCQxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757138AbWLCQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:53:18 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:33460 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1756807AbWLCQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:53:17 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 11:49:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: Convert kmalloc() + memset() to kzalloc() in fs/.
Message-ID: <Pine.LNX.4.64.0612031146400.4699@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Convert the single available instance of kmalloc() + memset() to
kzalloc() in the fs/ directory.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  (Re-submission of earlier patch, but omitting erroneous part of
that patch.  Sorry about that.  Nothing but decaf in the house.)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f86d5c9..789c1c6 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -709,12 +709,11 @@ #endif
 		return -ELIBBAD;

 	size = sizeof(*loadmap) + nloads * sizeof(*seg);
-	loadmap = kmalloc(size, GFP_KERNEL);
+	loadmap = kzalloc(size, GFP_KERNEL);
 	if (!loadmap)
 		return -ENOMEM;

 	params->loadmap = loadmap;
-	memset(loadmap, 0, size);

 	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
 	loadmap->nsegs = nloads;
