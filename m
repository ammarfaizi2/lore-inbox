Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRKBUO5>; Fri, 2 Nov 2001 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280815AbRKBUOh>; Fri, 2 Nov 2001 15:14:37 -0500
Received: from inje.iskon.hr ([213.191.128.16]:2975 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S280817AbRKBUOb>;
	Fri, 2 Nov 2001 15:14:31 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Zlatko's I/O slowdown status
In-Reply-To: <Pine.LNX.4.33.0110261018270.1001-100000@penguin.transmeta.com>
	<87k7xfk6zd.fsf@atlas.iskon.hr> <20011102065255.B3903@athlon.random>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 02 Nov 2001 21:14:14 +0100
In-Reply-To: <20011102065255.B3903@athlon.random> (Andrea Arcangeli's message of "Fri, 2 Nov 2001 06:52:55 +0100")
Message-ID: <87g07xdj6x.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> Hello Zlatko,
> 
> I'm not sure how the email thread ended but I noticed different
> unplugging of the I/O queues in mainline (mainline was a little more
> overkill than -ac) and also wrong bdflush histeresis (pre-wakekup of
> bdflush to avoid blocking if the write flood could be sustained by the
> bandwith of the HD was missing for example).

Thank God, today it is finally solved. Just two days ago, I was pretty
sure that disk had started dying on me, and i didn't know of any
solution for that. Today, while I was about to try your patch, I got
another idea and finally pinpointed the problem.

It was write caching. Somehow disk was running with write cache turned
off and I was getting abysmal write performance. Then I found hdparm
-W0 /proc/ide/hd* in /etc/init.d/umountfs which is ran during shutdown
but I don't understand how it survived through reboots and restarts!
And why only two of four disks, which I'm dealing with, got confused
with the command. And finally I don't understand how I could still got
full speed occassionaly. Weird!

I would advise users of Debian unstable to comment that part, I'm sure
it's useless on most if not all setups. You might be pleasantly
surprised with performance gains (write speed doubles).

> 
> So you may want to give a spin to pre6aa1 and see if it makes any
> difference, if it makes any difference I'll know what your problem is
> (see the buffer.c part of the vm-10 patch in pre6aa1 for more details).
> 

Thanks for your concern. Eventually I compiled aa1 and it is running
correctly (whole day at work, and last hour at home - SMP), although I
now don't see any performance improvements.

I would like to thank all the others that spent time helping me,
especially Linus, Jens and Marcelo, sorry guys for taking your time.
-- 
Zlatko
