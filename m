Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWAQPCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWAQPCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAQPAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:00:22 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44513 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751251AbWAQOuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:32 -0500
Message-Id: <20060117143329.894513000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:32 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 34/34] PID Virtualization pidspace parent : signal behavior 
Content-Disposition: inline; filename=G8-prohibit-init-kill.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make sure a process parent of a pidspace discards signals sent
from processes in that pidspace.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 signal.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.15/kernel/signal.c
===================================================================
--- linux-2.6.15.orig/kernel/signal.c	2006-01-17 08:37:09.000000000 -0500
+++ linux-2.6.15/kernel/signal.c	2006-01-17 08:37:10.000000000 -0500
@@ -642,6 +642,10 @@
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

