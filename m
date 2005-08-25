Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVHYBW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVHYBW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVHYBWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:22:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932469AbVHYBWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:22:36 -0400
Message-Id: <20050825012150.490797000@localhost.localdomain>
References: <20050825012028.720597000@localhost.localdomain>
Date: Wed, 24 Aug 2005 18:20:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Greg Kroah <greg@kroah.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Content-Disposition: inline; filename=rootplug-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that capability functions are default, rootplug no longer needs to
manually add them to its security_ops.

Cc: Greg Kroah <greg@kroah.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 security/root_plug.c |   14 +-------------
 1 files changed, 1 insertion(+), 13 deletions(-)

Index: lsm-hooks-2.6/security/root_plug.c
===================================================================
--- lsm-hooks-2.6.orig/security/root_plug.c
+++ lsm-hooks-2.6/security/root_plug.c
@@ -83,19 +83,7 @@ static int rootplug_bprm_check_security 
 }
 
 static struct security_operations rootplug_security_ops = {
-	/* Use the capability functions for some of the hooks */
-	.ptrace =			cap_ptrace,
-	.capget =			cap_capget,
-	.capset_check =			cap_capset_check,
-	.capset_set =			cap_capset_set,
-	.capable =			cap_capable,
-
-	.bprm_apply_creds =		cap_bprm_apply_creds,
-	.bprm_set_security =		cap_bprm_set_security,
-
-	.task_post_setuid =		cap_task_post_setuid,
-	.task_reparent_to_init =	cap_task_reparent_to_init,
-
+	/* The capability functions are the defaults */
 	.bprm_check_security =		rootplug_bprm_check_security,
 };
 

--
