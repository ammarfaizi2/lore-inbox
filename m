Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWADT7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWADT7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbWADT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:17652 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965285AbWADT5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:36 -0500
Message-Id: <20060104194502.080544000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:32 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 12/13] spufs: fix allocation on 64k pages
Content-Disposition: inline; filename=spufs-64k-page.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the local store is architecture defined
and independent from the page size, so it should
not be defined in terms of pages in the first place.

This mistake broke a few places when building for
64kb pages.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.15-rc/include/asm-powerpc/spu.h
@@ -28,9 +28,7 @@
 #include <linux/kref.h>
 #include <linux/workqueue.h>
 
-#define LS_ORDER (6)		/* 256 kb */
-
-#define LS_SIZE (PAGE_SIZE << LS_ORDER)
+#define LS_SIZE (256 * 1024)
 #define LS_ADDR_MASK (LS_SIZE - 1)
 
 #define MFC_PUT_CMD             0x20

--

