Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbUKDWNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUKDWNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUKDWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:13:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7298 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262457AbUKDV6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:58:42 -0500
Subject: Re: [RFC] [PATCH] [3/6] LSM Stacking: capability LSM stacking
	support
From: Serge Hallyn <hallyn@cs.wm.edu>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099609739.2096.18.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:08:59 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds stacking support to the POSIX Capability LSM.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk12-stack/security/capability.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/capability.c	2004-11-02
19:55:53.583063616 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/capability.c	2004-11-02
20:10:16.850826968 -0600
@@ -60,6 +60,8 @@
 
 static int __init capability_init (void)
 {
+	int rc;
+
 	if (capability_disable) {
 		printk(KERN_INFO "Capabilities disabled at initialization\n");
 		return 0;
@@ -67,7 +69,8 @@
 	/* register ourselves with the security framework */
 	if (register_security (&capability_ops)) {
 		/* try registering with primary module */
-		if (mod_reg_security (MY_NAME, &capability_ops)) {
+		rc = mod_reg_security (MY_NAME, &capability_ops);
+		if (rc < 0) {
 			printk (KERN_INFO "Failure registering capabilities "
 				"with primary security module.\n");
 			return -EINVAL;


