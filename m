Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUCIPwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUCIPwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:52:16 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:38530 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262022AbUCIPwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:52:05 -0500
Subject: Re: Problems with 2.6.4-rc2 NFS server and diskless clients
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1078846645.1441.14.camel@newt>
References: <1078846645.1441.14.camel@newt>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1078847522.4067.10.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 10:52:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 09/03/2004 klokka 10:37, skreiv Adrian Cox:
> Using 2.6.4-rc2  on the NFS server together with Debian unstable
> (nfs-kernel-server version 1:1.0.6-1), diskless clients can no longer
> mount their root filesystems. The same configuration works with a 2.4
> kernel on the server.
> 
> The client reports "nfs_get_root: getattr error = 116". No error
> messages appear in the server logs. And the old recipe of exporting with
> "no_subtree_check" makes no difference.
> 
> Anybody have any suggestions?

There's already a patch for that in the Bitkeeper tree.

Cheers

  Trond

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/06 16:11:47-08:00 trond.myklebust@fys.uio.no 
#   [PATCH] Fix knfsd filehandles...
#   
#   Here's a fix for an obvious typo in changeset
#   neilb@cse.unsw.edu.au|ChangeSet|20040305155724|31191
#   that was causing ESTALE errors galore on my NFS testrig.
# 
# fs/nfsd/nfsfh.c
#   2004/03/06 13:46:05-08:00 trond.myklebust@fys.uio.no +1 -0
#   Fix knfsd filehandles...
# 
diff -Nru a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
--- a/fs/nfsd/nfsfh.c	Tue Mar  9 10:51:22 2004
+++ b/fs/nfsd/nfsfh.c	Tue Mar  9 10:51:22 2004
@@ -396,6 +396,7 @@
 				 */
 				mk_fsid_v0(datap, ex_dev,
 					exp->ex_dentry->d_inode->i_ino);
+				break;
 			case 1:
 				/* fsid_type 1 == 4 bytes filesystem id */
 				mk_fsid_v1(datap, exp->ex_fsid);

