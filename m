Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVHLJIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVHLJIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 05:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVHLJIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 05:08:21 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:40067 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbVHLJIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 05:08:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=P4rCZWZq7+Yo7UH+4FgXpupaSgAJMf8gqknMRhIc5Dbf8/kRfZL/hR/0akRLaa1KsK6UvAaLfek0KoVPycIgAjnXuh+nfJEJq+6Kd8Co40UIoUfb41GRAfOsO46klhMr5B6y7TFV2W3jE933olLOM8JTQaVVVmZVFZhmAyGV2rQ=
Date: Fri, 12 Aug 2005 18:08:16 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] fs: remove redundant timespec_equal test in update_atime()
Message-ID: <20050812090815.GA15876@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Alexander Viro.

 In update_atime(), timespec_equal() test is done twice in succession
and the second is always false.  This patch removes the second test.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1195,9 +1195,6 @@ void update_atime(struct inode *inode)
 	if (!timespec_equal(&inode->i_atime, &now)) {
 		inode->i_atime = now;
 		mark_inode_dirty_sync(inode);
-	} else {
-		if (!timespec_equal(&inode->i_atime, &now))
-			inode->i_atime = now;
 	}
 }
 
