Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWAIT3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWAIT3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWAIT3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:29:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:18392 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751185AbWAIT3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:29:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] spufs: fix build with shrunk struct dcache
Date: Mon, 9 Jan 2006 19:29:18 +0000
User-Agent: KMail/1.9.1
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091929.18760.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spufs was merged at about the same time as Eric's
"shrink dcache struct" patch, so we need to fix up the
newly introduced reference to dentry->d_child.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -138,7 +138,7 @@ static void spufs_prune_dir(struct dentr
 {
 	struct dentry *dentry, *tmp;
 	down(&dir->d_inode->i_sem);
-	list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_child) {
+	list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_u.d_child) {
 		spin_lock(&dcache_lock);
 		spin_lock(&dentry->d_lock);
 		if (!(d_unhashed(dentry)) && dentry->d_inode) {
