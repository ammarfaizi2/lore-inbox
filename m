Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164248AbWLHAwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164248AbWLHAwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164249AbWLHAwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:52:23 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:35337 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164248AbWLHAwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:52:22 -0500
Date: Fri, 8 Dec 2006 00:52:14 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove useless wmb() memory barrier
Message-ID: <20061208005214.GA18015@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wake_up's implementation does an implicit memory barrier and I think
that's the only sane semantics as the caller shouldn't have to worry.
So this write memory barrier is useless.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index b93265b..33800c7 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -553,7 +553,6 @@ vfs_sync_worker(
 		error = bhv_vfs_sync(vfsp, SYNC_FSDATA | SYNC_BDFLUSH | \
 					SYNC_ATTR | SYNC_REFCACHE, NULL);
 	vfsp->vfs_sync_seq++;
-	wmb();
 	wake_up(&vfsp->vfs_wait_single_sync_task);
 }
 
