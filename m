Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUBEP7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUBEP7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:59:30 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:47051 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265292AbUBEP7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:59:03 -0500
Subject: [patch][selinux] Allow non-root processes to read selinuxfs
	enforce node
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1075996731.5775.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 05 Feb 2004 10:58:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.2-mm1 changes the mode bits on the selinuxfs
enforce node so that non-root processes can read it.  This is necessary
to allow non-root userspace policy enforcers to check the enforcing flag
upon a permission failure as well.  A process must still have the
appropriate SELinux permission in order to read the node.  Please apply.

 security/selinux/selinuxfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.32
diff -u -r1.32 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	3 Oct 2003 20:01:16 -0000	1.32
+++ linux-2.6/security/selinux/selinuxfs.c	5 Feb 2004 13:35:49 -0000
@@ -603,7 +603,7 @@
 {
 	static struct tree_descr selinux_files[] = {
 		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
-		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUSR|S_IWUSR},
+		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUGO|S_IWUSR},
 		[SEL_CONTEXT] = {"context", &sel_context_ops, S_IRUGO|S_IWUGO},
 		[SEL_ACCESS] = {"access", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

