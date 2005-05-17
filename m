Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVEQPdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVEQPdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEQPdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:33:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6587 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261679AbVEQPcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:32:11 -0400
Date: Tue, 17 May 2005 10:31:59 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 7/7] BSD Secure Levels: remove redundant ptrace check
Message-ID: <20050517153159.GF2944@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the seventh in a series of seven patches to the BSD Secure
Levels LSM.  It removes the ptrace check because it is redundant with
the check made in kernel/ptrace.c.  Thanks for Brad Spengler for this
suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-16 16:31:36.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-16 16:33:01.000000000 -0500
@@ -396,23 +396,6 @@
        seclvl_write_passwd);
 
 /**
- * Explicitely disallow ptrace'ing the init process.
- */
-static int seclvl_ptrace(struct task_struct *parent, struct task_struct *child)
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
@@ -631,7 +614,6 @@
 }
 
 static struct security_operations seclvl_ops = {
-	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
 	.file_permission = seclvl_file_permission,
 	.inode_setattr = seclvl_inode_setattr,
