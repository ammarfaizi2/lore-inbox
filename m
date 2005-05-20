Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVETPPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVETPPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVETPPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:15:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6877 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261470AbVETPP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:15:29 -0400
Date: Fri, 20 May 2005 10:15:12 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [updated patch 7/7] BSD Secure Levels: remove redundant ptrace check
Message-ID: <20050520151512.GF5534@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050519205525.GB16215@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519205525.GB16215@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is applies cleanly against the new printk() patch.  It
removes the ptrace check because it is redundant with the check made
in kernel/ptrace.c.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-20 09:09:37.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-20 09:09:42.000000000 -0500
@@ -402,22 +402,6 @@
        seclvl_write_passwd);
 
 /**
- * Explicitely disallow ptrace'ing the init process.
- */
-static int seclvl_ptrace(struct task_struct *parent, struct task_struct *child)
-{
-	if (seclvl >= 0) {
-		if (child->pid == 1) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to ptrace "
-				      "the init process dissallowed in "
-				      "secure level %d\n", seclvl);
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
@@ -663,7 +647,6 @@
 }
 
 static struct security_operations seclvl_ops = {
-	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
 	.file_permission = seclvl_file_permission,
 	.file_mmap = seclvl_file_mmap,
