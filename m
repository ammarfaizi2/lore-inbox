Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTFMF31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 01:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTFMF31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 01:29:27 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:14219 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265144AbTFMF3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:29:25 -0400
Date: Thu, 12 Jun 2003 22:42:28 -0700
From: "H. J. Lu" <hjl@lucon.org>
Subject: PATCH: 2.5.70: Export set_fs_root and set_fs_pwd
To: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <20030613054228.GA27470@lucon.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_uFYAekaFXHMWJy/fGOELLA)"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_uFYAekaFXHMWJy/fGOELLA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

In 2.5.70, intermezzo fs can be configured as module. But intermezzo
references set_fs_root and set_fs_pwd:

# find -name *.[ch] | xargs grep set_fs_root
./include/linux/fs_struct.h:extern void set_fs_root(struct fs_struct *, struct
vfsmount *, struct dentry *);
./fs/intermezzo/intermezzo_fs.h:                set_fs_root(current->fs,
new->rootmnt, new->root);
./fs/intermezzo/intermezzo_fs.h:                set_fs_root(current->fs,
saved->rootmnt, saved->root);
./fs/open.c:    set_fs_root(current->fs, nd.mnt, nd.dentry);
./fs/namespace.c:void set_fs_root(struct fs_struct *fs, struct vfsmount *mnt,
./fs/namespace.c:                               set_fs_root(fs, new_nd->mnt,
new_nd->dentry);
./fs/namespace.c:       set_fs_root(current->fs, namespace->root,
namespace->root->mnt_root);

They should be exported.


H.J.


--Boundary_(ID_uFYAekaFXHMWJy/fGOELLA)
Content-type: text/plain; charset=us-ascii; NAME=fs.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=fs.patch

--- linux/fs/namespace.c.fs	Thu Jun 12 09:13:28 2003
+++ linux/fs/namespace.c	Thu Jun 12 15:13:03 2003
@@ -1138,3 +1138,6 @@ void __init mnt_init(unsigned long mempa
 	init_rootfs();
 	init_mount_tree();
 }
+
+EXPORT_SYMBOL(set_fs_root);
+EXPORT_SYMBOL(set_fs_pwd);

--Boundary_(ID_uFYAekaFXHMWJy/fGOELLA)--
