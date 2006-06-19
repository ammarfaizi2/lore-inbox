Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWFSSqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWFSSqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWFSSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:2275 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932545AbWFSSn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:26 -0400
Message-Id: <20060619183406.773427000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:34 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 19/20] spufs: fail spu_create with invalid flags
Content-Disposition: inline; filename=spufs-check-flags.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this time, all flags are invalid. Since we are
planning to actually add valid flags in the future,
we better check if any were passed by the user.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
@@ -304,6 +304,10 @@ long spufs_create_thread(struct nameidat
 	    nd->dentry != nd->dentry->d_sb->s_root)
 		goto out;
 
+	/* all flags are reserved */
+	if (flags)
+		goto out;
+
 	dentry = lookup_create(nd, 1);
 	ret = PTR_ERR(dentry);
 	if (IS_ERR(dentry))

--

