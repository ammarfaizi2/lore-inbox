Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293064AbSBWAy3>; Fri, 22 Feb 2002 19:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293062AbSBWAyT>; Fri, 22 Feb 2002 19:54:19 -0500
Received: from u212-239-157-160.goplanet.pi.be ([212.239.157.160]:42245 "EHLO
	jebril.pi.be") by vger.kernel.org with ESMTP id <S293061AbSBWAyA>;
	Fri, 22 Feb 2002 19:54:00 -0500
Message-Id: <200202230053.g1N0qBYb029551@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/filesystems.c compile failure in 2.5.x
Date: Sat, 23 Feb 2002 01:52:11 +0100
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.5.x, fs/filesystems.c does not compile if nfsd is not 
compiled in and CONFIG_MODULES is defined. The attached 
patch fixes it.

MCE

=====================================================================
--- include/linux/nfsd/interface.h.old	Thu Feb 21 01:26:04 2002
+++ include/linux/nfsd/interface.h	Sat Feb 23 01:46:14 2002
@@ -12,12 +12,14 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_NFSD_MODULE
-
-extern struct nfsd_linkage {
+struct nfsd_linkage {
 	long (*do_nfsservctl)(int cmd, void *argp, void *resp);
 	struct module *owner;
-} * nfsd_linkage;
+};
+
+#ifdef CONFIG_NFSD_MODULE
+
+extern struct nfsd_linkage * nfsd_linkage;
 
 #endif
 

-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

