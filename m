Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJLV6J>; Sat, 12 Oct 2002 17:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJLV6J>; Sat, 12 Oct 2002 17:58:09 -0400
Received: from mail.ccur.com ([208.248.32.212]:43277 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S261362AbSJLV6H>;
	Sat, 12 Oct 2002 17:58:07 -0400
Message-ID: <3DA89C29.93F5622E@ccur.com>
Date: Sat, 12 Oct 2002 18:03:21 -0400
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: george@mvista.com, high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This patch, in conjunction with the "core" high-res-timers 
>> patch implements high resolution timers on the i386 
>> platforms. 
>
> I really don't get the notion of partial ticks, and quite frankly, this 
> isn't going into my tree until some major distribution kicks me in the 
> head and explains to me why the hell we have partial ticks instead of just 
> making the ticks shorter. 
> 
>                Linus 

Hi Linus,

Concurrent has been using previous versions of the Posix timers patch
in our 2.4.18 based kernel.  I like this interface and would like to 
see it included in your kernel.

What would make the patch more acceptable?  Would it be acceptable
if it used a separate queue for the Posix timers and minimized changes
to timer.c?

To answer the partial tick question, it's a trade off.  If all you need
is 1 milli-second resolution, it might not be worth spliting the tick.
It's a question of how the overhead to set up a timer compares to the 
overhead of the higher frequency tick interrupts.  If you want
micro-second resolution, you need to split the tick.

This is important to folks doing control systems.  They get excited
about timing jitter and resolution.  It is also interesting to folks
doing games.  It's nice to be able to do short delays by blocking rather
than having to spin in a delay loop.

I'd feel better about this being used for critical applications if
the games folks beat it up first.

Jim Houston - Concurrent Computer Corp.
