Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbTATBZy>; Sun, 19 Jan 2003 20:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbTATBZy>; Sun, 19 Jan 2003 20:25:54 -0500
Received: from mons.uio.no ([129.240.130.14]:30606 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267027AbTATBZx>;
	Sun, 19 Jan 2003 20:25:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15915.21051.365166.964932@charged.uio.no>
Date: Mon, 20 Jan 2003 02:34:51 +0100
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: problems with nfs-server in 2.5 bk as of 030115
In-Reply-To: <1043012373.7986.94.camel@tux.rsn.bth.se>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:

     > I've mounted the rpc_pipefs filesystem and the directory
     > portmap/clntcfac0540 is created. It's empty but created.  It
     > gets created with 500 as permissions.

Ah... Can this be the same problem as before? Try this...

Cheers,
  Trond

--- linux-2.5.59-00-fix/net/sunrpc/rpc_pipe.c.orig	2003-01-14 16:29:23.000000000 +0100
+++ linux-2.5.59-00-fix/net/sunrpc/rpc_pipe.c	2003-01-20 02:30:38.000000000 +0100
@@ -549,7 +549,7 @@
 {
 	struct inode *inode;
 
-	inode = rpc_get_inode(dir->i_sb, S_IFDIR | S_IRUSR | S_IXUSR);
+	inode = rpc_get_inode(dir->i_sb, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		goto out_err;
 	inode->i_ino = iunique(dir->i_sb, 100);
