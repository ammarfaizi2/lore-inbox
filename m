Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTKOX0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTKOX0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 18:26:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43207 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262109AbTKOX0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 18:26:12 -0500
Date: Sun, 16 Nov 2003 00:26:04 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] disallow modular BINFMT_ELF
Message-ID: <20031115232600.GF7919@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modular BINFMT_ELF gives unresolved symbols in 2.4 .

modular BINFMT_ELF gives the following unresolved symbols in 2.6:

<--  snip  -->

WARNING: /lib/modules/2.6.0-test9-mm3/kernel/fs/binfmt_elf.ko needs 
unknown symbol __kernel_vsyscall
WARNING: /lib/modules/2.6.0-test9-mm3/kernel/fs/binfmt_elf.ko needs 
unknown symbol empty_zero_page
WARNING: /lib/modules/2.6.0-test9-mm3/kernel/fs/binfmt_elf.ko needs 
unknown symbol dump_task_fpu
WARNING: /lib/modules/2.6.0-test9-mm3/kernel/fs/binfmt_elf.ko needs 
unknown symbol dump_task_extended_fpu
WARNING: /lib/modules/2.6.0-test9-mm3/kernel/fs/binfmt_elf.ko needs 
unknown symbol dump_task_regs

<--  snip  -->


Since modular BINFMT_ELF is pretty pathological I'd suggest the 
following patch:

--- linux-2.6.0-test9-mm3/fs/Kconfig.binfmt.old	2003-11-15 23:43:24.000000000 +0100
+++ linux-2.6.0-test9-mm3/fs/Kconfig.binfmt	2003-11-15 23:43:49.000000000 +0100
@@ -1,5 +1,5 @@
 config BINFMT_ELF
-	tristate "Kernel support for ELF binaries"
+	bool "Kernel support for ELF binaries"
 	depends on MMU
 	default y
 	---help---



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

