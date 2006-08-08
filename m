Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWHHJT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWHHJT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWHHJT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:19:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750958AbWHHJT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:19:27 -0400
Date: Tue, 8 Aug 2006 11:19:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Darren Jenkins <darrenrjenkins@gmail.com>
Cc: torvalds@osdl.org, Zed 0xff <zed.0xff@gmail.com>, kernel-janitors@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [patch] fix common mistake in polling loops
Message-ID: <20060808091911.GA4245@elf.ucw.cz>
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com> <20060805114052.GE4506@ucw.cz> <20060805114547.GA5386@ucw.cz> <82faac5b0608061639v315c6fa9l17cd4bf44b6bbc51@mail.gmail.com> <20060807233453.GK2759@elf.ucw.cz> <82faac5b0608071753q71050d72uadcf55bc1e54f30e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82faac5b0608071753q71050d72uadcf55bc1e54f30e@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >> Well, whoever wrote thi has some serious problems (in attitude
> >> >> department). *Any* loop you design may take half a minute under
> >> >> streange circumstances.
> >>
> >> 6.
> >> common mistake in polling loops [from Linus]:
> >
> >Yes, Linus was wrong here. Or more precisely, he's right original code
> >is broken, but his suggested "fix" is worse than the original.
> >
> >        unsigned long timeout = jiffies + HZ/2;
> >        for (;;) {
> >                if (ready())
> >                        return 0;
> >[IMAGINE HALF A SECOND DELAY HERE]
> >                if (time_after(timeout, jiffies))
> >                        break;
> >                msleep(10);
> >        }
> >
> >Oops.
> >
> >> >Actually it may be broken, depending on use. In some cases this loop
> >> >may want to poll the hardware 50 times, 10msec appart... and your loop
> >> >can poll it only once in extreme conditions.
> >> >
> >> >Actually your loop is totally broken, and may poll only once (without
> >> >any delay) and then directly timeout :-P -- that will break _any_
> >> >user.
> >>
> >> The Idea is that we are checking some event in external hardware that
> >> we know will complete in a given time (This time is not dependant on
> >> system activity but is fixed). After that time if the event has not
> >> happened we know something has borked.
> >
> >But you have to make sure YOU CHECK READY AFTER THE TIMEOUT. Linus'
> >code does not do that.
> 
> Sorry I did not realise that was your problem with the code.
> Would it help if we just explicitly added a
> 
> if (ready())
>        return 0;
> 
> after the loop, in the example code? so people wont miss adding
> something like that in?

Yes, that would do the trick.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
