Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVKLSCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVKLSCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKLSCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:46 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:8136 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932461AbVKLSCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:33 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/9] uml - fixups for "reuse i386 cpu-specific tuning"
Date: Sat, 12 Nov 2005 19:07:29 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180727.20133.58958.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

A few fixups - show the new submenu only for x86 subarchitecture (it does not
make sense to show it for x86_64 users) and remove X86_CMPXCHG, which is now a
duplicate of Kconfig.i386, even though Kconfig doesn't complain (we also
miss the dependency on !M386 CPU).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig       |    6 ------
 arch/um/Kconfig.i386  |   10 ++++++----
 arch/um/Makefile-i386 |    1 -
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 018f076..563301f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -35,12 +35,6 @@ config IRQ_RELEASE_METHOD
 	bool
 	default y
 
-menu "Host processor type and features"
-
-source "arch/i386/Kconfig.cpu"
-
-endmenu
-
 menu "UML-specific options"
 
 config MODE_TT
diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index 5d92cac..c71b39a 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -1,3 +1,9 @@
+menu "Host processor type and features"
+
+source "arch/i386/Kconfig.cpu"
+
+endmenu
+
 config UML_X86
 	bool
 	default y
@@ -42,7 +48,3 @@ config ARCH_HAS_SC_SIGNALS
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default y
-
-config X86_CMPXCHG
-	bool
-	default y
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 1f7dcb0..7a0e04e 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -35,4 +35,3 @@ cflags-y += $(call cc-option,-mpreferred
 
 CFLAGS += $(cflags-y)
 USER_CFLAGS += $(cflags-y)
-

