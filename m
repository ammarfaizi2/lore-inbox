Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVKLSCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVKLSCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKLSCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:46 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:7880 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932460AbVKLSC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:28 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/9] uml: micro fixups to arch Kconfig
Date: Sat, 12 Nov 2005 19:07:24 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180721.20133.32312.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove a stone-age comment (UM *does* have a MMU, i.e. the host), and fix a
dependency (introduced in commit 02edeb586ae4cdd17778923674700edb732a4741) to
do what was intended.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 3b5f47c..018f076 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -7,7 +7,6 @@ config UML
 	bool
 	default y
 
-# XXX: does UM have a mmu/swap?
 config MMU
 	bool
 	default y
@@ -209,7 +208,8 @@ config MAGIC_SYSRQ
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
-	depends on (MODE_TT && EXPERIMENTAL && !SMP_BROKEN) || (BROKEN && SMP_BROKEN)
+	#SMP_BROKEN is for x86_64.
+	depends on MODE_TT && EXPERIMENTAL && (!SMP_BROKEN || (BROKEN && SMP_BROKEN))
 	help
 	This option enables UML SMP support.
 	It is NOT related to having a real SMP box. Not directly, at least.

