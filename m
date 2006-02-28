Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWB1PFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWB1PFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWB1PFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:05:44 -0500
Received: from seldon.control.lth.se ([130.235.83.40]:55744 "EHLO
	seldon.control.lth.se") by vger.kernel.org with ESMTP
	id S932126AbWB1PFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:05:43 -0500
Message-ID: <440466BC.8020801@control.lth.se>
Date: Tue, 28 Feb 2006 16:05:32 +0100
From: Martin Andersson <martin.andersson@control.lth.se>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] task interactivity calculation (was Strange	interactivity
 behaviour)
References: <4402E52F.6080409@control.lth.se>	 <440426FC.6010609@control.lth.se> <1141135669.14628.27.camel@homer>
In-Reply-To: <1141135669.14628.27.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >On Tue, 2006-02-28 at 11:33 +0100, Martin Andersson wrote:
>>The appended patch fixes the problem mentioned in 
>>http://lkml.org/lkml/2006/2/27/104
>>regarding wrong truncations in the calculation of task interactivity 
>>when the nice value is negative. The problem causes the interactivity to 
>>scale nonlinearly and differ from examples in the code.

Hi Mike,

Point taken. Is it correct now?

/Martin

Signed-off-by: Martin Andersson <martin.andersson@control.lth.se>

diff -uprN linux-2.6.15.4.orig/kernel/sched.c linux-2.6.15.4/kernel/sched.c
--- linux-2.6.15.4.orig/kernel/sched.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.4/kernel/sched.c	2006-02-28 15:49:12.000000000 +0100
@@ -142,7 +142,8 @@
  	(v1) * (v2_max) / (v1_max)

  #define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
+	(SCALE(TASK_NICE(p) + 20, 40, MAX_BONUS) - 20 * MAX_BONUS / 40 + \
+	INTERACTIVE_DELTA)

  #define TASK_INTERACTIVE(p) \
  	((p)->prio <= (p)->static_prio - DELTA(p))
