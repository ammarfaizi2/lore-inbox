Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVAPLru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVAPLru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVAPLru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:47:50 -0500
Received: from verein.lst.de ([213.95.11.210]:11997 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262485AbVAPLrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:47:45 -0500
Date: Sun, 16 Jan 2005 12:47:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf: allow mips to overrid e_flags
Message-ID: <20050116114740.GA13543@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/kernel/binfmt_elfn32.c needs to override e_flags for elf
coredumps.  It already defines ELF_CORE_EFLAGS before including
binfmt_elf.c, but the latter doesn't pick up the define yet.


--- 1.98/fs/binfmt_elf.c	2005-01-12 03:07:01 +01:00
+++ edited/fs/binfmt_elf.c	2005-01-16 11:54:37 +01:00
@@ -69,6 +69,10 @@
 # define ELF_MIN_ALIGN	PAGE_SIZE
 #endif
 
+#ifndef ELF_CORE_EFLAGS
+#define ELF_CORE_EFLAGS	0
+#endif
+
 #define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
 #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
 #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
@@ -1172,7 +1176,7 @@
 	elf->e_entry = 0;
 	elf->e_phoff = sizeof(struct elfhdr);
 	elf->e_shoff = 0;
-	elf->e_flags = 0;
+	elf->e_flags = ELF_CORE_EFLAGS;
 	elf->e_ehsize = sizeof(struct elfhdr);
 	elf->e_phentsize = sizeof(struct elf_phdr);
 	elf->e_phnum = segs;
