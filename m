Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVIUQra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVIUQra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVIUQrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:10 -0400
Received: from [151.97.230.9] ([151.97.230.9]:28558 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751123AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 07/10] uml: fix bogus HOST_ELF_CLASS symbol name
Date: Wed, 21 Sep 2005 18:39:47 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921163946.30500.54980.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Even if with a bit of misunderstanding, Al fixed this in commit
95608261dae863bc43292e6fbd946a3abd3aa49f.

Well, the symbol was intended to come from userspace (it exists there on normal
host), but since some hosts may miss that, using the kernel one is just as fine.
However, rename it to be named consistently with the rest.

Actually, he missed converting ELFCLASS32 to coming from kernel headers. For
consistence, add ELFCLASS64 too.

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/common-offsets.h |    4 +++-
 arch/um/os-Linux/elf_aux.c       |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/common-offsets.h b/arch/um/include/common-offsets.h
--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -12,4 +12,6 @@ DEFINE_STR(UM_KERN_WARNING, KERN_WARNING
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
-DEFINE(HOST_ELF_CLASS, ELF_CLASS);
+DEFINE(UM_ELF_CLASS, ELF_CLASS);
+DEFINE(UM_ELFCLASS32, ELFCLASS32);
+DEFINE(UM_ELFCLASS64, ELFCLASS64);
diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -14,7 +14,8 @@
 #include "mem_user.h"
 #include <kernel-offsets.h>
 
-#if HOST_ELF_CLASS == ELFCLASS32
+/* Use the one from the kernel - the host may miss it, if having old headers. */
+#if UM_ELF_CLASS == UM_ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
 #else
 typedef Elf64_auxv_t elf_auxv_t;

