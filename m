Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVKNUTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVKNUTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKNUTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:19:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:58822 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932092AbVKNUTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:33 -0500
Date: Mon, 14 Nov 2005 12:05:47 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp
Subject: [patch 07/12] usbfs: usbfs_dir_inode_operations cleanup
Message-ID: <20051114200547.GH2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usbfs_dir_inode_operations-cleanup.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

This patch is just cleanup.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/inode.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/inode.c	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/core/inode.c	2005-11-02 12:02:53.000000000 -0800
@@ -46,7 +46,6 @@
 
 static struct super_operations usbfs_ops;
 static struct file_operations default_file_operations;
-static struct inode_operations usbfs_dir_inode_operations;
 static struct vfsmount *usbfs_mount;
 static int usbfs_mount_count;	/* = 0 */
 static int ignore_mount = 0;
@@ -262,7 +261,7 @@
 			inode->i_fop = &default_file_operations;
 			break;
 		case S_IFDIR:
-			inode->i_op = &usbfs_dir_inode_operations;
+			inode->i_op = &simple_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -417,10 +416,6 @@
 	.llseek =	default_file_lseek,
 };
 
-static struct inode_operations usbfs_dir_inode_operations = {
-	.lookup =	simple_lookup,
-};
-
 static struct super_operations usbfs_ops = {
 	.statfs =	simple_statfs,
 	.drop_inode =	generic_delete_inode,

--
