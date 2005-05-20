Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVETPLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVETPLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVETPLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:11:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62686 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261468AbVETPLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:11:09 -0400
Date: Fri, 20 May 2005 10:10:50 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [updated patch 5/7] BSD Secure Levels: allow setuid/setgid on root user processes
Message-ID: <20050520151049.GD5534@halcrow.us>
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
allows setuid and setgid on a process if the user is already root.
This allows non-root users to log in.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-20 09:09:07.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-20 09:09:13.000000000 -0500
@@ -447,12 +447,12 @@
 				      "network administrative task while "
 				      "in secure level [%d] denied\n", seclvl);
 			return -EPERM;
-		} else if (cap == CAP_SETUID) {
+		} else if (cap == CAP_SETUID && current->uid != 0) {
 			seclvl_printk(1, KERN_WARNING, "Attempt to setuid "
 				      "while in secure level [%d] denied\n",
 				      seclvl);
 			return -EPERM;
-		} else if (cap == CAP_SETGID) {
+		} else if (cap == CAP_SETGID && current->uid != 0) {
 			seclvl_printk(1, KERN_WARNING, "Attempt to setgid "
 				      "while in secure level [%d] denied\n",
 				      seclvl);
