Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUHPUA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUHPUA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267922AbUHPUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:00:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52449 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267926AbUHPUAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:00:53 -0400
Date: Mon, 16 Aug 2004 13:00:37 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: maximilian attems <janitor@sternwelten.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kj <kernel-janitors@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kernel-janitors] Re: Add msleep_interruptible() function to kernel/timer.c
Message-ID: <20040816200037.GC1942@us.ibm.com>
References: <20040815121805.GA15111@stro.at> <1092570891.17605.1.camel@localhost.localdomain> <20040815132548.GF1799@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815132548.GF1799@stro.at>
X-Operating-System: Linux 2.6.8.1 (i686)
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 03:25:48PM +0200, maximilian attems wrote:
> On Sun, 15 Aug 2004, Alan Cox wrote:
> 
> > On Sul, 2004-08-15 at 13:18, maximilian attems wrote:
> > > + * msleep_interruptible - sleep waiting for waitqueue interruptions
> > > + * @msecs: Time in milliseconds to sleep for
> > > + */
> > > +void msleep_interruptible(unsigned int msecs)
> > > +{
> > > +	unsigned long timeout = msecs_to_jiffies(msecs);
> > > +
> > > +	while (timeout) {
> > 
> > You want to have while(timeout && !signal_pending(current))
> > 
> > A signal will wake the timeout which will then loop. It might also
> > be good to add
> > 
> > > +		set_current_state(TASK_INTERRUPTIBLE);
> > > +		timeout = schedule_timeout(timeout);
> > > +	}
> > 
> > return timeout;
> > 
> > so that the caller knows more about how long the timer ran for before
> > the interrupt and if it was interrupted.
> 
> belows patches returns timeout in msecs 
> as the function is also called with that unit, 
> added definition in include/linux/delay.h

<snip>

An entry could be added to the TODO to do what I had done but with
long delays in TASK_INTERRUPTIBLE (which there probably should not be
many of). It would also probably be useful to verify that any drivers 
sleeping for times measurable in msecs while INTERRUPTIBLE actually intend
to do so (as I tried to do in some cases).

-Nish
