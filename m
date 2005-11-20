Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKTUCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKTUCz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKTUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:02:55 -0500
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]:20397 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750748AbVKTUCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:02:54 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] uml: fix dynamic linking on some 64-bit distros
Date: Sun, 20 Nov 2005 20:10:22 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051120191021.4189.37355.stgit@zion.home.lan>
In-Reply-To: <20051120191019.4189.22191.stgit@zion.home.lan>
References: <20051120191019.4189.22191.stgit@zion.home.lan>
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

