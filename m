Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWHFPqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWHFPqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWHFPqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:46:52 -0400
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]:10920 "EHLO
	memento.home.lan") by vger.kernel.org with ESMTP id S1750774AbWHFPqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:46:52 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
Date: Sun, 06 Aug 2006 17:47:00 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20060806154700.536.32978.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We have never used this flag and recently one user experienced a complaining
warning about this (there was a symbol in the positive half of the address space
IIRC). So fix it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64 |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 9558a7c..11154b6 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -4,10 +4,13 @@ # Released under the GPL
 core-y += arch/um/sys-x86_64/
 START := 0x60000000
 
+_extra_flags_ = -fno-builtin -m64 -mcmodel=kernel
+
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin -m64
-USER_CFLAGS += -fno-builtin -m64
+CFLAGS += -U__$(SUBARCH)__ $(_extra_flags_)
+USER_CFLAGS += $(_extra_flags_)
+
 CHECKFLAGS  += -m64
 AFLAGS += -m64
 LDFLAGS += -m elf_x86_64
