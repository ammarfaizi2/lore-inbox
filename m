Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992834AbWJUHNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992834AbWJUHNW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992837AbWJUHNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:13:21 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:12935 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992832AbWJUHNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:20 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 23] x86_64: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <2d3d311922b0a50f919e.1161411458@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:38 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the x86_64 arch code.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

1 file changed, 4 insertions(+), 4 deletions(-)
arch/x86_64/ia32/ia32_aout.c |    8 ++++----

diff --git a/arch/x86_64/ia32/ia32_aout.c b/arch/x86_64/ia32/ia32_aout.c
--- a/arch/x86_64/ia32/ia32_aout.c
+++ b/arch/x86_64/ia32/ia32_aout.c
@@ -272,7 +272,7 @@ static int load_aout_binary(struct linux
 	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
 	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
 	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    i_size_read(bprm->file->f_dentry->d_inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(bprm->file->f_path.dentry->d_inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
 		return -ENOEXEC;
 	}
 
@@ -357,7 +357,7 @@ static int load_aout_binary(struct linux
 		{
 			printk(KERN_WARNING 
 			       "fd_offset is not page aligned. Please convert program: %s\n",
-			       bprm->file->f_dentry->d_name.name);
+			       bprm->file->f_path.dentry->d_name.name);
 			error_time = jiffies;
 		}
 #endif
@@ -440,7 +440,7 @@ static int load_aout_library(struct file
 	int retval;
 	struct exec ex;
 
-	inode = file->f_dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 
 	retval = -ENOEXEC;
 	error = kernel_read(file, 0, (char *) &ex, sizeof(ex));
@@ -471,7 +471,7 @@ static int load_aout_library(struct file
 		{
 			printk(KERN_WARNING 
 			       "N_TXTOFF is not page aligned. Please convert library: %s\n",
-			       file->f_dentry->d_name.name);
+			       file->f_path.dentry->d_name.name);
 			error_time = jiffies;
 		}
 #endif


