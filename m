Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbWJ3UGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbWJ3UGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWJ3UFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:05:52 -0500
Received: from mail.parknet.jp ([210.171.160.80]:48135 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1161438AbWJ3UFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:15 -0500
X-AuthUser: hirofumi@parknet.jp
To: akpm@osdl.org, miklos@szeredi.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fuse: ->readpages() cleanup
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 31 Oct 2006 05:05:11 +0900
Message-ID: <87wt6hlgco.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just ignore the remaining pages.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fuse/file.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff -puN fs/fuse/file.c~readpages-fixes-fuse fs/fuse/file.c
--- linux-2.6/fs/fuse/file.c~readpages-fixes-fuse	2006-10-31 04:26:17.000000000 +0900
+++ linux-2.6-hirofumi/fs/fuse/file.c	2006-10-31 04:26:17.000000000 +0900
@@ -397,14 +397,14 @@ static int fuse_readpages(struct file *f
 
 	err = -EIO;
 	if (is_bad_inode(inode))
-		goto clean_pages_up;
+		goto out;
 
 	data.file = file;
 	data.inode = inode;
 	data.req = fuse_get_req(fc);
 	err = PTR_ERR(data.req);
 	if (IS_ERR(data.req))
-		goto clean_pages_up;
+		goto out;
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
 	if (!err) {
@@ -413,10 +413,7 @@ static int fuse_readpages(struct file *f
 		else
 			fuse_put_request(fc, data.req);
 	}
-	return err;
-
-clean_pages_up:
-	put_pages_list(pages);
+out:
 	return err;
 }
 
_
