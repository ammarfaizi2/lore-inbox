Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTBCJxy>; Mon, 3 Feb 2003 04:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTBCJxy>; Mon, 3 Feb 2003 04:53:54 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:1997 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S262201AbTBCJxx>;
	Mon, 3 Feb 2003 04:53:53 -0500
Date: Mon, 3 Feb 2003 11:03:24 +0100
From: Eric Lammerts <eric@lammerts.org>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nfsroot port= parameter fix
Message-ID: <20030203100324.GA11011@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
When I specify the NFS port for nfsroot (e.g., nfsroot=<dir>,port=2049), the
kernel uses the wrong port. In my case it tries to use 264 (0x108) instead
of 2049 (0x801).

This patch adds the missing htons().

Eric

--- linux-2.4.21-pre4/fs/nfs/nfsroot.c.orig	Mon Feb  3 10:11:10 2003
+++ linux-2.4.21-pre4/fs/nfs/nfsroot.c	Mon Feb  3 10:28:35 2003
@@ -384,10 +384,11 @@
 					"number from server, using default\n");
 			port = nfsd_port;
 		}
-		nfs_port = htons(port);
+		nfs_port = port;
 		dprintk("Root-NFS: Portmapper on server returned %d "
 			"as nfsd port\n", port);
 	}
+	nfs_port = htons(nfs_port);
 
 	if ((port = root_nfs_getport(NFS_MNT_PROGRAM, mountd_ver, proto)) < 0) {
 		printk(KERN_ERR "Root-NFS: Unable to get mountd port "


