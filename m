Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314456AbSD0UJd>; Sat, 27 Apr 2002 16:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314468AbSD0UH6>; Sat, 27 Apr 2002 16:07:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2323 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314463AbSD0UHw>; Sat, 27 Apr 2002 16:07:52 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: george@mvista.com (george anzinger)
Date: Sat, 27 Apr 2002 21:26:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CC713A0.E501AC66@mvista.com> from "george anzinger" at Apr 24, 2002 01:20:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171Ym8-0000iP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I remain unconvinced. Firstly the timer changes do not have to
> > occur at schedule rate unless your implementaiton is incredibly naiive.
> 
> OK, I'll bite, how do you stop a task at the end of its slice if you
> don't set up a timer event for that time?

At high scheduling rate you task switch more often than you hit the timer,
so you want to handle it in a lazy manner most of the time. Ie so long as
the timer goes off before the time slice expire why frob it

> > Secondly for the specfic schedule case done that way, it would be even more
> > naiive to use the standard timer api over a single compare to getthe
> > timer list versus schedule clock.
> 
> I guess it is my day to be naive :)  What are you suggesting here?

At the point you think about setting the timer register you do

	next_clock = first_of(timers->head, next_timeslice);
	if(before(next_clock, current_clock)
	{
		current_clock = next_clock;
		set_timeout(next_clock);
	}

