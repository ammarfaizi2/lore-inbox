Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTKHWzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 17:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTKHWzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 17:55:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:51910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261217AbTKHWzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 17:55:15 -0500
Date: Sat, 8 Nov 2003 14:58:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, mbligh@aracnet.com
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Message-Id: <20031108145840.52fed740.akpm@osdl.org>
In-Reply-To: <200311090349.04983.kernel@kolivas.org>
References: <200311090349.04983.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Hi
> 
> I believe this is a simple typo / variable name mixup between rq_src and 
> this_rq. So far all testing shows positive (if minor) improvements.
> 

Looks right to me.  I'll queue this up for the 2.6.1 deluge.

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


