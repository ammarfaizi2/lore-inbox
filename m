Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVBGTw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVBGTw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBGTvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:51:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35249 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261280AbVBGTiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:38:17 -0500
Date: Mon, 7 Feb 2005 13:37:55 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: remove ptrace, 2.6.11-rc2-mm1 (8/8)
Message-ID: <20050207193755.GG834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the eighth in a series of eight patches to the BSD Secure
Levels LSM.  It removes the ptrace check because it is redundant with
the check made in kernel/ptrace.c.  Thanks for Brad Spengler for this
suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_remove_ptrace.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:54:35.055846936 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 15:55:29.109629512 -0600
@@ -397,24 +397,6 @@
        seclvl_write_passwd);
 
 /**
- * Explicitely disallow ptrace'ing the init process.
- */
-static int
-seclvl_ptrace(struct task_struct * parent, struct task_struct * child)
-{
-	if (seclvl >= 0) {
-		if (child->pid == 1) {
-			seclvl_printk(1, KERN_WARNING "%s: Attempt to ptrace "
-				      "the init process dissallowed in "
-				      "secure level %d\n", __FUNCTION__,
-				      seclvl);
-			return -EPERM;
-		}
-	}
-	return 0;
-}
-
-/**
  * Capability checks for seclvl.  The majority of the policy
  * enforcement for seclvl takes place here.
  */
@@ -634,7 +616,6 @@
 }
 
 static struct security_operations seclvl_ops = {
-	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
 	.file_permission = seclvl_file_permission,
 	.inode_setattr = seclvl_inode_setattr,

--AGZzQgpsuUlWC1xT--
