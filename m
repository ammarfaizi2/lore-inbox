Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWB1Q1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWB1Q1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWB1Q1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:27:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:30349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751600AbWB1Q1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:27:49 -0500
X-Authenticated: #14349625
Subject: Re: [Patch] task interactivity calculation (was
	Strange	interactivity behaviour)
From: Mike Galbraith <efault@gmx.de>
To: Martin Andersson <martin.andersson@control.lth.se>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <440466BC.8020801@control.lth.se>
References: <4402E52F.6080409@control.lth.se>
	 <440426FC.6010609@control.lth.se> <1141135669.14628.27.camel@homer>
	 <440466BC.8020801@control.lth.se>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 17:28:44 +0100
Message-Id: <1141144124.7944.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 16:05 +0100, Martin Andersson wrote:
>  >On Tue, 2006-02-28 at 11:33 +0100, Martin Andersson wrote:
> >>The appended patch fixes the problem mentioned in 
> >>http://lkml.org/lkml/2006/2/27/104
> >>regarding wrong truncations in the calculation of task interactivity 
> >>when the nice value is negative. The problem causes the interactivity to 
> >>scale nonlinearly and differ from examples in the code.
> 
> Hi Mike,
> 
> Point taken. Is it correct now?

Looks perfect to me.

	-Mike

> 
> /Martin
> 
> Signed-off-by: Martin Andersson <martin.andersson@control.lth.se>
> 
> diff -uprN linux-2.6.15.4.orig/kernel/sched.c linux-2.6.15.4/kernel/sched.c
> --- linux-2.6.15.4.orig/kernel/sched.c	2006-02-10 08:22:48.000000000 +0100
> +++ linux-2.6.15.4/kernel/sched.c	2006-02-28 15:49:12.000000000 +0100
> @@ -142,7 +142,8 @@
>   	(v1) * (v2_max) / (v1_max)
> 
>   #define DELTA(p) \
> -	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
> +	(SCALE(TASK_NICE(p) + 20, 40, MAX_BONUS) - 20 * MAX_BONUS / 40 + \
> +	INTERACTIVE_DELTA)
> 
>   #define TASK_INTERACTIVE(p) \
>   	((p)->prio <= (p)->static_prio - DELTA(p))
> 

