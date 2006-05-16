Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWEPEGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWEPEGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 00:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWEPEGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 00:06:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:42146 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751252AbWEPEGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 00:06:44 -0400
X-Authenticated: #14349625
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Con Kolivas'" <kernel@kolivas.org>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4t16i2$12rqnu@orsmga001.jf.intel.com>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 06:07:10 +0200
Message-Id: <1147752430.7636.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 12:01 -0700, Chen, Kenneth W wrote:

> [patch] sched: update comments in priority calculation w.r.t. implementation.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> --- ./kernel/sched.c.orig	2006-05-15 12:24:02.000000000 -0700
> +++ ./kernel/sched.c	2006-05-15 12:37:16.000000000 -0700
> @@ -746,10 +746,12 @@ static int recalc_task_prio(task_t *p, u
>  	if (likely(sleep_time > 0)) {
>  		/*
>  		 * User tasks that sleep a long time are categorised as
> -		 * idle. They will only have their sleep_avg increased to a
> -		 * level that makes them just interactive priority to stay
> -		 * active yet prevent them suddenly becoming cpu hogs and
> -		 * starving other processes.
> +		 * idle. If they sleep longer than INTERACTIVE_SLEEP, it
> +		 * will have its priority boosted to minimum MAX_BONUS-1.
> +		 * For short sleep, they will only have their sleep_avg
> +		 * increased to a level that makes them just interactive
> +		 * priority to stay active yet prevent them suddenly becoming
> +		 * cpu hogs and starving other processes.
>  		 */
>  		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
>  				unsigned long ceiling;

This comment still doesn't reflect what the code does.  Please just
delete the last four lines, they are incorrect.

	-Mike

