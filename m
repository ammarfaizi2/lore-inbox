Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTEOVE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbTEOVE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:04:27 -0400
Received: from galileo.bork.org ([66.11.174.148]:39440 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S264105AbTEOVE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:04:26 -0400
Date: Thu, 15 May 2003 17:17:16 -0400
From: Martin Hicks <mort@wildopensource.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: rename the ksoftirqd kernel thread.
Message-ID: <20030515211716.GV17021@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

Please consider this patch for 2.4.22-pre

It just renames the ksoftirqd kernel thread to be the same as in 2.5.

The side effect is that on machines with > 100 processors the last
number in the thread name doesn't get truncated.  

The patch is against linux-2.4 bk.

thanks
mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1210  -> 1.1211 
#	    kernel/softirq.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/15	mort@plato.i.bork.org	1.1211
# Rename the ksoftirqd thread to be the same as in 2.5.
# --------------------------------------------
#
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Thu May 15 17:13:08 2003
+++ b/kernel/softirq.c	Thu May 15 17:13:08 2003
@@ -372,7 +372,7 @@
 	while (smp_processor_id() != cpu)
 		schedule();
 
-	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
+	sprintf(current->comm, "ksoftirqd/%d", bind_cpu);
 
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
