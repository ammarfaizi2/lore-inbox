Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSGIUYS>; Tue, 9 Jul 2002 16:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSGIUYR>; Tue, 9 Jul 2002 16:24:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22789 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317401AbSGIUYQ>;
	Tue, 9 Jul 2002 16:24:16 -0400
Message-ID: <3D2B469E.766C856E@zip.com.au>
Date: Tue, 09 Jul 2002 13:25:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: readprofile from 2.5.25 web server benchmark
References: <3D2A8B81.42042058@zip.com.au> from "Andrew Morton" at Jul 9, 2 11:15:01 am <200207091030.OAA22445@sex.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > --- 2.5.25/kernel/timer.c~timer-speedup       Tue Jul  9 00:04:33 2002
> > +++ 2.5.25-akpm/kernel/timer.c        Tue Jul  9 00:06:09 2002
> > @@ -211,6 +211,9 @@ int mod_timer(struct timer_list *timer,
> >       int ret;
> >       unsigned long flags;
> >
> > +     if (timer_pending(timer) && timer->expires == expires)
> > +             return 1;
> > +
> >       spin_lock_irqsave(&timerlist_lock, flags);
> >       timer->expires = expires;
> >       ret = detach_timer(timer);
> 
> Does this not lose timer sometimes?
> 

Well I've thought about it long and hard, but I can't see a
hole.  But there probably is one.  Somewhere.

It reduces mod_timer() load by 30% in a netperf run, so it's
worth thinking about.

-
