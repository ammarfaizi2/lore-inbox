Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWAQOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWAQOvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWAQOvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:51:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25251 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751212AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143327.825606000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:20 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 22/34] PID Virtualization define vpid_to_pid functions
Content-Disposition: inline; filename=F9-define-vpid-to-pid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the reverse conversion functions namely from the 
user virtual pid to the kernel pid.
Again, we only specify the API here, will utilize the API 
at the appropriate locations in subsequent patches and finally
will provide a real implementation for the virtualization
behind these functions together with the pid_to_vpid conversion.
Any pid passed through the syscall interface from userspace
is virtual and therefore must pass through this conversion 
before it can be used as a kernel pid.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 sched.h |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:06.000000000 -0500
@@ -878,6 +878,16 @@
 	return pid;
 }
 
+static inline pid_t vpid_to_pid(pid_t pid)
+{
+	return pid;
+}
+
+static inline pid_t vpgid_to_pgid(pid_t pid)
+{
+	return pid;
+}
+
 /**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.

--

