Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRHPWY1>; Thu, 16 Aug 2001 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbRHPWYR>; Thu, 16 Aug 2001 18:24:17 -0400
Received: from unthought.net ([212.97.129.24]:37512 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S268926AbRHPWYG>;
	Thu, 16 Aug 2001 18:24:06 -0400
Date: Fri, 17 Aug 2001 00:24:20 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Pavel Machek <pavel@suse.cz>
Cc: David Ford <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: "VM watchdog"? [was Re: VM nuisance]
Message-ID: <20010817002420.C30521@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Pavel Machek <pavel@suse.cz>, David Ford <david@blue-labs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B748AA8.4010105@blue-labs.org> <20010814140011.B38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010814140011.B38@toy.ucw.cz>; from pavel@suse.cz on Tue, Aug 14, 2001 at 02:00:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 02:00:11PM +0000, Pavel Machek wrote:
> Hi!
> 
...
> > Again, it doesn't matter if I have swap or not, if I get within ~6 megs 
> > of the end of memory, the kernel goes FMM.  I've tested with and without 
> > swap.  And _please_  don't tell me "just add more swap".  That's 
> > ludicruous and isn't solving the problem, it's covering up a symptom.
> 
> Maybe creating userland program that
> *) allocates few megs
> *) while 1 sleep 1m, gettimeofday. If more tha two minutes elapsed,
> 	tell OOM handler to kick in.

On my compute-server in the basement this is completely unacceptable because it
*may* just be working hard on something big.  The excessive swapping may just
be 10-30 minutes where some app is using way more memory than the box has RAM,
in this case it's no problem at all, and all your suggestion would give me is
randomly dying compute jobs.

On my desktop this is unacceptable as well. You want the system to be frozen
for more than two minutes before doing anything about it ?

The problem with using such vague heuristics against fixed (arbitrary) limits
is that the effect will almost always be completely unacceptable.  Either your
arbitrary limit is way too high, or way too low.

I can't tell you how to do it - but I think your suggestion is an excellent way
to *not* do it     :)

> 
> Or maybe kernel could have some "VM watchdog", which would trigger OOM if
> it is not polled once a minute...

Didn't everyone pretty much agree that if we could turn off overcommit
completely and reliably, that would be the preferred solution ?   Simply sig11
the app that's unlucky enough to want more memory than there's in the system
(or, horror, have malloc() fail)

Now, I don't remember the entire thread, but IIRC it was difficult to kill
overcommit completely.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
