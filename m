Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUEVMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUEVMTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUEVMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:19:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8924 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261156AbUEVMTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:19:11 -0400
Date: Sat, 22 May 2004 14:19:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       David Woodhouse <dwmw2@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
       l.s.r@web.de, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.6-mm5: JFFS2_FS_NAND=y compile error
Message-ID: <20040522121905.GM18564@fs.tum.de>
References: <20040522013636.61efef73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch
  [PATCH] trivial: Make JFFS2 ready for Linux 2.7
from Linus' tree is broken with CONFIG_JFFS2_FS_NAND=y:

<--  snip  -->

...
  LD      .tmp_vmlinux1
fs/built-in.o(.text+0x16bdc2): In function `jffs2_wbuf_recover':
: undefined reference to `jffs2_erase_pending_trigger'
fs/built-in.o(.text+0x16c0e2): In function `jffs2_wbuf_recover':
: undefined reference to `jffs2_reserve_space_gc'
fs/built-in.o(.text+0x16c198): In function `jffs2_wbuf_recover':
: undefined reference to `jffs2_alloc_raw_node_ref'
fs/built-in.o(.text+0x16c1d0): In function `jffs2_wbuf_recover':
: undefined reference to `jffs2_add_physical_node_ref'
fs/built-in.o(.text+0x16c46b): In function `jffs2_wbuf_recover':
: undefined reference to `jffs2_erase_pending_trigger'
fs/built-in.o(.text+0x16c8f9): In function `__jffs2_flush_wbuf':
: undefined reference to `jffs2_erase_pending_trigger'
fs/built-in.o(.text+0x16c9f3): In function `jffs2_flush_wbuf_gc':
: undefined reference to `jffs2_garbage_collect_pass'
fs/built-in.o(.text+0x16cac8): In function `jffs2_flash_writev':
: undefined reference to `jffs2_flash_direct_writev'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The bug is obvious, and the fix is trivial:


--- linux-2.6.6-mm5-full/fs/jffs2/Makefile.old	2004-05-22 14:15:47.000000000 +0200
+++ linux-2.6.6-mm5-full/fs/jffs2/Makefile	2004-05-22 14:16:30.000000000 +0200
@@ -12,4 +12,4 @@
 jffs2-y	+= symlink.o build.o erase.o background.o fs.o writev.o
 jffs2-y	+= super.o
 
-jffs2-$(CONFIG_JFFS2_FS_NAND)	:= wbuf.o
+jffs2-$(CONFIG_JFFS2_FS_NAND)	+= wbuf.o



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

