Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbSJHBfg>; Mon, 7 Oct 2002 21:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbSJHBfg>; Mon, 7 Oct 2002 21:35:36 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:40640 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S262603AbSJHBfe>;
	Mon, 7 Oct 2002 21:35:34 -0400
Message-ID: <1034041272.3da237b8b7908@kolivas.net>
Date: Tue,  8 Oct 2002 11:41:12 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
References: <1033960902.3da0fdc6839aa@kolivas.net> <3DA139EC.8A34A593@digeo.com> <1034038912.3da22e805c7c0@kolivas.net> <3DA233EC.1119CD7B@digeo.com>
In-Reply-To: <3DA233EC.1119CD7B@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > 
> > ...
> > -       swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
> > +       swap_tendency = mapped_ratio / 2 + distress ;
> > +       if (swap_tendency > 50){
> > +               if (vm_swappiness <= 990) vm_swappiness+=10;
> > +               }
> > +               else
> > +               if (vm_swappiness > 0) vm_swappiness--;
> > +       swap_tendency += (vm_swappiness / 10);
> >
> 
> heh, that could work.  So basically you're saying "the longer we're
> under swap stress, the more swappy we want to get".

Exactly, which made complete sense to me.

> 
> Problem is, users have said they don't want that.  They say that they
> want to copy ISO images about all day and not swap.  I think.

But do they really want that or do they think they want that without knowing the
consequences of such a setting?

> It worries me.  It means that we'll be really slow to react to sudden
> load swings, and it increases the complexity of the analysis and
> testing.  And I really do want to give the user a single knob,
> which has understandable semantics and for which I can feasibly test
> all operating regions.
> 
> I really, really, really, really don't want to get too fancy in there.

Well I made it as simple as I possibly could. It seems to do what they want (not
swappy) but not at the expense of making the machine never swapping when it
really needs to - and the performance seems to be better all round in real
usage. I guess the only thing is it isn't a fixed number... unless we set a
maximum swappiness level or... but then it starts getting unnecessarily
complicated with questionable benefits.

> I have changed this code a bit, and have added other things.  Mainly
> over on the writer throttling side, which tends to be the place where
> the stress comes from in the first place.

/me waits but is a little disappointed

Con
