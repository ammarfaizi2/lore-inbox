Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUIWFWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUIWFWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUIWFWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:22:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12263 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268281AbUIWFWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:22:21 -0400
Date: Thu, 23 Sep 2004 01:22:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][SELINUX] Allow all filesystems to specify fscreate mount
 option
Message-ID: <Xine.LNX.4.44.0409230113560.697-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below allows all types of filesystems to specify the fscreate 
mount option (which is used to specify the security context of the 
filesystem itself).  This was previously only available for filesystems 
with full xattr security labeling, but is also potentially required for 
filesystems with e.g. psuedo xattr labeling such as devpts and tmpfs.

An example of use is to specify at mount time the fs security context of a 
tmpfs filesystem, overriding the default specified in policy for that 
filesystem.

This patch has been in the Fedora kernel for some weeks with no problems.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.8.1.o/security/selinux/hooks.c linux-2.6.8.1.w/security/selinux/hooks.c
--- linux-2.6.8.1.o/security/selinux/hooks.c	2004-08-14 10:25:45.000000000 -0400
+++ linux-2.6.8.1.w/security/selinux/hooks.c	2004-08-24 23:30:37.000000000 -0400
@@ -386,13 +386,6 @@ static int try_context_mount(struct supe
 				break;
 
 			case Opt_fscontext:
-				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
-					rc = -EINVAL;
-					printk(KERN_WARNING "SELinux:  "
-					       "fscontext option is invalid for"
-					       " this filesystem type\n");
-					goto out_free;
-				}
 				if (seen & (Opt_context|Opt_fscontext)) {
 					rc = -EINVAL;
 					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);



