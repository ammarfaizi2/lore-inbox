Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318386AbSGaO5D>; Wed, 31 Jul 2002 10:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSGaO5D>; Wed, 31 Jul 2002 10:57:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60941 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318386AbSGaO5C>; Wed, 31 Jul 2002 10:57:02 -0400
Date: Wed, 31 Jul 2002 10:54:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: jeff millar <wa1hco@adelphia.net>, Jakob Oestergaard <jakob@unthought.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
In-Reply-To: <15687.23114.805995.595589@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.3.96.1020731104418.9356B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Neil Brown wrote:

> On Tuesday July 30, wa1hco@adelphia.net wrote:
> > 
> > Raid needs an automatic way to maintain device synchronization.  Why should
> > I have to...
> >     manually examine the device data (lsraid)
> >     find two devices that match
> >     mark the others failed in /etc/raidtab
> >     reinitialize the raid devices...putting all data at risk
> >     hot add the "failed" device
> >     wait for it to recover (hours)
> >     change /etc/raidtab again
> >     retest everything
> > 
> > This is 10 times worse that e2fsck and much more error prone.  The file
> > system guru's worked hard on journalling to minimize this kind of risk.
> > 
> 
> Part of the answer is to use mdadm
>    http://www.cse.unsw.edu.au/~neilb/source/mdadm/
> 
> mdadm --assemble --force ....
> 
> will do a lot of that for you.

Gotit! Thank you, I'll give this a cautious try as soon as I have a system
I can boink, perhaps this weekend, definitely if it rains and I don't have
to do things outside;-)
 
> Another part of the answer is that raid5 should never mark two drives
> as failed.  There really isn't any point.
> If they are both really failed, you've lost your data anyway.
> If it is really a cable failure, then it should be easier to get back
> to where you started from.
> I hope to have raid5 working better in this respect in 2.6.

Do the drivers currently do a bus reset after a device fail? That is,
after the last attempt to access the device before returning an error? If
the retries cause the failed sevice to hang the bus again, the final reset
might give function on other drives. Clearly that's not a cure-all, and I
think it would have to be at the driver level. I know some drivers do try
a reset, because they log it, but I don't remember if they do a final
reset when they give up.
 
> A finally part of the answer is that even perfect raid software cannot
> make up for buggy drivers, shoddy hard drives, or flacky cabling.

No question there, but not always shoddy... I got some drives from a major
vendor I'd not name without asking a lawyer, and until I got a firmware
upgrade two weeks later they were total crap. It would seem that Linux
does some thing which Win/NT don't in terms of command sequences. I'm
guessing an error in the state table stuff, but {vendor} wouldn't say.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

