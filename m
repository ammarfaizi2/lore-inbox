Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUHOM5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUHOM5f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266677AbUHOM5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:57:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13278 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266684AbUHOM5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:57:21 -0400
Subject: Re: Add msleep_interruptible() function to kernel/timer.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: maximilian attems <janitor@sternwelten.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kj <kernel-janitors@osdl.org>
In-Reply-To: <20040815121805.GA15111@stro.at>
References: <20040815121805.GA15111@stro.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092570891.17605.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 Aug 2004 12:54:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-15 at 13:18, maximilian attems wrote:
> + * msleep_interruptible - sleep waiting for waitqueue interruptions
> + * @msecs: Time in milliseconds to sleep for
> + */
> +void msleep_interruptible(unsigned int msecs)
> +{
> +	unsigned long timeout = msecs_to_jiffies(msecs);
> +
> +	while (timeout) {

You want to have while(timeout && !signal_pending(current))

A signal will wake the timeout which will then loop. It might also
be good to add

> +		set_current_state(TASK_INTERRUPTIBLE);
> +		timeout = schedule_timeout(timeout);
> +	}

return timeout;

so that the caller knows more about how long the timer ran for before
the interrupt and if it was interrupted.


