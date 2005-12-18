Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVLRQwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVLRQwG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVLRQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:52:06 -0500
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]:57048 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965218AbVLRQwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:52:05 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/4] uml: fix dynamic linking on some 64-bit distros
Date: Sun, 18 Dec 2005 17:50:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051218165034.441.31617.stgit@zion.home.lan>
In-Reply-To: <20051218164916.441.69564.stgit@zion.home.lan>
References: <20051218164916.441.69564.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Rob Landley <rob@landley.net>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current UML build assumes that on x86-64 systems, /lib is a symlink 
to /lib64, but in some distributions (like PLD and CentOS) they are separate 
directories, so the 64 bit library loader isn't found.  This patch 
inserts /lib64 at the start of the rpath on x86-64 UML builds.

Signed-off-by: Rob Landley <rob@landley.net>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 4f118d5..38df311 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -12,3 +12,7 @@ CHECKFLAGS  += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
+
+# Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
+
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64

