Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUHOMtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUHOMtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUHOMtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:49:36 -0400
Received: from mail1.kontent.de ([81.88.34.36]:10886 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266666AbUHOMte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:49:34 -0400
From: Oliver Neukum <oliver@neukum.org>
To: maximilian attems <janitor@sternwelten.at>
Subject: Re: Add msleep_interruptible() function to kernel/timer.c
Date: Sun, 15 Aug 2004 14:50:35 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, kj <kernel-janitors@osdl.org>
References: <20040815121805.GA15111@stro.at>
In-Reply-To: <20040815121805.GA15111@stro.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408151450.35196.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 15. August 2004 14:18 schrieb maximilian attems:
> while doing kernel-janitor msleep conversion of drivers own (incorrect),
> functions, some places would need msleep_interruptible().
> 
> this function is equivalent to:
>         current->state = TASK_INTERRUPTIBLE;
> 	schedule_timeout(timeout);
> 
> idea from Ingo Molnar:
> well, aboves is not 100% equivalent because msleep() is uninterruptible so
> stoppage of the md thread (upon shutdown) will occur with only a 250 msec
> delay. Someone should add a msleep_interruptible() function to kernel/timer.c.

[..] 
> +/**
> + * msleep_interruptible - sleep waiting for waitqueue interruptions
> + * @msecs: Time in milliseconds to sleep for
> + */
> +void msleep_interruptible(unsigned int msecs)
> +{
> +	unsigned long timeout = msecs_to_jiffies(msecs);
> +
> +	while (timeout) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		timeout = schedule_timeout(timeout);
> +	}

This is not really interruptible sleep because it is missing a check
for pending signals.

	Regards
		Oliver
