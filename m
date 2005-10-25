Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVJYWLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVJYWLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJYWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:11:19 -0400
Received: from [151.97.230.9] ([151.97.230.9]:42168 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932432AbVJYWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:11:18 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/6] uml: fix "reuse i386 cpu optimizations"
Date: Wed, 26 Oct 2005 00:12:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025221203.21106.72834.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove RWSEM_GENERIC_SPINLOCK, it's now defined (only if needed) by the
underlying arch/i386/Kconfig.cpu. Leave it only for x86_64. Even there, it's
totally wrong, as they even have the code to support XCHG_ADD.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig        |    4 ----
 arch/um/Kconfig.x86_64 |    5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -26,10 +26,6 @@ config UID16
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
diff --git a/arch/um/Kconfig.x86_64 b/arch/um/Kconfig.x86_64
--- a/arch/um/Kconfig.x86_64
+++ b/arch/um/Kconfig.x86_64
@@ -6,6 +6,11 @@ config 64BIT
 	bool
 	default y
 
+#XXX: this is so in the underlying arch, but it's wrong!!!
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y

