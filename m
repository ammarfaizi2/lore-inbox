Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWBVO4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWBVO4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWBVO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:56:54 -0500
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:9683 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751306AbWBVO4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:56:53 -0500
Date: Wed, 22 Feb 2006 09:56:51 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] selinuxfs cleanups - sel_make_avc_files
In-Reply-To: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
Message-ID: <Pine.LNX.4.64.0602220956040.30349@excalibur.intercode>
References: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copy & paste error in sel_make_avc_files(), removing a supurious call 
to d_genocide() in the error path.  All of this will be cleaned up by 
kill_litter_super().

Please apply.


Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


---

 security/selinux/selinuxfs.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff -purN -X dontdiff linux-2.6.16-rc4.p/security/selinux/selinuxfs.c linux-2.6.16-rc4.w/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4.p/security/selinux/selinuxfs.c	2006-02-21 20:34:04.000000000 -0500
+++ linux-2.6.16-rc4.w/security/selinux/selinuxfs.c	2006-02-21 20:34:40.000000000 -0500
@@ -1168,22 +1168,19 @@ static int sel_make_avc_files(struct den
 		dentry = d_alloc_name(dir, files[i].name);
 		if (!dentry) {
 			ret = -ENOMEM;
-			goto err;
+			goto out;
 		}
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
 		if (!inode) {
 			ret = -ENOMEM;
-			goto err;
+			goto out;
 		}
 		inode->i_fop = files[i].ops;
 		d_add(dentry, inode);
 	}
 out:
 	return ret;
-err:
-	d_genocide(dir);
-	goto out;
 }
 
 static int sel_make_dir(struct super_block *sb, struct dentry *dentry)
