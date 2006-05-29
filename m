Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWE2V1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWE2V1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWE2V1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:62945 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751361AbWE2V0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:49 -0400
Date: Mon, 29 May 2006 23:27:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 50/61] lock validator: special locking: hrtimer.c
Message-ID: <20060529212709.GX3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/hrtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -786,7 +786,7 @@ static void __devinit init_hrtimers_cpu(
 	int i;
 
 	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++)
-		spin_lock_init(&base->lock);
+		spin_lock_init_static(&base->lock);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
