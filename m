Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTAQJHf>; Fri, 17 Jan 2003 04:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTAQJHf>; Fri, 17 Jan 2003 04:07:35 -0500
Received: from holomorphy.com ([66.224.33.161]:27029 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267441AbTAQJHe>;
	Fri, 17 Jan 2003 04:07:34 -0500
Date: Fri, 17 Jan 2003 01:15:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: fix nfs_writeback_done() warning
Message-ID: <20030117091503.GE940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get complaints about an unused variable "inode". This removes
the variable and open-codes the dereference to data->inode, hence
fixing the warning.


diff -urpN mm1-2.5.59/fs/nfs/write.c numaq-2.5.59/fs/nfs/write.c
--- mm1-2.5.59/fs/nfs/write.c	2003-01-16 18:22:26.000000000 -0800
+++ numaq-2.5.59/fs/nfs/write.c	2003-01-17 01:12:29.000000000 -0800
@@ -829,7 +829,6 @@ nfs_writeback_done(struct rpc_task *task
 	struct nfs_write_data	*data = (struct nfs_write_data *) task->tk_calldata;
 	struct nfs_writeargs	*argp = &data->args;
 	struct nfs_writeres	*resp = &data->res;
-	struct inode		*inode = data->inode;
 	struct nfs_page		*req;
 	struct page		*page;
 
@@ -863,7 +862,7 @@ nfs_writeback_done(struct rpc_task *task
 		if (time_before(complain, jiffies)) {
 			dprintk("NFS: faulty NFS server %s:"
 				" (committed = %d) != (stable = %d)\n",
-				NFS_SERVER(inode)->hostname,
+				NFS_SERVER(data->inode)->hostname,
 				data->verf.committed, argp->stable);
 			complain = jiffies + 300 * HZ;
 		}
