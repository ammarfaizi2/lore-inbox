Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSJYWsk>; Fri, 25 Oct 2002 18:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJYWsk>; Fri, 25 Oct 2002 18:48:40 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:65531 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S261638AbSJYWsj>;
	Fri, 25 Oct 2002 18:48:39 -0400
Date: Fri, 25 Oct 2002 18:54:50 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
Message-ID: <20021025225450.GA18623@www.kroptech.com>
References: <20021019021340.GA8388@www.kroptech.com> <3DB49D81.6000607@pobox.com> <20021022020932.GA13818@www.kroptech.com> <3DB9C970.3010305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB9C970.3010305@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 06:45:04PM -0400, Jeff Garzik wrote:
> Adam Kropelin wrote:
> >
> >			/* Wait a little while */
> >			spin_unlock_irqrestore(&lp->hw_lock, flags);
> >-			ret = delay;
> >-			__wait_event_interruptible_timeout(wait, 0, ret);
> >+			set_current_state(TASK_INTERRUPTIBLE);
> >+			ret = schedule_timeout(HZ>>2);
> >
> 
> close -- if schedule_timeout() returns greater than zero, that number is 
> the remaining jiffies that schedule_timeout _should_ have slept, but did 
> not.  Ideally you need to call it in a loop, that decrements a variable 
> based on schedule_timeout return code.

My assumption was that the only case in which schedule_timeout() would
return without completing the sleep is if the process was delivered a
signal. So I break the loop immediately in that case. I presume from
your explanation that schedule_timeout() may return for some other reason
(out of curiousity, what?)...and in that case I need to check for a
pending signal, exit if there is one, otherwise schedule_timeout() for
the remaining time. Am I getting warmer?

--Adam

