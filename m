Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264268AbUEDIt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUEDIt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbUEDIt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:49:59 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.125.5]:2317 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264268AbUEDIt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:49:56 -0400
Date: Tue, 4 May 2004 10:43:02 +0200 (CEST)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.6-rc3 + cset-20040503_1619 = umsdos error
Message-ID: <Pine.LNX.4.58L.0405041038430.31773@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I try to build 2.6.6-rc3 and cset-20040503_1619 and got error:
  CC [M]  fs/umsdos/rdir.o
fs/umsdos/rdir.c: In function `umsdos_rlookup_x':
fs/umsdos/rdir.c:105: warning: implicit declaration of function `msdos_lookup'
fs/umsdos/rdir.c:105: warning: assignment makes pointer from integer without a cast
fs/umsdos/rdir.c: In function `UMSDOS_rrmdir':
fs/umsdos/rdir.c:173: warning: implicit declaration of function `msdos_rmdir'
fs/umsdos/rdir.c:186: warning: implicit declaration of function `msdos_unlink'
fs/umsdos/rdir.c: At top level:
fs/umsdos/rdir.c:242: error: `msdos_create' undeclared here (not in a function)
fs/umsdos/rdir.c:242: error: initializer element is not constant
fs/umsdos/rdir.c:242: error: (near initialization for `umsdos_rdir_inode_operations.create')
fs/umsdos/rdir.c:244: error: `msdos_unlink' undeclared here (not in a function)
fs/umsdos/rdir.c:244: error: initializer element is not constant
fs/umsdos/rdir.c:244: error: (near initialization for `umsdos_rdir_inode_operations.unlink')
fs/umsdos/rdir.c:245: error: `msdos_mkdir' undeclared here (not in a function)
fs/umsdos/rdir.c:245: error: initializer element is not constant
fs/umsdos/rdir.c:245: error: (near initialization for `umsdos_rdir_inode_operations.mkdir')
fs/umsdos/rdir.c:247: error: `msdos_rename' undeclared here (not in a function)
fs/umsdos/rdir.c:247: error: initializer element is not constant
fs/umsdos/rdir.c:247: error: (near initialization for `umsdos_rdir_inode_operations.rename')
make[1]: *** [fs/umsdos/rdir.o] Error 1
make: *** [fs/umsdos] Error 2

When I add this patch:
==============
--- linux-2.6.6-rc3/include/linux/umsdos_fs.p.org	2004-05-04 09:38:44.000000000 +0200
+++ linux-2.6.6-rc3/include/linux/umsdos_fs.p	2004-05-04 09:35:31.000000000 +0200
@@ -96,3 +96,8 @@
 /* rdir.c 22/03/95 03.31.42 */
 struct dentry *umsdos_rlookup_x (struct inode *dir, struct dentry *dentry, int nopseudo);
 struct dentry *UMSDOS_rlookup (struct inode *dir, struct dentry *dentry, struct nameidata *nd);
+
+int msdos_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd);
+int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode);
+int msdos_unlink(struct inode *dir, struct dentry *dentry);
+int msdos_rename(struct inode *old_dir, struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry);
=============
Module build OK, but some symbols are undefined ...
msdos_lookup, msdos_create, msdos_rename, msdos_mkdir, msdos_rmdir, 
msdos_unlink

					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
