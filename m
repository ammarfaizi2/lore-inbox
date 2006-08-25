Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422807AbWHYBFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWHYBFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 21:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWHYBFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 21:05:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:9577 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422806AbWHYBFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 21:05:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=kEjrZ0Q//aD6g7/pVzmB3L6m8OfKsJvQ37v4+PvJHAVIVWFiXavoKE4qqomfAQBTtb0pWlQm0CYMN0ex2UJfkzMMHsMOPLwk6AwrqQts/hi2a067vPGVAJxZn73W+gkx9HBxcumWexMM7OQCuF+5SHm50n+KIEzkOJ4MOX+SKmc=
Date: Fri, 25 Aug 2006 05:05:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Ban register_filesystem(NULL);
Message-ID: <20060825010536.GI5204@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone passes valid pointer there.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/filesystems.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -69,8 +69,6 @@ int register_filesystem(struct file_syst
 	int res = 0;
 	struct file_system_type ** p;
 
-	if (!fs)
-		return -EINVAL;
 	if (fs->next)
 		return -EBUSY;
 	INIT_LIST_HEAD(&fs->fs_supers);

