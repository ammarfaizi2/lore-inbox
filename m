Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264416AbRFTQxf>; Wed, 20 Jun 2001 12:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFTQxZ>; Wed, 20 Jun 2001 12:53:25 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:20614 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264327AbRFTQxI>; Wed, 20 Jun 2001 12:53:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Wed, 20 Jun 2001 07:52:09 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010619090956.R3089@work.bitmover.com> <20010619095239.T3089@work.bitmover.com> <lATeaC.A.K1B.HD-L7@dinero.interactivesi.com>
In-Reply-To: <lATeaC.A.K1B.HD-L7@dinero.interactivesi.com>
MIME-Version: 1.0
Message-Id: <01062007520902.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 June 2001 19:31, Timur Tabi wrote:

> Amen.  This is one of the reasons why I also prefer OS/2 over Linux.

Preferred.

OS/2's day has come and gone.  IBM killed it with a stupid diversion into the 
power PC version between 1993 and 1995.  By the time Windows 95 was released, 
MS had finally (after 11 years) managed to properly clone the original 1984 
macintosh, and 90% of the PC user base was no longer actively looking to 
replace their OS (Windows 3.1 and/or DOS).  The window of opportunity for a 
proprietary OS to replace Microsoft's had closed, and OS/2 4.0 was just plain 
too late.  (If it had been released two years earlier, things might have been 
different.  But it wasn't.)

But the window to commoditize a propreitary niche never closes.  The PC 
clones didn't care whether digital's minicomputers or IBM's mainframes won 
out in the marketplace, they were quite happy to replace both.  Linux is 
winning because it's free software, not for whatever transient technical 
reasons make one version of an OS better than another on a given day.

> Feature Installer is a bad example.  That software is a piece of crap for
> lots of reasons, excessive threading being only one, and every OS/2 user
> knew it the day it was released.  Why do you think WarpIN was created?

I know, and I'm sorry I rescued FI from the corpse of OS/2 for the Power PC.  
But it was my job, you know. :)  (And I did rewrite half of it from scratch.  
Before that it didn't work at ALL.  There were algorithms in there that 
scaled (failed to scale) to n^n complexity on the object hierarchy.  
Unfortunately, IBM wouldn't let me rewrite the other half of it, and most of 
that was pretty darn obnoxious and evil.)

Isn't it interesting that OS/2 turned into a unix platform?  (EMX and gcc, 
where all the software was coming from?  I think I tried to point that out to 
you when I attempted to recruit you into the LInux world at that gaming 
session at armadillocon in... 1999?  Glad to see you did eventually come over 
to the chocolate side of the force after all... :)

> Not quite.  What makes OS/2's threads superior is that the OS multitasks
> threads, not processes.  So I can create a time-critical thread in my
> process, and it will have priority over ALL threads in ALL processes.

And in Linux you can create a time-critical process that shares large gorps 
of memory where you keep your global variables, and call it a thread, and it 
works the same way.

My only real gripe with Linux's threads right now (other than the fact they 
keep trying to get us to use the posix api, which sucks.  What IS an event 
variable.  What's wrong with event semaphores?) is that ps and top and such 
aren't thread aware and don't group them right.

I'm told they added some kind of "threadgroup" field to processes that allows 
top and ps and such to get the display right.  I haven't noticed any 
upgrades, and haven't had time to go hunting myself.  (Ever tried to sumit a 
patch to the FSF?  They want you to sign legal documents.  That's annoying.  
I usually just send the bug reports to red hat and let THEM deal with it...)

> A lot of OS/2 software is written with this feature in mind.  I know of one
> programmer who absolutely hates Linux because it's just too difficult
> porting software to it, and the lack of decent thread support is part of
> the problem.

Yup.  OS/2 is the largest nest of trained, experienced multi-threaded 
programmers.  (And it takes a LOT of training experience to do threads 
right.)  That's why I've been trying to recruit ex-OS/2 guys over to Linux 
for years now.  (Most followed Java to Linux after Netscape opened up 
Mozilla, but there used to be several notable holdouts...)

Threading is just another way to look at programming, with both advantages 
and disadvantages.  You get automatic SMP scalability that's quite nice if 
you keep cache coherency in mind.  You get great latency and responsiveness 
in user interfaces with just one or two extra threads.  (State machines may 
be superior if implemented perfectly, but like co-operative multitasking 
(which they are) it's trivially easy to block the suckers and hang the whole 
GUI.  If you hang one thread, you can even program another thread to notice 
automatically and unwedge it without much overhead at all.  Trying to unwedge 
a state machine is a little more complicated than kill/respawn of a thread.  
Of course a perfect state machine shouldn't have those problems, but when you 
interface with other people's code in a large system, you accept imperfection 
and make the system survive as best it can.)

> Exactly.  Saying that threads cause bad code is just as dumb as saying that
> a kernel debugger will cause bad code because programmers will start using
> the debugger instead of proper design.
>
> Oh wait, never mind .....

Ah, don't pick on Linus.  It's not exactly like the limiting factor to kernel 
development is a SHORTAGE of patches sent in to the various maintainers.

Linus's job is to keep code OUT of the kernel.  He has veto power, nothing 
else.  I suspect he's pre-emptively vetoing some stuff to keep the flood down 
to a level he can deal with.  Maybe someday we'll convince him to use some 
variant of source control (not necessarily CVS, how about just a seperate 
mailing list of the individual patches as he applies them?  One linus can 
post to and that is read-only to everybody else?  HE always wants patches 
seperated down nicely into individual messages with explanations, but WE have 
to get pre2-pre3 as one big patch lump.  With a patches-from-linus mailing 
list that he forwarded posts to, we'd know exactly when a patch went in and 
who it was from without bothering Linus. :)

Maybe something like that would allow a bit more decentralization, and then 
he'd feel like he could keep his head above water if he allowed in a kernel 
debugger.  Who knows?

Rob
