Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTBLC4D>; Tue, 11 Feb 2003 21:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbTBLC4C>; Tue, 11 Feb 2003 21:56:02 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:9737 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S266069AbTBLCzo>; Tue, 11 Feb 2003 21:55:44 -0500
Date: Tue, 11 Feb 2003 20:41:27 -0600
From: Art Haas <ahaas@airmail.net>
To: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Convert fs/nfsctl.c to use C99 named initiailzers
Message-ID: <20030212024127.GA914@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch converts the file to use C99 named initializers.
These change make the file compile with fewer warnings if '-W' is added
to the compile flags, and may enhance code readability. Let me know if
you think this should be sent to Linus.

Art Haas

===== fs/nfsctl.c 1.5 vs edited =====
--- 1.5/fs/nfsctl.c	Sun Jan  5 17:19:30 2003
+++ edited/fs/nfsctl.c	Tue Feb 11 09:38:42 2003
@@ -54,13 +54,36 @@
 static struct {
 	char *name; int wsize; int rsize;
 } map[] = {
-	[NFSCTL_SVC]={".svc", sizeof(struct nfsctl_svc)},
-	[NFSCTL_ADDCLIENT]={".add", sizeof(struct nfsctl_client)},
-	[NFSCTL_DELCLIENT]={".del", sizeof(struct nfsctl_client)},
-	[NFSCTL_EXPORT]={".export", sizeof(struct nfsctl_export)},
-	[NFSCTL_UNEXPORT]={".unexport", sizeof(struct nfsctl_export)},
-	[NFSCTL_GETFD]={".getfd", sizeof(struct nfsctl_fdparm), NFS_FHSIZE},
-	[NFSCTL_GETFS]={".getfs", sizeof(struct nfsctl_fsparm), sizeof(struct knfsd_fh)},
+	[NFSCTL_SVC] = {
+		.name	= ".svc",
+		.wsize	= sizeof(struct nfsctl_svc)
+	},
+	[NFSCTL_ADDCLIENT] = {
+		.name	= ".add",
+		.wsize	= sizeof(struct nfsctl_client)
+	},
+	[NFSCTL_DELCLIENT] = {
+		.name	= ".del",
+		.wsize	= sizeof(struct nfsctl_client)
+	},
+	[NFSCTL_EXPORT] = {
+		.name	= ".export",
+		.wsize	= sizeof(struct nfsctl_export)
+	},
+	[NFSCTL_UNEXPORT] = {
+		.name	= ".unexport",
+		.wsize	= sizeof(struct nfsctl_export)
+	},
+	[NFSCTL_GETFD] = {
+		.name	= ".getfd",
+		.wsize	= sizeof(struct nfsctl_fdparm),
+		.rsize	= NFS_FHSIZE
+	},
+	[NFSCTL_GETFS] = {
+		.name	= ".getfs",
+		.wsize	= sizeof(struct nfsctl_fsparm),
+		.rsize	= sizeof(struct knfsd_fh)
+	},
 };
 
 long
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
