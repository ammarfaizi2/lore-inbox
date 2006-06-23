Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751940AbWFWTEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWFWTEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWFWTEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:04:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:24266 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751940AbWFWTDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:03:43 -0400
Message-Id: <20060623185824.868024000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:49 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 3/5] spufs: fix memory hotplug dependency
Content-Disposition: inline; filename=spufs-fix-hotplug.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>

spufs_base.c calls __add_pages, which depends on CONFIG_MEMORY_HOTPLUG.

Moved the selection of CONFIG_MEMORY_HOTPLUG from CONFIG_SPUFS_MMAP
to CONFIG_SPU_FS.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linus-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -6,6 +6,7 @@ config SPU_FS
 	default m
 	depends on PPC_CELL
 	select SPU_BASE
+	select MEMORY_HOTPLUG
 	help
 	  The SPU file system is used to access Synergistic Processing
 	  Units on machines implementing the Broadband Processor
@@ -18,7 +19,6 @@ config SPU_BASE
 config SPUFS_MMAP
 	bool
 	depends on SPU_FS && SPARSEMEM
-	select MEMORY_HOTPLUG
 	default y
 
 config CBE_RAS

--

