Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTLSPN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 10:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTLSPN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 10:13:27 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:63164 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263269AbTLSPNZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 10:13:25 -0500
Subject: [PATCH] Reduce SELinux check on KDSKBENT/SENT ioctls
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1071846793.10242.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 19 Dec 2003 10:13:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0 reduces the full capability check in the
SELinux module for the KDSKBENT/SENT ioctls to only check the
corresponding SELinux permission, avoiding a change to the Linux
permissions model for these operations.  Please apply, or let me know if
you'd like this resubmitted later.  Thanks.

 security/selinux/hooks.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.75
diff -u -r1.75 hooks.c
--- linux-2.6/security/selinux/hooks.c	9 Oct 2003 13:03:45 -0000	1.75
+++ linux-2.6/security/selinux/hooks.c	21 Oct 2003 13:08:53 -0000
@@ -1992,8 +1992,7 @@
 
 	        case KDSKBENT:
 	        case KDSKBSENT:
-		  	if (!capable(CAP_SYS_TTY_CONFIG))
-				error = -EPERM;
+			error = task_has_capability(current,CAP_SYS_TTY_CONFIG);
 			break;
 
 		/* default case assumes that the command will go


  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

