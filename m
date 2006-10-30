Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWJ3Qbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWJ3Qbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWJ3Qbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:31:46 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:58052 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965095AbWJ3Qbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:31:46 -0500
From: Daniel Drake <ddrake@brontes3d.com>
To: shaggy@austin.ibm.com
Cc: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: Add splice support
Message-Id: <20061030163148.2412D7B40A0@zog.reactivated.net>
Date: Mon, 30 Oct 2006 16:31:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the splice() and tee() syscalls to be used with JFS.

Signed-off-by: Daniel Drake <ddrake@brontes3d.com>

Index: linux-2.6.19-rc3/fs/jfs/file.c
===================================================================
--- linux-2.6.19-rc3.orig/fs/jfs/file.c
+++ linux-2.6.19-rc3/fs/jfs/file.c
@@ -109,6 +109,8 @@ const struct file_operations jfs_file_op
 	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= generic_file_splice_write,
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
 	.ioctl		= jfs_ioctl,
