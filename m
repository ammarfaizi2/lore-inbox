Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTKHQtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 11:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTKHQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 11:49:13 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:11751
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261827AbTKHQtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 11:49:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix find busiest queue 2.6.0-test9
Date: Sun, 9 Nov 2003 03:49:04 +1100
User-Agent: KMail/1.5.3
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A6Rr/eexoffzfow"
Message-Id: <200311090349.04983.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_A6Rr/eexoffzfow
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I believe this is a simple typo / variable name mixup between rq_src and 
this_rq. So far all testing shows positive (if minor) improvements.

Con

--Boundary-00=_A6Rr/eexoffzfow
Content-Type: text/x-diff;
  charset="us-ascii";
  name="loadfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="loadfix.patch"

--- linux-2.6.0-test9-base/kernel/sched.c	2003-10-26 07:52:58.000000000 +1100
+++ linux-2.6.0-test9/kernel/sched.c	2003-11-09 01:25:07.684769327 +1100
@@ -1073,11 +1073,11 @@ static inline runqueue_t *find_busiest_q
 			continue;
 
 		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_cpu_load[i]))
+		if (idle || (rq_src->nr_running < rq_src->prev_cpu_load[i]))
 			load = rq_src->nr_running;
 		else
-			load = this_rq->prev_cpu_load[i];
-		this_rq->prev_cpu_load[i] = rq_src->nr_running;
+			load = rq_src->prev_cpu_load[i];
+		rq_src->prev_cpu_load[i] = rq_src->nr_running;
 
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;

--Boundary-00=_A6Rr/eexoffzfow--

