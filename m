Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbTIXOnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbTIXOnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 10:43:45 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:56521 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261284AbTIXOno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 10:43:44 -0400
Subject: [patch] Fix bug in SELinux convert_context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1064414610.20804.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Sep 2003 10:43:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug introduced by earlier code cleanups in the
SELinux convert_context code that manifests upon a policy reload that
removes previously valid security attributes.  Thanks to Magosanyi Arpad
for reporting the bug.

 security/selinux/ss/services.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/security/selinux/ss/services.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/services.c,v
retrieving revision 1.28
diff -u -r1.28 services.c
--- linux-2.6/security/selinux/ss/services.c	17 Jul 2003 11:33:35 -0000	1.28
+++ linux-2.6/security/selinux/ss/services.c	24 Sep 2003 13:08:40 -0000
@@ -896,13 +896,15 @@
 	struct user_datum *usrdatum;
 	char *s;
 	u32 len;
-	int rc = -EINVAL;
+	int rc;
 
 	args = p;
 
 	rc = context_cpy(&oldc, c);
 	if (rc)
 		goto out;
+
+	rc = -EINVAL;
 
 	/* Convert the user. */
 	usrdatum = hashtab_search(args->newp->p_users.table,


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

