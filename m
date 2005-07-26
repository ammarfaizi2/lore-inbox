Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVGZUo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGZUo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGZUm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:42:56 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:52426 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261912AbVGZUmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:42:21 -0400
Date: Tue, 26 Jul 2005 22:42:19 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH NFS 3/3] Replace nfs_block_bits() with roundup_pow_of_two()
Message-ID: <20050726204219.GA5973@lsrfire.ath.cx>
References: <20050724143640.GA19941@lsrfire.ath.cx> <1122246549.8322.3.camel@lade.trondhjem.org> <1122247463.8322.19.camel@lade.trondhjem.org> <20050725155611.GA12856@lsrfire.ath.cx> <1122400127.6894.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122400127.6894.32.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 01:48:46PM -0400, Trond Myklebust wrote:
> I really don't like the choice of name. If you feel you must change the
> name, then make it something like nfs_blocksize_align(). That describes
> its function, instead of the implementation details.

Yes, rounddown_pow_of_two() belongs in kernel.h next to
roundup_pow_of_two().  And maybe it should get a shorter name.

Anyway, I also don't like "nfs_blocksize_align".  So let's simply keep
the old name.  Renaming can be done later if really needed.

Rene


[PATCH 3/3] Simplify nfs_block_bits()

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 fs/nfs/inode.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

ddad5eadf4c2907842bf9baa2610e0a35ea14137
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -189,16 +189,8 @@ nfs_umount_begin(struct super_block *sb)
 static inline unsigned long
 nfs_block_bits(unsigned long bsize)
 {
-	/* make sure blocksize is a power of two */
-	if (bsize & (bsize - 1)) {
-		unsigned char	nrbits;
-
-		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits)); nrbits--)
-			;
-		bsize = 1 << nrbits;
-	}
-
-	return bsize;
+	/* round down to the nearest power of two */
+	return bsize ? (1UL << (fls(bsize) - 1)) : 0;
 }
 
 /*
