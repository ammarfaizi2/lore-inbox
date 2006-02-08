Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWBHDUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWBHDUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbWBHDUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:6529 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030480AbWBHDUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:20:12 -0500
To: torvalds@osdl.org
Subject: [PATCH 28/29] nfsroot port= parameter fix [backport of 2.4 fix]
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fsK-0006Eu-6Y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:20:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1136357057 -0500

Direct backport of 2.4 fix that didn't get propagated to 2.6; original
comment follows:
<quote>
   When I specify the NFS port for nfsroot (e.g.,
   nfsroot=<dir>,port=2049), the
   kernel uses the wrong port. In my case it tries to use 264 (0x108)
   instead
   of 2049 (0x801).

   This patch adds the missing htons().

   Eric
</quote>

Patch got applied in 2.4.21-pre6.  Author: Eric Lammerts (<eric@lammerts.org>,
AFAICS).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/nfs/nfsroot.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

8854eddbdb3e45b8d381ecff2937a942d0cb2067
diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index e897e00..c0a754e 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -465,10 +465,11 @@ static int __init root_nfs_ports(void)
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
-- 
0.99.9.GIT

