Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVBGTqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVBGTqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVBGTpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:45:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:52473 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261267AbVBGTeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:34:37 -0500
Date: Mon, 7 Feb 2005 13:34:08 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: allow setuid/setgid on process if root, 2.6.11-rc2-mm1 (5/8)
Message-ID: <20050207193408.GD834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the fifth in a series of eight patches to the BSD Secure
Levels LSM.  It allows setuid and setgid on a process if the user is
already root.  This allows non-root users to log in.  Thanks to Serge
Hallyn for the suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_setuid_and_setgid.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:39:35.786556648 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 15:41:46.043754544 -0600
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

--OaZoDhBhXzo6bW1J--
