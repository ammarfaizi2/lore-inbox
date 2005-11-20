Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVKTUHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVKTUHP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVKTUHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:07:14 -0500
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]:54662 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750779AbVKTUHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:07:13 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] [RFC] [Oops fix] module support: record in vermagic ability to unload a module
Date: Sun, 20 Nov 2005 21:06:07 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051120200606.9802.69236.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

An UML user reported (against 2.6.13.3/UML) he got kernel Oopses when trying to
rmmod (on a kernel with module unloading enabled) a module compiled with module
unloading disabled. As crashing is a very correct thing to do in that case, a
solution is altering the vermagic string to include this too.

Possibly, however, the code should not crash in this case, even if the module
didn't support unloading - it should simply abort the module removal. In this case,
fixing that bug would be a better solution. I've not investigated though.

Thanks to Hayim for reporting.

Cc: Hayim Shaul <hayim@post.tau.ac.il>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/linux/vermagic.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index fadc535..dc7c621 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -12,6 +12,11 @@
 #else
 #define MODULE_VERMAGIC_PREEMPT ""
 #endif
+#ifdef CONFIG_MODULE_UNLOAD
+#define MODULE_VERMAGIC_MODULE_UNLOAD "mod_unload "
+#else
+#define MODULE_VERMAGIC_MODULE_UNLOAD ""
+#endif
 #ifndef MODULE_ARCH_VERMAGIC
 #define MODULE_ARCH_VERMAGIC ""
 #endif
@@ -19,5 +24,5 @@
 #define VERMAGIC_STRING 						\
 	UTS_RELEASE " "							\
 	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
-	MODULE_ARCH_VERMAGIC 						\
+	MODULE_VERMAGIC_MODULE_UNLOAD MODULE_ARCH_VERMAGIC 		\
 	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)

