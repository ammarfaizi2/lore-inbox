Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133030AbRDLATK>; Wed, 11 Apr 2001 20:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133031AbRDLATB>; Wed, 11 Apr 2001 20:19:01 -0400
Received: from chmls20.mediaone.net ([24.147.1.156]:25550 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S133030AbRDLASr>; Wed, 11 Apr 2001 20:18:47 -0400
Message-ID: <001001c0c2e6$fec27f80$6501a8c0@gonar.com>
From: "Mark Salisbury" <gonar@mediaone.net>
To: "george anzinger" <george@mvista.com>
Cc: <high-res-timers-discourse@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com> <3AD38464.A1F97AC8@mvista.com> <002a01c0c221$32703e60$6501a8c0@gonar.com> <3AD3C2FB.79BB07E0@mvista.com>
Subject: Re: No 100 HZ timer !
Date: Wed, 11 Apr 2001 20:24:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect you might go for ticked if its overhead was less.  The thing
> that makes me think the overhead is high for tick less is the accounting
> and time slice stuff.  This has to be handled each system call and each
> schedule call.  These happen WAY more often than ticks...  Contrary
> wise, I would go for tick less if its overhead is the same or less under
> a reasonable load.  Of course, we would also want to check overload
> sensitivity.

as I said, i think the process time accounting is disjoint from the
ticked/tickless issue and should therefore be considered seperately..

in my experience with the tickless method, after all pending timers have
been serviced, then to determine the interval until the next interrupt
should be generated all that is needed is one 64 bit subtraction and a
register load (about 5 - 8 cycles)

I think we should spend some serious time with some quick and dirty
prototypes of both methods, both to characterize all the issues raised and
to refine our ideas when it comes time to implement this.

I also think that we should give some thought to implementing both an
improved ticked system and a tickless system to be chosen as CONFIG options
so that the developer putting together a system can make a choice based on
their needs, and not our whims.  I am more than willing to concede that
there is a class of customer to whom a ticked system is appropriate, but I
am quite sure that there is a class for whom the ticked model is completely
unacceptable.

> On a half way loaded system?  Do you think it is that high?  I sort of
> think that, once the system is loaded, there would be a useful timer
> tick most of the time.  Might be useful to do some measurements of this.

any non-useful tick takes away cycles that could be better used performing
FFT's

there are many kinds of loads, some which generate large numbers of timed
events and some that generate none or few.
I think we want to be able to provide good solutions for both cases even.

we should do lots of measurements.

    Mark


