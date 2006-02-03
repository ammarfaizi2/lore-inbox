Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945990AbWBCVgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945990AbWBCVgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945992AbWBCVgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:36:31 -0500
Received: from gold.veritas.com ([143.127.12.110]:34853 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1945991AbWBCVga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:36:30 -0500
Date: Fri, 3 Feb 2006 21:37:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] stop ==== emergency
Message-ID: <Pine.LNX.4.61.0602032131510.15970@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 21:36:29.0995 (UTC) FILETIME=[E4FE3FB0:01C62909]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dump_stack on page allocation failure presently has an irritating habit
of shouting just "====" at everyone: please stop it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/kernel/traps.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- 2.6.16-rc2/arch/i386/kernel/traps.c	2006-02-03 09:31:53.000000000 +0000
+++ linux/arch/i386/kernel/traps.c	2006-02-03 09:59:37.000000000 +0000
@@ -166,7 +166,8 @@ static void show_trace_log_lvl(struct ta
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
-		printk(KERN_EMERG " =======================\n");
+		printk(log_lvl);
+		printk(" =======================\n");
 	}
 }
 
