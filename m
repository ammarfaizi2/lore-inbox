Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSDEDJL>; Thu, 4 Apr 2002 22:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSDEDJB>; Thu, 4 Apr 2002 22:09:01 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:6626 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S312178AbSDEDIw>;
	Thu, 4 Apr 2002 22:08:52 -0500
Date: Thu, 4 Apr 2002 19:08:48 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [QUESTION] How to use interruptible_sleep_on() without races ?
Message-ID: <20020404190848.C27209@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020404185232.B27209@bougret.hpl.hp.com> <E16tKGi-0007Sy-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 04:20:04AM +0100, Alan Cox wrote:
> > 
> > 	I looked at it in every possible way, and I don't see how it
> > is possible to use safely interruptible_sleep_on(). And I wonder :
> 
> It isnt for interrupt stuff - its going back to the old kernel behaviour
> when it used to be usable

	So, maybe it would be a nice idea to remove it from the 2.5.X
kernel to force a "spring cleanup" of the old code. If it's no longer
usable and only confusing, it should be purged...

> Actually the code it uses is clean, slightly verbose but clean. It puts
> the phases in the right order and that fixes the race cleanly. You
> could just use completions in that case or you could use
> 
> 	wait_event_interruptible(&my_wait_queue, my_condition==FALSE)
> 
> which is a macro that generates the right stuff.

	And it might even want to be defined in include/linux/sched.h
as a replacement for interruptible_sleep_on(). It seems like a generic
need, and I would feel much safer if one of the guru wrote it properly
for me ;-)

> Alan

	Regards,

	Jean
