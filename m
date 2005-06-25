Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263394AbVFYLQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbVFYLQo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 07:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbVFYLQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 07:16:44 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:20937 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S263394AbVFYLOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 07:14:36 -0400
Date: Sat, 25 Jun 2005 13:29:02 +0200 (CEST)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Driver writer's guide to sleeping
In-Reply-To: <200506251250.18133.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.58.0506251327390.3206@fachschaft.cup.uni-muenchen.de>
References: <200506251250.18133.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Jun 2005, Denis Vlasenko wrote:

> schedule_timeout(timeout)
> 	Whee, it has a comment! :)
>  * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
>  * pass before the routine returns. The routine will return 0
>  *
>  * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
>  * delivered to the current task. In this case the remaining time
>  * in jiffies will be returned, or 0 if the timer expired in time
>  *
>  * The current task state is guaranteed to be TASK_RUNNING when this
>  * routine returns.
> 	Thus:
> 	set_current_state(TASK_[UN]INTERRUPTIBLE);
> 	schedule_timeout(timeout_in_jiffies)
> 
> msleep(ms)
> 	Sleeps at least ms msecs.
> 	Equivalent to:
> 	set_current_state(TASK_UNINTERRUPTIBLE);
> 	schedule_timeout(timeout)

If and only if you are not on any waitqueue. You may not be interrupted
by a signal, but you still can be woken with an explicit wake_up()

	HTH
		Oliver

