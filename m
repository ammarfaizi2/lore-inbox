Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262451AbSJPNMn>; Wed, 16 Oct 2002 09:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262439AbSJPNMn>; Wed, 16 Oct 2002 09:12:43 -0400
Received: from pat.uio.no ([129.240.130.16]:29642 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262436AbSJPNMm>;
	Wed, 16 Oct 2002 09:12:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15789.26408.851059.191809@charged.uio.no>
Date: Wed, 16 Oct 2002 15:18:32 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Fix NFS typos in 2.5.43...
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes 2 obvious typos. Thanks to davem and George
Anzinger for pointing them out.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.43/fs/nfs/inode.c linux-2.5.43-fixes/fs/nfs/inode.c
--- linux-2.5.43/fs/nfs/inode.c	2002-10-14 12:43:11.000000000 -0400
+++ linux-2.5.43-fixes/fs/nfs/inode.c	2002-10-16 08:44:04.000000000 -0400
@@ -1355,7 +1355,7 @@
 	if (data->auth_flavourlen != 0) {
 		if (data->auth_flavourlen > 1)
 			printk(KERN_INFO "NFS: cannot yet deal with multiple auth flavours.\n");
-		if (copy_from_user(authflavour, data->auth_flavours, sizeof(authflavour))) {
+		if (copy_from_user(&authflavour, data->auth_flavours, sizeof(authflavour))) {
 			err = -EFAULT;
 			goto out_fail;
 		}
diff -u --recursive --new-file linux-2.5.43/fs/nfs/proc.c linux-2.5.43-fixes/fs/nfs/proc.c
--- linux-2.5.43/fs/nfs/proc.c	2002-10-12 19:33:34.000000000 -0400
+++ linux-2.5.43-fixes/fs/nfs/proc.c	2002-10-16 08:44:29.000000000 -0400
@@ -490,7 +490,7 @@
 
 	dprintk("NFS call  fsinfo\n");
 	info->fattr->valid = 0;
-	status = rpc_call(server->client, NFSPROC_STATFS, fhandle, &info, 0);
+	status = rpc_call(server->client, NFSPROC_STATFS, fhandle, &fsinfo, 0);
 	dprintk("NFS reply fsinfo: %d\n", status);
 	if (status)
 		goto out;
