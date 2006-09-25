Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWIYHt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWIYHt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 03:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWIYHt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 03:49:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:49392 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750950AbWIYHt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 03:49:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iJxqSKZLIHBjbJNw5U6plwg2hArJn81jpKl/3bbKe1lGU/ZTkc5nx79+zOv0mFU46C4GnZZLi7SWwgtjbi0GyRYujeopBmpM1OE6z69c/qTYXslxx9TM8RF5oqd+Won8bkKpIH2iyqSmOMLhxOU2ChylY80juMot7KrMvmflDSU=
Message-ID: <6d6a94c50609250049l75b2f070q81583b90d8fcfaec@mail.gmail.com>
Date: Mon, 25 Sep 2006 15:49:57 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200609250854.04470.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
	 <6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
	 <200609250854.04470.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 24 September 2006 05:35, Aubrey wrote:
> > > This looks racy. What if you get an interrupt after testing need_resched()
> > > but before the idle instruction?
> > >
> > > Normally, this should look like
> > >
> > > while(!need_resched()) {
> > > local_irq_disable();
> > > if (!need_resched())
> > > asm volatile("idle");
> > > local_irq_enable();
> > > }
> > >
> > > Of course that only works if your idle instruction wakes up on pending
> > > interrupts.
> >
> >
> > No, that doesn't work on blackfin. Blackfin need interrupt(here is
> > timer interrupt) to wake up the core from IDLE mode. Once you disable
> > the interrupt, the core will sleep forever.
>
> Ok, then this is something you should take back as feedback to your
> CPU designers. With the behavior you describe, the interrupt latency
> (until the point where an application runs) can be up to one jiffy
> longer than it should be, which is unacceptable for many real-time
> users.
>
> Worse, it means that you can not use the CONFIG_NO_IDLE_HZ option in the
> future, because you have no way to guarantee that you ever wake up from
> idle if you hit the race.
>

Oh, sorry for my unclear description, any of the peripherals can be configured
to wake up the core from its idled state to process the interrupt on
Blackfin. I should say __if no other interrupts__ here is the timer
interrupt waking up the processor every one jiffy.

I don't understand if interrupt occurs between need_resched() and the
idle instruction, what will become the racy object? Can you comment it
detailed? thanks.

-Aubrey
