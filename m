Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbSI1EbQ>; Sat, 28 Sep 2002 00:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262704AbSI1E37>; Sat, 28 Sep 2002 00:29:59 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:5343 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S262705AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [PATCH] ati_pcigart: support 16K and 64K page size
Message-Id: <E17v9Je-0001n4-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for 16K and 64K system page sizes.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660   -> 1.661  
#	drivers/char/drm/ati_pcigart.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/14	bjorn_helgaas@hp.com	1.661
# Add 64K & 16K page size support to ati_pcigart.h
# --------------------------------------------
#
diff -Nru a/drivers/char/drm/ati_pcigart.h b/drivers/char/drm/ati_pcigart.h
--- a/drivers/char/drm/ati_pcigart.h	Sat Sep 14 15:26:54 2002
+++ b/drivers/char/drm/ati_pcigart.h	Sat Sep 14 15:26:54 2002
@@ -29,14 +29,20 @@
 
 #include "drmP.h"
 
-#if PAGE_SIZE == 8192
+#if PAGE_SIZE == 65536
+# define ATI_PCIGART_TABLE_ORDER 	0
+# define ATI_PCIGART_TABLE_PAGES 	(1 << 0)
+#elif PAGE_SIZE == 16384
+# define ATI_PCIGART_TABLE_ORDER 	1
+# define ATI_PCIGART_TABLE_PAGES 	(1 << 1)
+#elif PAGE_SIZE == 8192
 # define ATI_PCIGART_TABLE_ORDER 	2
 # define ATI_PCIGART_TABLE_PAGES 	(1 << 2)
 #elif PAGE_SIZE == 4096
 # define ATI_PCIGART_TABLE_ORDER 	3
 # define ATI_PCIGART_TABLE_PAGES 	(1 << 3)
 #else
-# error - PAGE_SIZE not 8K or 4K
+# error - PAGE_SIZE not 64K, 16K, 8K or 4K
 #endif
 
 # define ATI_MAX_PCIGART_PAGES		8192	/* 32 MB aperture, 4K pages */
