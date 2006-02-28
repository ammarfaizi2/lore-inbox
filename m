Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWB1Kdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWB1Kdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWB1Kdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:33:46 -0500
Received: from seldon.control.lth.se ([130.235.83.40]:63128 "EHLO
	seldon.control.lth.se") by vger.kernel.org with ESMTP
	id S932160AbWB1Kdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:33:45 -0500
Message-ID: <440426FC.6010609@control.lth.se>
Date: Tue, 28 Feb 2006 11:33:32 +0100
From: Martin Andersson <martin.andersson@control.lth.se>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: [Patch] task interactivity calculation (was Strange interactivity
 behaviour)
References: <4402E52F.6080409@control.lth.se>
In-Reply-To: <4402E52F.6080409@control.lth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The appended patch fixes the problem mentioned in 
http://lkml.org/lkml/2006/2/27/104
regarding wrong truncations in the calculation of task interactivity 
when the nice value is negative. The problem causes the interactivity to 
scale nonlinearly and differ from examples in the code.

/Martin Andersson

diff -uprN linux-2.6.15.4.orig/kernel/sched.c linux-2.6.15.4/kernel/sched.c
--- linux-2.6.15.4.orig/kernel/sched.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.4/kernel/sched.c	2006-02-28 11:10:30.000000000 +0100
@@ -142,7 +142,7 @@
  	(v1) * (v2_max) / (v1_max)

  #define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
+	(SCALE(TASK_NICE(p)+20,40, MAX_BONUS)-20*MAX_BONUS/40+INTERACTIVE_DELTA)

  #define TASK_INTERACTIVE(p) \
  	((p)->prio <= (p)->static_prio - DELTA(p))
