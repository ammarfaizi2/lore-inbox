Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262939AbTCKPAY>; Tue, 11 Mar 2003 10:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262940AbTCKPAY>; Tue, 11 Mar 2003 10:00:24 -0500
Received: from angband.namesys.com ([212.16.7.85]:42640 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262939AbTCKPAX>; Tue, 11 Mar 2003 10:00:23 -0500
Date: Tue, 11 Mar 2003 18:11:05 +0300
From: Oleg Drokin <green@namesys.com>
To: trond.myklebust@fys.uio.no, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: [2.5] memleak in fs/nfs/inode.c::nfs_get_sb()
Message-ID: <20030311181105.A3232@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is trivial memleak on error exit path in nfs get_sb function.
   See the patch.
   Found with the help of smatch + enhanced unfree script.

Bye,
    Oleg

===== fs/nfs/inode.c 1.72 vs edited =====
--- 1.72/fs/nfs/inode.c	Thu Feb 13 15:57:46 2003
+++ edited/fs/nfs/inode.c	Tue Mar 11 18:03:07 2003
@@ -1231,6 +1231,7 @@
 
 	if (root->size > sizeof(root->data)) {
 		printk("nfs_get_sb: invalid root filehandle\n");
+		kfree(server);
 		return ERR_PTR(-EINVAL);
 	}
 	/* We now require that the mount process passes the remote address */
