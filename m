Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVIITOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVIITOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVIITOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:14:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16278 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030265AbVIITOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:14:07 -0400
Date: Fri, 9 Sep 2005 20:14:05 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Corey Minyard <minyard@acm.org>
Subject: [PATCH] trivial __user annotations (ipmi)
Message-ID: <20050909191405.GU9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/char/ipmi/ipmi_devintf.c current/drivers/char/ipmi/ipmi_devintf.c
--- RC13-git8-base/drivers/char/ipmi/ipmi_devintf.c	2005-09-08 10:17:39.000000000 -0400
+++ current/drivers/char/ipmi/ipmi_devintf.c	2005-09-08 23:53:33.000000000 -0400
@@ -735,7 +735,8 @@
 	case COMPAT_IPMICTL_RECEIVE_MSG:
 	case COMPAT_IPMICTL_RECEIVE_MSG_TRUNC:
 	{
-		struct ipmi_recv   *precv64, recv64;
+		struct ipmi_recv   __user *precv64;
+		struct ipmi_recv   recv64;
 
 		if (get_compat_ipmi_recv(&recv64, compat_ptr(arg)))
 			return -EFAULT;
@@ -748,7 +749,7 @@
 				((cmd == COMPAT_IPMICTL_RECEIVE_MSG)
 				 ? IPMICTL_RECEIVE_MSG
 				 : IPMICTL_RECEIVE_MSG_TRUNC),
-				(long) precv64);
+				(unsigned long) precv64);
 		if (rc != 0)
 			return rc;
 
