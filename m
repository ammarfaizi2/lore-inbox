Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSFJC2l>; Sun, 9 Jun 2002 22:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSFJC2k>; Sun, 9 Jun 2002 22:28:40 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:11899 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316187AbSFJC2j>; Sun, 9 Jun 2002 22:28:39 -0400
Subject: [PATCH-2.5.21] Fix/add exports for vmalloc, vmalloc_32, vmalloc_dma
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 10 Jun 2002 03:28:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17HEv9-0005ou-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply below patchlet which adds exports for vmalloc, vmalloc_32,
and vmalloc_dma to kernel/ksyms.c.

These are needed as the above functions used to be static inline inside
include/linux/vmalloc.h but have now been taken out of line and now
all modular code using them is broken.

I noticed because NTFS uses vmalloc to allocate decompression engine
buffers.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

---vmalloc-export.diff---
--- tng/kernel/ksyms.c.old	Mon Jun 10 03:19:58 2002
+++ tng/kernel/ksyms.c	Mon Jun 10 03:21:18 2002
@@ -108,6 +108,9 @@ EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(vmalloc);
+EXPORT_SYMBOL(vmalloc_dma);
+EXPORT_SYMBOL(vmalloc_32);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);
