Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWAFXf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWAFXf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWAFXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:35:57 -0500
Received: from quark.didntduck.org ([69.55.226.66]:62623 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964852AbWAFXf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:35:57 -0500
Message-ID: <43BEFF39.10500@didntduck.org>
Date: Fri, 06 Jan 2006 18:37:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove set_fs() in stop_machine()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call sched_setscheduler() directly instead.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit f9ba016f085bd87e730790e76f03db87667dd407
tree 4f75884b818ac68b97fe2a737d339ed54a130b1f
parent 41297aae94d08bb3a4c8c1a777ce373b5b432141
author Brian Gerst <bgerst@didntduck.org> Thu, 05 Jan 2006 19:17:25 -0500
committer Brian Gerst <bgerst@didntduck.org> Fri, 06 Jan 2006 16:23:09 -0500

 kernel/stop_machine.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b3d4dc8..dcfb5d7 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -87,13 +87,9 @@ static int stop_machine(void)
 {
 	int i, ret = 0;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
-	mm_segment_t old_fs = get_fs();
 
 	/* One high-prio thread per cpu.  We'll do this one. */
-	set_fs(KERNEL_DS);
-	sys_sched_setscheduler(current->pid, SCHED_FIFO,
-				(struct sched_param __user *)&param);
-	set_fs(old_fs);
+	sched_setscheduler(current, SCHED_FIFO, &param);
 
 	atomic_set(&stopmachine_thread_ack, 0);
 	stopmachine_num_threads = 0;


