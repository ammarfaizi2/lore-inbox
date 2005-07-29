Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVG2TSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVG2TSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVG2TQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:16:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:32686 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262709AbVG2TPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:03 -0400
Date: Fri, 29 Jul 2005 12:14:19 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: [patch 03/29] sysfs: fix sysfs_setattr
Message-ID: <20050729191419.GE5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Maneesh Soni <maneesh@in.ibm.com>

o sysfs_dirent's s_mode field should also be updated in sysfs_setattr(), else
  there could be inconsistency in the two fields. s_mode is used while
  ->readdir so as not to bring in the inode to cache.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/sysfs/inode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/fs/sysfs/inode.c	2005-07-29 11:30:03.000000000 -0700
+++ gregkh-2.6/fs/sysfs/inode.c	2005-07-29 11:33:53.000000000 -0700
@@ -85,7 +85,7 @@
 
 		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
 			mode &= ~S_ISGID;
-		sd_iattr->ia_mode = mode;
+		sd_iattr->ia_mode = sd->s_mode = mode;
 	}
 
 	return error;

--
