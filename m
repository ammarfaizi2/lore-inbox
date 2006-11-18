Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754301AbWKRMc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbWKRMc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 07:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbWKRMc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 07:32:29 -0500
Received: from smtp-out3.iol.cz ([194.228.2.91]:35029 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S1754301AbWKRMc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 07:32:29 -0500
Message-ID: <455EFD37.4080100@stud.feec.vutbr.cz>
Date: Sat, 18 Nov 2006 13:31:51 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt3, yum repo
References: <20061117200357.GA736@elte.hu>
In-Reply-To: <20061117200357.GA736@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> i've released the 2.6.18-rc6-rt3 tree
Hi Ingo,
lockdep doesn't compile on UP. per_cpu_offset only makes sense on SMP.

Michal

diff --git a/kernel/lockdep.c b/kernel/lockdep.c
index 8f6ba22..d46082d 100644
--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -1194,8 +1194,13 @@ register_lock_class(struct lockdep_map *
  	 */
 	if (!static_obj(lock->key)) {
 		debug_locks_off();
+#ifdef CONFIG_SMP
 		printk("INFO: trying to register non-static key %p (%016lx).\n",
 			lock->key, per_cpu_offset(raw_smp_processor_id()));
+#else
+		printk("INFO: trying to register non-static key %p.\n",
+			lock->key);
+#endif
 		printk("the code is fine but needs lockdep annotation.\n");
 		printk("turning off the locking correctness validator.\n");
 		dump_stack();


