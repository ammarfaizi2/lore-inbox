Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264858AbSJPE3u>; Wed, 16 Oct 2002 00:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbSJPE3u>; Wed, 16 Oct 2002 00:29:50 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:59524
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264858AbSJPE3s>; Wed, 16 Oct 2002 00:29:48 -0400
Date: Wed, 16 Oct 2002 00:22:40 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: sfrench@us.ibm.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] CIFS cifsfs.c check kmalloc return
Message-ID: <Pine.LNX.4.44.0210160022030.1460-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.43/fs/cifs/cifsfs.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/cifsfs.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cifsfs.c
--- linux-2.5.43/fs/cifs/cifsfs.c	16 Oct 2002 03:46:04 -0000	1.1.1.1
+++ linux-2.5.43/fs/cifs/cifsfs.c	16 Oct 2002 04:20:34 -0000
@@ -64,8 +64,11 @@
 	struct cifs_sb_info *cifs_sb;
 	int rc = 0;
 
-    sb->s_fs_info = kmalloc(sizeof(struct cifs_sb_info),GFP_KERNEL);
+	sb->s_fs_info = kmalloc(sizeof(struct cifs_sb_info),GFP_KERNEL);
 	cifs_sb = CIFS_SB(sb);
+	if (cifs_sb == NULL)
+		return -ENOMEM;
+
 	cifs_sb->local_nls = load_nls_default();	/* needed for ASCII cp to Unicode converts */
 	rc = cifs_mount(sb, cifs_sb, data, devname);
 

-- 
function.linuxpower.ca

