Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUCLT2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUCLT2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:28:06 -0500
Received: from [144.51.25.10] ([144.51.25.10]:10744 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S262370AbUCLT2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:28:03 -0500
Subject: [PATCH][SELINUX] Fix compute_av bug
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Chad Hanson <chanson@tcs-sec.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1079119648.8203.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 12 Mar 2004 14:27:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the SELinux compute_av code; the current code
yields the right access computation but can cause unnecessary (but
harmless) processing to occur when transition permission wasn't granted
in the first place by the TE configuration.  Thanks to Chad Hanson of
TCS for reporting the bug.

 security/selinux/ss/services.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/security/selinux/ss/services.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/services.c,v
retrieving revision 1.34
diff -u -r1.34 services.c
--- linux-2.6/security/selinux/ss/services.c	18 Feb 2004 14:26:06 -0000	1.34
+++ linux-2.6/security/selinux/ss/services.c	12 Mar 2004 13:37:44 -0000
@@ -262,7 +262,7 @@
 	 * pair.
 	 */
 	if (tclass == SECCLASS_PROCESS &&
-	    avd->allowed && PROCESS__TRANSITION &&
+	    (avd->allowed & PROCESS__TRANSITION) &&
 	    scontext->role != tcontext->role) {
 		for (ra = policydb.role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

