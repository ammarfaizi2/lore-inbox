Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275415AbTHIVlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275416AbTHIVlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:41:24 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:40925 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S275415AbTHIVlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:41:21 -0400
Date: Sat, 9 Aug 2003 23:41:16 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20030809214116.GA14409@spaans.vs19.net>
References: <shsisp7fzkg.fsf@charged.uio.no> <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org> <20030809004559.GA17257@spaans.vs19.net> <20030809195607.GA8171@spaans.vs19.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20030809195607.GA8171@spaans.vs19.net>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: Re: [PATCH] Fix up fs/nfs/inode.c wrt flavo[u]r, try 2
Content-Type: text/plain; charset=iso-8859-15
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, something went wrong here while exporting. Inline not wrapped etc bk
patch follows, and if someone has seen my brown paper bag, please tell me. I
think I lost it at friday's mud fight.


 fs/nfs/inode.c             |   18 +++++++++---------
 include/linux/nfs4_mount.h |    4 ++--
 include/linux/nfs_mount.h  |    2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1149  -> 1.1151 
#	include/linux/nfs_mount.h	1.4     -> 1.5    
#	include/linux/nfs4_mount.h	1.1     -> 1.2    
#	      fs/nfs/inode.c	1.84    -> 1.86   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/09	jasper@vs19.net	1.1150
# Change spelling of flavour to flavor in fs/nfs/inode.c and the headers this file includes
# 
# This prevents any confusion that might arise because both spellings are used in the same source file.
# --------------------------------------------
# 03/08/09	jasper@vs19.net	1.1151
# fs/nfs/inode.c cleanup: correct once more
# --------------------------------------------
#
diff -Nru a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c	Sat Aug  9 23:34:27 2003
+++ b/fs/nfs/inode.c	Sat Aug  9 23:34:27 2003
@@ -478,7 +478,7 @@
 	}
 
 	/* Fill in pseudoflavor for mount version < 5 */
-	if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
+	if (!(data->flags & NFS_MOUNT_SECFLAVOR))
 		data->pseudoflavor = RPC_AUTH_UNIX;
 	authflavor = data->pseudoflavor;	/* save for sb_init() */
 	/* XXX maybe we want to add a server->pseudoflavor field */
@@ -1296,7 +1296,7 @@
 			memcpy(root->data, data->old_root.data, NFS2_FHSIZE);
 		}
 		if (data->version < 5)
-			data->flags &= ~NFS_MOUNT_SECFLAVOUR;
+			data->flags &= ~NFS_MOUNT_SECFLAVOR;
 	}
 
 	if (root->size > sizeof(root->data)) {
@@ -1354,7 +1354,7 @@
 	struct rpc_xprt *xprt = NULL;
 	struct rpc_clnt *clnt = NULL;
 	struct rpc_timeout timeparms;
-	rpc_authflavor_t authflavour;
+	rpc_authflavor_t authflavor;
 	int proto, err = -EIO;
 
 	sb->s_blocksize_bits = 0;
@@ -1407,17 +1407,17 @@
 		goto out_fail;
 	}
 
-	authflavour = RPC_AUTH_UNIX;
-	if (data->auth_flavourlen != 0) {
-		if (data->auth_flavourlen > 1)
+	authflavor = RPC_AUTH_UNIX;
+	if (data->auth_flavorlen != 0) {
+		if (data->auth_flavorlen > 1)
 			printk(KERN_INFO "NFS: cannot yet deal with multiple auth flavours.\n");
-		if (copy_from_user(&authflavour, data->auth_flavours, sizeof(authflavour))) {
+		if (copy_from_user(&authflavor, data->auth_flavors, sizeof(authflavor))) {
 			err = -EFAULT;
 			goto out_fail;
 		}
 	}
 	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				 server->rpc_ops->version, authflavour);
+				 server->rpc_ops->version, authflavor);
 	if (clnt == NULL) {
 		printk(KERN_WARNING "NFS: cannot create RPC client.\n");
 		xprt_destroy(xprt);
@@ -1441,7 +1441,7 @@
 	if ((server->idmap = nfs_idmap_new(server)) == NULL)
 		printk(KERN_WARNING "NFS: couldn't start IDmap\n");
 
-	err = nfs_sb_init(sb, authflavour);
+	err = nfs_sb_init(sb, authflavor);
 	if (err == 0)
 		return 0;
 	rpciod_down();
diff -Nru a/include/linux/nfs4_mount.h b/include/linux/nfs4_mount.h
--- a/include/linux/nfs4_mount.h	Sat Aug  9 23:34:27 2003
+++ b/include/linux/nfs4_mount.h	Sat Aug  9 23:34:27 2003
@@ -51,8 +51,8 @@
 	int proto;				/* 1 */
 
 	/* Pseudo-flavours to use for authentication. See RFC2623 */
-	int auth_flavourlen;			/* 1 */
-	int *auth_flavours;			/* 1 */
+	int auth_flavorlen;			/* 1 */
+	int *auth_flavors;			/* 1 */
 };
 
 /* bits in the flags field */
diff -Nru a/include/linux/nfs_mount.h b/include/linux/nfs_mount.h
--- a/include/linux/nfs_mount.h	Sat Aug  9 23:34:27 2003
+++ b/include/linux/nfs_mount.h	Sat Aug  9 23:34:27 2003
@@ -57,7 +57,7 @@
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
-#define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
+#define NFS_MOUNT_SECFLAVOR	0x2000	/* 5 */
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif



VrGr,
-- 
Jasper Spaans               http://jsp.vs19.net/contact/
