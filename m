Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbULCEGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbULCEGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 23:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbULCEGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 23:06:01 -0500
Received: from [61.48.52.229] ([61.48.52.229]:46065 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261934AbULCEFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 23:05:55 -0500
Date: Thu, 2 Dec 2004 19:56:28 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412030356.iB33uSg03460@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: [Fake patch] Make sysfs_dirent.s_type an unsigned short
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is a fake patch against my heavily hacked sysfs tree
to change sysfs_dirent.s_type from an int to an unsigned short.
It appears next to another unsigned short (s_mode), so it should
save 4 bytes per sysfs node.

	Note that this patch will not apply to a pristine 2.6.10-rc2-bk15
tree, because I've moved the declaration of struct sysfs_dirent
from include/linux/sysfs.h to fs/sysfs/sysfs.h in a previous patch.

	By the way, I have to sheepishly admit that somehow I previously
underestimated the size of struct sysfs_dirent.  Only now
with s_children and s_count removed and s_type shortened to 16 bits
does sysfs_dirent occupy 32 bytes, according to /proc/slabinfo.
This does not effect my previous statements about how much memory
is saved by each of the patches that I've posted.  It just means
the original amount of memory being used was more.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux.prev/fs/sysfs/sysfs.h	2004-12-03 11:51:19.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-12-03 00:51:44.000000000 +0800
@@ -13,7 +13,7 @@
 struct sysfs_dirent {
 	struct list_head	s_sibling;
 	void 			* s_element;
-	int			s_type;
+	unsigned short		s_type;
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
 };
