Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143571AbRA1Qpt>; Sun, 28 Jan 2001 11:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143532AbRA1Qpj>; Sun, 28 Jan 2001 11:45:39 -0500
Received: from colorfullife.com ([216.156.138.34]:57098 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S143524AbRA1Qpb>;
	Sun, 28 Jan 2001 11:45:31 -0500
Message-ID: <3A744CA7.AF41F05D@colorfullife.com>
Date: Sun, 28 Jan 2001 17:45:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <3A74456D.7AE44855@colorfullife.com> <20010128123630.K19833@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> 
> Em Sun, Jan 28, 2001 at 05:14:37PM +0100, Manfred Spraul escreveu:
> > >
> > > Anything which uses sleep_on() has a 90% chance of being broken. Fix
> > > them all, because we want to remove sleep_on() and friends in 2.5.
> > >
> >
> > Then you can add 'calling schedule() with disabled local interrupts()'
> > to your list.
> 
> any example of code doing this now? That way we can at least point it to
> interested people and say "look at driver foobar in kernel x.y.z and see
> how its wrong"
>

It isn't wrong to call schedule() with disabled interrupts - it's a
feature ;-)
Those 10% sleep_on() users that aren't broken use it:

 for(;;) {
	cli();
	if(condition)
		break;
	sleep_on(&my_wait_queue);
	sti();
 }

E.g. TIOCMIWAIT in drivers/char/serial.c - a nearly correct sleep_on()
user.

But I doubt that 10% of the sleep_on() users are non-broken...

If you remove sleep_on(), then you can disallow calling schedule() with
disabled local interrupts.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
