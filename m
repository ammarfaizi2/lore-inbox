Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTLTPYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbTLTPYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:24:36 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:27036 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264499AbTLTPY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:24:28 -0500
Message-ID: <3FE46930.1020504@cyberone.com.au>
Date: Sun, 21 Dec 2003 02:22:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] 2.6.0 sched style fixes
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au> <3FE468F5.7020501@cyberone.com.au>
In-Reply-To: <3FE468F5.7020501@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------070206080009000401020402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206080009000401020402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Couple of small spacing and indentation changes


--------------070206080009000401020402
Content-Type: text/plain;
 name="sched-style.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-style.patch"


Couple of small spacing and indentation changes


 linux-2.6-npiggin/kernel/sched.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff -puN kernel/sched.c~sched-style kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-style	2003-12-04 13:01:07.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2003-12-04 13:01:25.000000000 +1100
@@ -396,7 +396,7 @@ static void recalc_task_prio(task_t *p, 
 		 * other processes.
 		 */
 		if (p->mm && p->activated != -1 &&
-			sleep_time > JUST_INTERACTIVE_SLEEP(p)){
+			sleep_time > JUST_INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						AVG_TIMESLICE);
 				if (!HIGH_CREDIT(p))
@@ -422,15 +422,15 @@ static void recalc_task_prio(task_t *p, 
 			 * sleep are limited in their sleep_avg rise as they
 			 * are likely to be cpu hogs waiting on I/O
 			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm){
+			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm) {
 				if (p->sleep_avg >= JUST_INTERACTIVE_SLEEP(p))
 					sleep_time = 0;
 				else if (p->sleep_avg + sleep_time >=
-					JUST_INTERACTIVE_SLEEP(p)){
-						p->sleep_avg =
-							JUST_INTERACTIVE_SLEEP(p);
-						sleep_time = 0;
-					}
+						JUST_INTERACTIVE_SLEEP(p)) {
+					p->sleep_avg =
+						JUST_INTERACTIVE_SLEEP(p);
+					sleep_time = 0;
+				}
 			}
 
 			/*
@@ -443,7 +443,7 @@ static void recalc_task_prio(task_t *p, 
 			 */
 			p->sleep_avg += sleep_time;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
+			if (p->sleep_avg > NS_MAX_SLEEP_AVG) {
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
 				if (!HIGH_CREDIT(p))
 					p->interactive_credit++;
@@ -470,7 +470,7 @@ static inline void activate_task(task_t 
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
 	 */
-	if (!p->activated){
+	if (!p->activated) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -480,13 +480,14 @@ static inline void activate_task(task_t 
 		 */
 		if (in_interrupt())
 			p->activated = 2;
-		else
-		/*
-		 * Normal first-time wakeups get a credit too for on-runqueue
-		 * time, but it will be weighted down:
-		 */
+		else {
+			/*
+			 * Normal first-time wakeups get a credit too for on-runqueue
+			 * time, but it will be weighted down:
+			 */
 			p->activated = 1;
 		}
+	}
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -638,7 +639,7 @@ repeat_lock_task:
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
 			}
-			if (old_state == TASK_UNINTERRUPTIBLE){
+			if (old_state == TASK_UNINTERRUPTIBLE) {
 				rq->nr_uninterruptible--;
 				/*
 				 * Tasks on involuntary sleep don't earn
@@ -1603,7 +1604,7 @@ switch_tasks:
 	RCU_qsctr(task_cpu(prev))++;
 
 	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0){
+	if ((long)prev->sleep_avg <= 0) {
 		prev->sleep_avg = 0;
 		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
 			prev->interactive_credit--;

_

--------------070206080009000401020402--

