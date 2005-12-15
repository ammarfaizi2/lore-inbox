Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVLOOi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVLOOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVLOOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:56 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:38554 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750721AbVLOOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:32 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143824.680265000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:05 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 08/21] PID Virtualization: file owner pid virtualization
Content-Disposition: inline; filename=F8-pgid-to-vpgid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization of the internal pid_to_vpid function for the 
process group id. This is specifically for the owner of 
a file that needs to be returned through the fcntl 
system call.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 fs/fcntl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc1/fs/fcntl.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/fcntl.c	2005-12-14 15:12:28.000000000 -0500
+++ linux-2.6.15-rc1/fs/fcntl.c	2005-12-14 15:13:55.000000000 -0500
@@ -316,7 +316,7 @@ static long do_fcntl(int fd, unsigned in
 		 * current syscall conventions, the only way
 		 * to fix this will be in libc.
 		 */
-		err = filp->f_owner.pid;
+		err = pgid_to_vpgid(filp->f_owner.pid);
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:

--
