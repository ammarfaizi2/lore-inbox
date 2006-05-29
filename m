Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWE2V2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWE2V2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWE2V1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:43243 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751367AbWE2V1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:23 -0400
Date: Mon, 29 May 2006 23:27:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 57/61] lock validator: special locking: posix-timers
Message-ID: <20060529212742.GE3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (non-nested) unlocking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/posix-timers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/posix-timers.c
===================================================================
--- linux.orig/kernel/posix-timers.c
+++ linux/kernel/posix-timers.c
@@ -576,7 +576,7 @@ static struct k_itimer * lock_timer(time
 	timr = (struct k_itimer *) idr_find(&posix_timers_id, (int) timer_id);
 	if (timr) {
 		spin_lock(&timr->it_lock);
-		spin_unlock(&idr_lock);
+		spin_unlock_non_nested(&idr_lock);
 
 		if ((timr->it_id != timer_id) || !(timr->it_process) ||
 				timr->it_process->tgid != current->tgid) {
