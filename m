Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWGYSWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWGYSWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWGYSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:22:39 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:9223 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964813AbWGYSWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:22:38 -0400
Date: Tue, 25 Jul 2006 14:22:08 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725182208.GD4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <1153850139.8932.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153850139.8932.40.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 07:55:39PM +0200, Arjan van de Ven wrote:
> > @@ -265,6 +269,7 @@ irqreturn_t rtc_interrupt(int irq, void 
> >  
> >  	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
> >  
> > +	*count_ptr = (*count_ptr)++;
> 
> Hi,
> 
> it's a cute idea, however 3 questions:
> 1) you probably want to add a few memory barriers around this, right?
Actually, I was curious about that.  I had initially planned on using xchg to
update the counter on the mmaped page, but then it occured to me that an
unsigned long would always be an atomic update (or so I thought).  Is there a
case in which userspace will read a munged value the way the code is now?

> 2) why use the rtc and not the regular timer interrupt?
> 
Honestly, because it seemed to be a quick way forward.  The real time clock
driver was there, and its infrastructure lent itself rather easily toward adding
this functionality.  If you can elaborate on a better suggestion, I'll happily
take a crack at it.

> (and 
> 3) this will negate the power gain you get for tickless kernels, since
> now they need to start ticking again ;( )
> 
That is true, but only in the case where someone opens up /dev/rtc, and if they
open that driver and send it a UIE or PIE ioctl, it will start ticking
regardless of this patch (or that is at least my impression).

Regards
Neil

> Greetings,
>    Arjan van de Ven
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
