Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWFTRxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFTRxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWFTRxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:53:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52386 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWFTRxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:53:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ePeODGmwulpG/eboYRo1aH7c2j3hUSQp1YGHx0dU6Zwngwarfim0DtfWMT28pm2v392aABPvv8feuvtowsGdUhAI1SDAybyKXqGiym/HZPHslQmseWCBoADfEHL8wYOIj0fGxnqoOgjxdj0Z30KqBrsNWnnTQ62Wxa4SPB7sikY=
Date: Tue, 20 Jun 2006 21:53:08 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] nfs: remove nfs_put_link()
Message-ID: <20060620175308.GA8633@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/nfs/symlink.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -75,22 +75,13 @@ read_failed:
 	return NULL;
 }
 
-static void nfs_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
-{
-	if (cookie) {
-		struct page *page = cookie;
-		kunmap(page);
-		page_cache_release(page);
-	}
-}
-
 /*
  * symlinks can't do much...
  */
 struct inode_operations nfs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= nfs_follow_link,
-	.put_link	= nfs_put_link,
+	.put_link	= page_put_link,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 };

