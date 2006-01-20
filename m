Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161473AbWATCzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbWATCzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWATCzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:35821
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161421AbWATCzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:10 -0500
Message-Id: <20060120021342.195385000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:46 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/7] [hrtimers] Fix possible use of NULL pointer in
	posix-timers
Content-Disposition: inline;
	filename=0002-hrtimers-Fix-possible-use-of-NULL-pointer-in-posix-timers.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixup the conversion of posix-timers to hrtimers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 kernel/posix-timers.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

a42e5a139db5c1759bc98729152618ed5b80410e
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 197208b..3b606d3 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -290,7 +290,8 @@ void do_schedule_next_timer(struct sigin
 		info->si_overrun = timr->it_overrun_last;
 	}
 
-	unlock_timer(timr, flags);
+	if (timr)
+		unlock_timer(timr, flags);
 }
 
 int posix_timer_event(struct k_itimer *timr,int si_private)
-- 
1.0.8

--

