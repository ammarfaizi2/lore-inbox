Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264273AbRFSPCt>; Tue, 19 Jun 2001 11:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFSPCj>; Tue, 19 Jun 2001 11:02:39 -0400
Received: from dioniso.waptopic.com ([195.110.99.133]:65285 "HELO
	dioniso.waptopic.com") by vger.kernel.org with SMTP
	id <S264259AbRFSPCf>; Tue, 19 Jun 2001 11:02:35 -0400
Date: Tue, 19 Jun 2001 17:02:35 +0200
From: Simone Piunno <simonep@wseurope.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: compiling with gcc 3.0
Message-ID: <20010619170235.C2593@pioppo.wired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Wireless Solution
X-Operating-System: Linux 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was trying to compile 2.4.5 with gcc 3.0 but there is a problem
(conflicting type) between kernel/timer.c and include/linux/sched.h
Apparently the problem solves with this oneline workarond:

--- linux/include/linux/sched.h Tue Jun 19 17:00:03 2001
+++ linux/include/linux/sched.h.orig    Tue Jun 19 17:00:13 2001
@@ -537,7 +537,7 @@
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern volatile struct timeval xtime __attribute__ ((aligned (16)));
+extern struct timeval xtime;
 
 extern void do_timer(struct pt_regs *)

don't know if this is the right approach but works for me.

-- 
.-----------------------------------------------------------------.
| Simone Piunno             Wireless Solutions srl - DADA group   |
| software architect        Europe HQ, via Castiglione 25 Bologna |
| http://www.wseurope.com   Tel: +390512966823 Fax: +390512966800 |
| http://www.waptopic.com   God is real, unless declared integer. |
'-----------------------------------------------------------------'
