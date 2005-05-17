Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVEQPaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVEQPaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVEQPaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:30:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24040 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261642AbVEQPae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:30:34 -0400
Date: Tue, 17 May 2005 10:30:11 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 5/7] BSD Secure Levels: allow setuid/setgid on root user processes
Message-ID: <20050517153011.GD2944@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifth in a series of seven patches to the BSD Secure
Levels LSM.  It allows setuid and setgid on a process if the user is
already root.  This allows non-root users to log in.  Thanks to Serge
Hallyn for the suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-16 16:28:29.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-16 16:29:19.000000000 -0500
@@ -442,12 +442,12 @@
 				      "in secure level [%d] denied\n",
 				      __FUNCTION__, seclvl);
 			return -EPERM;
-		} else if (cap == CAP_SETUID) {
+		} else if (cap == CAP_SETUID && current->uid != 0) {
 			seclvl_printk(1, KERN_WARNING "%s: Attempt to setuid "
 				      "while in secure level [%d] denied\n",
 				      __FUNCTION__, seclvl);
 			return -EPERM;
-		} else if (cap == CAP_SETGID) {
+		} else if (cap == CAP_SETGID && current->uid != 0) {
 			seclvl_printk(1, KERN_WARNING "%s: Attempt to setgid "
 				      "while in secure level [%d] denied\n",
 				      __FUNCTION__, seclvl);
