Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVLOOkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVLOOkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLOOkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:40:15 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:12443 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750722AbVLOOjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:39:45 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143937.145839000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:18 -0500
To: linux-kernel@vger.kernel.org
Cc: Cedric Le Goater <clg@fr.ibm.com>
Subject: [RFC][patch 21/21] PID Virtualization: pidspace parent : signal behavior 
Content-Disposition: inline; filename=G8-prohibit-init-kill.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make sure a process parent of a pidspace discards signals sent
from processes in that pidspace.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

--

 kernel/signal.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.15-rc1/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/signal.c	2005-12-08 01:50:37.000000000 -0500
+++ linux-2.6.15-rc1/kernel/signal.c	2005-12-08 01:50:37.000000000 -0500
@@ -651,6 +651,10 @@ static int check_kill_permission(int sig
 	if (!valid_signal(sig))
 		return error;
 	error = -EPERM;
+
+	if (task_vpid_ctx(t, current) == 1)
+	    return error;
+
 	if ((info == SEND_SIG_NOINFO || (!is_si_special(info) && SI_FROMUSER(info)))
 	    && ((sig != SIGCONT) ||
 		(current->signal->session != t->signal->session))

--
