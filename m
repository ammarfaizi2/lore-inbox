Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRBSXMj>; Mon, 19 Feb 2001 18:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129285AbRBSXMa>; Mon, 19 Feb 2001 18:12:30 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:40560 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129284AbRBSXMS>; Mon, 19 Feb 2001 18:12:18 -0500
Date: Mon, 19 Feb 2001 18:12:12 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: <linux-kernel@vger.kernel.org>
cc: <alan@redhat.com>
Subject: [PATCH] make nfsroot accept server addresses from BOOTP root
Message-ID: <Pine.LNX.4.30.0102191809350.27085-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's a handy little patch that makes the kernel parse out the ip
address of the nfs server from the bootp root path.  Otherwise it's
impossible to boot the kernel without command line options on diskless
workstations (I hate RPL).

		-ben

diff -ur v2.4.1-ac18/fs/nfs/nfsroot.c work/fs/nfs/nfsroot.c
--- v2.4.1-ac18/fs/nfs/nfsroot.c	Mon Sep 25 16:13:53 2000
+++ work/fs/nfs/nfsroot.c	Mon Feb 19 18:05:24 2001
@@ -224,8 +224,7 @@
 		}
 	}
 	if (name[0] && strcmp(name, "default")) {
-		strncpy(buf, name, NFS_MAXPATHLEN-1);
-		buf[NFS_MAXPATHLEN-1] = 0;
+		root_nfs_parse_addr(name);
 	}
 }


