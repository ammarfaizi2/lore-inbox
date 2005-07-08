Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVGHSmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVGHSmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVGHSmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:42:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262765AbVGHSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:41:52 -0400
Message-ID: <42CEC8E3.8040300@RedHat.com>
Date: Fri, 08 Jul 2005 14:41:39 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: procfs/sysctl interfaces for lockd do not work on x86_64
Content-Type: multipart/mixed;
 boundary="------------010303090907040002000109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303090907040002000109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is an problem that was brought to my attention and I noticed
it was not fixed in any of the upstream kernels I looked at.

steved.

--------------010303090907040002000109
Content-Type: text/x-patch;
 name="linux-2.6.12.2-lockd-sysctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12.2-lockd-sysctl.patch"

A trivial patch that allows the setting of NLM timeouts and grace periods
through the proc and sysclt interfaces on x86_64 architectures

Signed-off-by: Steve Dickson <steved@redhat.com>

--- linux-2.6.12.2/fs/lockd/svc.c.orig	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.12.2/fs/lockd/svc.c	2005-07-08 14:26:41.671010000 -0400
@@ -329,7 +329,7 @@ static ctl_table nlm_sysctls[] = {
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "nlm_grace_period",
 		.data		= &nlm_grace_period,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
 		.extra1		= (unsigned long *) &nlm_grace_period_min,
@@ -339,7 +339,7 @@ static ctl_table nlm_sysctls[] = {
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "nlm_timeout",
 		.data		= &nlm_timeout,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
 		.extra1		= (unsigned long *) &nlm_timeout_min,

--------------010303090907040002000109--
