Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVARKr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVARKr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVARKr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:47:58 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:52176 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261240AbVARKrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:47:55 -0500
Date: Tue, 18 Jan 2005 12:48:16 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: [PATCH 2/5] socket ioctl fix (from Andi)
Message-ID: <20050118104816.GB23127@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118072133.GB76018@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch is against 2.6.11-rc1-bk5.
It is split out from Andi's big patch.
It is really unchanged so I dont put a signed-off-by here.

Signed-off-by: Andi Kleen <ak@muc.de>

SIOCDEVPRIVATE ioctl command only applies to socket descriptors.

diff -rup linux-2.6.10-orig/fs/compat.c linux-2.6.10-ioctl-sym/fs/compat.c
--- linux-2.6.10-orig/fs/compat.c	2005-01-18 10:58:33.609880024 +0200
+++ linux-2.6.10-ioctl-sym/fs/compat.c	2005-01-18 10:54:26.289478440 +0200
@@ -454,7 +460,8 @@ asmlinkage long compat_sys_ioctl(unsigne
 	}
 	up_read(&ioctl32_sem);
 
-	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
+	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
+	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		error = siocdevprivate_ioctl(fd, cmd, arg);
 	} else {
 		static int count;
