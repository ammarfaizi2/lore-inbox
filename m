Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVFUNft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVFUNft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVFUNXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:23:03 -0400
Received: from coderock.org ([193.77.147.115]:31617 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261453AbVFUNVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:21:08 -0400
Date: Tue, 21 Jun 2005 15:21:00 +0200
From: Domen Puncer <domen@coderock.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [patch 04/12] block/xd: replace schedule_timeout() with msleep()
Message-ID: <20050621132100.GL3906@nd47.coderock.org>
References: <20050620215133.675387000@nd47.coderock.org> <Pine.LNX.4.61L.0506211233490.9446@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506211233490.9446@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/05 12:39 +0100, Maciej W. Rozycki wrote:
> On Mon, 20 Jun 2005 domen@coderock.org wrote:
> 
> > From: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > 
> > 
> > Use msleep() instead of schedule_timeout() to guarantee the task
> > delays as expected. The current code wishes to sleep for 1 jiffy, but I am not
> > sure if this is actually intended, as with the change to HZ=1000, the time
> > equivalent of 1 jiffy changed from 10ms to 1ms. I have assumed the former in
> > this case; however the patch can be easily changed to assume the latter.
> [...]
> > @@ -529,10 +530,8 @@ static inline u_char xd_waitport (u_shor
> >  	int success;
> >  
> >  	xdc_busy = 1;
> > -	while ((success = ((inb(port) & mask) != flags)) && time_before(jiffies, expiry)) {
> > -		set_current_state(TASK_UNINTERRUPTIBLE);
> > -		schedule_timeout(1);
> > -	}
> > +	while ((success = ((inb(port) & mask) != flags)) && time_before(jiffies, expiry))
> > +		msleep(10);
> >  	xdc_busy = 0;
> >  	return (success);
> >  }
> 
>  I think it's obvious what this code intends and this makes the function 
> to busy-loop instead of giving up the CPU friendly.  The change makes no 
> sense -- the code is correct as is.

mdelay - busy loop
msleep - schedule

> 
>  Maciej
