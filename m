Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbSJHBTe>; Mon, 7 Oct 2002 21:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbSJHBT2>; Mon, 7 Oct 2002 21:19:28 -0400
Received: from packet.digeo.com ([12.110.80.53]:32705 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262564AbSJHBT1>;
	Mon, 7 Oct 2002 21:19:27 -0400
Message-ID: <3DA233EC.1119CD7B@digeo.com>
Date: Mon, 07 Oct 2002 18:25:00 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
References: <1033960902.3da0fdc6839aa@kolivas.net> <3DA139EC.8A34A593@digeo.com> <1034038912.3da22e805c7c0@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 01:25:00.0781 (UTC) FILETIME=[855BE9D0:01C26E69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> -       swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
> +       swap_tendency = mapped_ratio / 2 + distress ;
> +       if (swap_tendency > 50){
> +               if (vm_swappiness <= 990) vm_swappiness+=10;
> +               }
> +               else
> +               if (vm_swappiness > 0) vm_swappiness--;
> +       swap_tendency += (vm_swappiness / 10);
>

heh, that could work.  So basically you're saying "the longer we're
under swap stress, the more swappy we want to get".

Problem is, users have said they don't want that.  They say that they
want to copy ISO images about all day and not swap.  I think.

It worries me.  It means that we'll be really slow to react to sudden
load swings, and it increases the complexity of the analysis and
testing.  And I really do want to give the user a single knob,
which has understandable semantics and for which I can feasibly test
all operating regions.

I really, really, really, really don't want to get too fancy in there.

I have changed this code a bit, and have added other things.  Mainly
over on the writer throttling side, which tends to be the place where
the stress comes from in the first place.
