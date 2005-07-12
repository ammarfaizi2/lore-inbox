Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVGLMbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVGLMbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVGLMbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:31:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31384 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261412AbVGLMat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:30:49 -0400
Date: Tue, 12 Jul 2005 17:59:09 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: gregkh@suse.de
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sysfs: fix sysfs_setattr
Message-ID: <20050712122908.GC5971@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050712122813.GB5971@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712122813.GB5971@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o sysfs_dirent's s_mode field should also be updated in sysfs_setattr(), else
  there could be inconsistency in the two fields. s_mode is used while
  ->readdir so as not to bring in the inode to cache.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.13-rc2-maneesh/fs/sysfs/inode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/sysfs/inode.c~fix-sysfs_setattr-update-s_mode fs/sysfs/inode.c
--- linux-2.6.13-rc2/fs/sysfs/inode.c~fix-sysfs_setattr-update-s_mode	2005-07-12 11:24:56.341493928 +0530
+++ linux-2.6.13-rc2-maneesh/fs/sysfs/inode.c	2005-07-12 11:24:56.347493016 +0530
@@ -85,7 +85,7 @@ int sysfs_setattr(struct dentry * dentry
 
 		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
 			mode &= ~S_ISGID;
-		sd_iattr->ia_mode = mode;
+		sd_iattr->ia_mode = sd->s_mode = mode;
 	}
 
 	return error;
_
-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
