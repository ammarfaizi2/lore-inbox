Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278495AbRJPCEH>; Mon, 15 Oct 2001 22:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278496AbRJPCD6>; Mon, 15 Oct 2001 22:03:58 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:15789 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S278495AbRJPCDs>;
	Mon, 15 Oct 2001 22:03:48 -0400
Message-ID: <3BCB94E4.AB6703D9@sun.com>
Date: Mon, 15 Oct 2001 19:01:08 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: [PATCH] fix NFS root in 2.4.12
Content-Type: multipart/mixed;
 boundary="------------96330A03D885CB4ED39488B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------96330A03D885CB4ED39488B6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus, Alan,

This one liner fixes NFS root for kernel 2.4.12.  Please apply.

Thanks

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------96330A03D885CB4ED39488B6
Content-Type: text/plain; charset=us-ascii;
 name="nfsroot.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfsroot.diff"

diff -ruN dist-2.4.12+patches/fs/super.c cvs-2.4.12+patches/fs/super.c
--- dist-2.4.12+patches/fs/super.c	Mon Oct 15 10:23:02 2001
+++ cvs-2.4.12+patches/fs/super.c	Mon Oct 15 10:23:02 2001
@@ -935,7 +935,7 @@
 	data = nfs_root_data();
 	if (!data)
 		goto no_nfs;
-	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", data);
+	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", NULL, data);
 	if (!IS_ERR(vfsmnt)) {
 		printk ("VFS: Mounted root (%s filesystem).\n", "nfs");
 		ROOT_DEV = vfsmnt->mnt_sb->s_dev;

--------------96330A03D885CB4ED39488B6--

