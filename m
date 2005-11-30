Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVK3Iwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVK3Iwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVK3Iwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:52:36 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:447
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751140AbVK3Iwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:52:36 -0500
Date: Wed, 30 Nov 2005 00:52:25 -0800 (PST)
Message-Id: <20051130.005225.16136066.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: drivers/connector/cn_proc.c typos
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The parameter to put_cpu_var() is unreferenced by the implementation,
and the compiler doesn't try to comprehend comments, so this wouldn't
cause any problem, but if bugged me enough to post a fix :-)

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index fcdf0ff..7f59f79 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -34,14 +34,14 @@
 static atomic_t proc_event_num_listeners = ATOMIC_INIT(0);
 static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
 
-/* proc_counts is used as the sequence number of the netlink message */
+/* proc_event_counts is used as the sequence number of the netlink message */
 static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
 
 static inline void get_seq(__u32 *ts, int *cpu)
 {
 	*ts = get_cpu_var(proc_event_counts)++;
 	*cpu = smp_processor_id();
-	put_cpu_var(proc_counts);
+	put_cpu_var(proc_event_counts);
 }
 
 void proc_fork_connector(struct task_struct *task)
