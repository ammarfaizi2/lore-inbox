Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTIOXjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTIOXjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:39:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:13196
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261696AbTIOXh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:37:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O20.2int
Date: Tue, 16 Sep 2003 09:46:06 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+8kZ/tkguL7MjQj"
Message-Id: <200309160946.06735.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+8kZ/tkguL7MjQj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Not sure why I made this incorrect change in the first place, but it would 
hardly be noticable except in latency tests. This patch reverts it. 

Patch applies to 2.6.0-test5-mm2 or an O20.1int patched kernel. Diffs 
available here:

http://ck.kolivas.org/patches

Con

--Boundary-00=_+8kZ/tkguL7MjQj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O20.1-O20.2int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O20.1-O20.2int"

--- linux-2.6.0-test5-mm2/kernel/sched.c	2003-09-16 09:25:58.000000000 +1000
+++ linux-2.6.0-test5-mm2-O20.2/kernel/sched.c	2003-09-16 09:27:57.000000000 +1000
@@ -1430,7 +1430,7 @@ void scheduler_tick(int user_ticks, int 
 		 */
 		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
 			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= (MIN_TIMESLICE * 2)) &&
+			(p->time_slice >= MIN_TIMESLICE) &&
 			(p->array == rq->active)) {
 
 			dequeue_task(p, rq->active);

--Boundary-00=_+8kZ/tkguL7MjQj--

