Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267763AbSLSXpM>; Thu, 19 Dec 2002 18:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbSLSXpM>; Thu, 19 Dec 2002 18:45:12 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:58385
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267763AbSLSXpL>; Thu, 19 Dec 2002 18:45:11 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200212201042.48161.conman@kolivas.net>
References: <200212200850.32886.conman@kolivas.net>
	 <1040337982.2519.45.camel@phantasy> <3E0253D9.94961FB@digeo.com>
	 <200212201042.48161.conman@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1040341995.2521.81.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 18:53:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 18:42, Con Kolivas wrote:

> I guess this explains why my variable timeslice thingy in -ck helps on the 
> desktop. Basically by shortening the timeslice it is masking the effect of 
> the interactivity estimator under load. That is, it is treating the symptoms 
> of having an interactivity estimator rather than tackling the cause.

You would probably get the same effect or better by setting
prio_bonus_ratio lower (or off).

Setting it lower will also give less priority bonus/penalty and not
reinsert the tasks so readily into the active array.

Something like the attached patch may help...

	Robert Love

--- linux-2.5.52/kernel/sched.c	2002-12-19 18:47:53.000000000 -0500
+++ linux/kernel/sched.c	2002-12-19 18:48:05.000000000 -0500
@@ -66,8 +66,8 @@
 int child_penalty = 95;
 int parent_penalty = 100;
 int exit_weight = 3;
-int prio_bonus_ratio = 25;
-int interactive_delta = 2;
+int prio_bonus_ratio = 5;
+int interactive_delta = 1;
 int max_sleep_avg = 2 * HZ;
 int starvation_limit = 2 * HZ;
 



