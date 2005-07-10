Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVGJTyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVGJTyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVGJTl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51932 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262023AbVGJTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:19 -0400
Date: Sun, 10 Jul 2005 19:36:18 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: [PATCH 70/82] remove linux/version.h from fs/xfs/
Message-ID: <20050710193618.70.qNxGNj4127.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove code for obsolete kernels

Signed-off-by: Olaf Hering <olh@suse.de>

fs/xfs/linux-2.6/xfs_linux.h |    1 -
fs/xfs/xfs_dmapi.h           |   16 ----------------
2 files changed, 17 deletions(-)

Index: linux-2.6.13-rc2-mm1/fs/xfs/linux-2.6/xfs_linux.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/xfs/linux-2.6/xfs_linux.h
+++ linux-2.6.13-rc2-mm1/fs/xfs/linux-2.6/xfs_linux.h
@@ -87,7 +87,6 @@
#include <linux/init.h>
#include <linux/list.h>
#include <linux/proc_fs.h>
-#include <linux/version.h>
#include <linux/sort.h>

#include <asm/page.h>
Index: linux-2.6.13-rc2-mm1/fs/xfs/xfs_dmapi.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/xfs/xfs_dmapi.h
+++ linux-2.6.13-rc2-mm1/fs/xfs/xfs_dmapi.h
@@ -172,25 +172,9 @@ typedef enum {
/*
*	Based on IO_ISDIRECT, decide which i_ flag is set.
*/
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
#define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ?  			      DM_FLAGS_ISEM : 0)
#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_ISEM)
-#endif
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)) && -    (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,22))
-#define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? -			      DM_FLAGS_IALLOCSEM_RD : DM_FLAGS_ISEM)
-#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_ISEM)
-#endif
-
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,21)
-#define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? -			      0 : DM_FLAGS_ISEM)
-#define DM_SEM_FLAG_WR	(DM_FLAGS_ISEM)
-#endif
-

/*
*	Macros to turn caller specified delay/block flags into
