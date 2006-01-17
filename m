Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWAQOu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWAQOu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWAQOur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:47 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60907 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751088AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143327.653660000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:19 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 21/34] PID Virtualization file owner pid virtualization
Content-Disposition: inline; filename=F8-pgid-to-vpgid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization of the internal pid_to_vpid function for the 
process group id. This is specifically for the owner of 
a file that needs to be returned through the fcntl 
system call.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 fcntl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15/fs/fcntl.c
===================================================================
--- linux-2.6.15.orig/fs/fcntl.c	2006-01-17 08:17:29.000000000 -0500
+++ linux-2.6.15/fs/fcntl.c	2006-01-17 08:37:05.000000000 -0500
@@ -316,7 +316,7 @@
 		 * current syscall conventions, the only way
 		 * to fix this will be in libc.
 		 */
-		err = filp->f_owner.pid;
+		err = pgid_to_vpgid(filp->f_owner.pid);
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:

--

