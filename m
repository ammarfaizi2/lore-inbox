Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWCURN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWCURN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCURN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:13:26 -0500
Received: from pat.uio.no ([129.240.130.16]:44442 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751123AbWCURNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:13:25 -0500
Subject: VFS: Convert abuses of sector_t
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:13:15 -0500
Message-Id: <1142961196.7987.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.872, required 12,
	autolearn=disabled, AWL 1.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

The type "sector_t" is heavily tied in to the block layer interface as an
offset/handle to a block, and is subject to a supposedly block-specific
configuration option: CONFIG_LBD. Despite this, it is used in struct
kstatfs to save a couple of bytes on the stack whenever we call the
filesystems' ->statfs().

One consequence is that networked filesystems may break if CONFIG_LBD is
not set, since it is quite common to have multi-TB remote filesystems.

The following patch just converts struct kstatfs to use the standard type u64.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 include/linux/statfs.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index ad83a2b..b34cc82 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -8,11 +8,11 @@
 struct kstatfs {
 	long f_type;
 	long f_bsize;
-	sector_t f_blocks;
-	sector_t f_bfree;
-	sector_t f_bavail;
-	sector_t f_files;
-	sector_t f_ffree;
+	u64 f_blocks;
+	u64 f_bfree;
+	u64 f_bavail;
+	u64 f_files;
+	u64 f_ffree;
 	__kernel_fsid_t f_fsid;
 	long f_namelen;
 	long f_frsize;


