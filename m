Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVARKwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVARKwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVARKwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:52:39 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:53457 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261247AbVARKwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:52:35 -0500
Date: Tue, 18 Jan 2005 12:52:56 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: [PATCH 3/5] make common ioctls apply for compat.
Message-ID: <20050118105256.GC23127@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118072133.GB76018@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch is against 2.6.11-rc1-bk5
A piece is copied from Andi's patch, too. No idea if
his SOB should be here too. Here it is just in case.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Andi Kleen <ak@muc.de>

Make common ioctls apply for compat_ioctl.

diff -rup linux-2.6.10-orig/fs/compat_ioctl.c linux-2.6.10-ioctl-sym/fs/compat_ioctl.c
--- linux-2.6.10-orig/fs/compat_ioctl.c	2004-12-24 23:36:01.000000000 +0200
+++ linux-2.6.10-ioctl-sym/fs/compat_ioctl.c	2005-01-18 10:54:31.736650344 +0200
@@ -3165,6 +3165,14 @@ static int do_ncp_setprivatedata(unsigne
 #endif
 
 #ifdef DECLARES
+HANDLE_IOCTL(FIOCLEX,NULL)
+HANDLE_IOCTL(FIONCLEX,NULL)
+HANDLE_IOCTL(FIONBIO,NULL)
+HANDLE_IOCTL(FIOASYNC,NULL)
+HANDLE_IOCTL(FIOQSIZE,NULL)
+HANDLE_IOCTL(FIBMAP,NULL)
+HANDLE_IOCTL(FIGETBSZ,NULL)
+HANDLE_IOCTL(FIONREAD,NULL)
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
 #ifdef CONFIG_NET
diff -rup linux-2.6.10-orig/fs/ioctl.c linux-2.6.10-ioctl-sym/fs/ioctl.c
--- linux-2.6.10-orig/fs/ioctl.c	2005-01-18 10:58:33.609880024 +0200
+++ linux-2.6.10-ioctl-sym/fs/ioctl.c	2005-01-18 10:51:55.690372984 +0200
@@ -77,7 +72,10 @@ static int file_ioctl(struct file *filp,
 	return do_ioctl(filp, cmd, arg);
 }
 
-
+/*
+ * When you add any new common ioctls to the switches above and below
+ * please update compat_ioctl.c too.
+ */
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct file * filp;
