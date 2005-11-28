Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVK1WZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVK1WZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVK1WZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:25:25 -0500
Received: from verein.lst.de ([213.95.11.210]:31884 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932241AbVK1WZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:25:24 -0500
Date: Mon, 28 Nov 2005 23:25:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: [PATCH] remove broken direct I/O size ioctl
Message-ID: <20051128222501.GA7238@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This ioctl tries to second guess direct I/O parameters which aren't
a filesystem drivers business and shouldn't be exposed as an ioctl
to start with.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/xfs/linux-2.6/xfs_ioctl32.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_ioctl32.c	2005-11-18 10:29:41.000000000 +0100
+++ linux-2.6/fs/xfs/linux-2.6/xfs_ioctl32.c	2005-11-28 23:21:39.000000000 +0100
@@ -115,7 +115,6 @@
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 
 	switch (cmd) {
-	case XFS_IOC_DIOINFO:
 	case XFS_IOC_FSGEOMETRY_V1:
 	case XFS_IOC_FSGEOMETRY:
 	case XFS_IOC_GETVERSION:
