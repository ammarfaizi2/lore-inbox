Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVATTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVATTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVATTJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:09:23 -0500
Received: from rev.193.226.232.13.euroweb.hu ([193.226.232.13]:56999 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261836AbVATTGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:06:42 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - fix llseek on device
Message-Id: <E1CrhdR-0006h3-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Jan 2005 20:06:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch makes llseek behave properly on the FUSE device

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-rc1-mm2/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.11-rc1-mm2/fs/fuse/dev.c	2005-01-20 09:30:15.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-01-20 20:01:50.000000000 +0100
@@ -784,6 +784,7 @@ static int fuse_dev_release(struct inode
 
 struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.read		= fuse_dev_read,
 	.readv		= fuse_dev_readv,
 	.write		= fuse_dev_write,
