Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280839AbRKBVRF>; Fri, 2 Nov 2001 16:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280844AbRKBVQx>; Fri, 2 Nov 2001 16:16:53 -0500
Received: from inje.iskon.hr ([213.191.128.16]:952 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S280839AbRKBVQf>;
	Fri, 2 Nov 2001 16:16:35 -0500
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Zlatko's I/O slowdown status
In-Reply-To: <Pine.LNX.4.33.0111021215260.15759-100000@windmill.gghcwest.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 02 Nov 2001 22:16:28 +0100
In-Reply-To: <Pine.LNX.4.33.0111021215260.15759-100000@windmill.gghcwest.com> ("Jeffrey W. Baker"'s message of "Fri, 2 Nov 2001 12:16:40 -0800 (PST)")
Message-ID: <87bsikeuvn.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" <jwbaker@acm.org> writes:

> On 2 Nov 2001, Zlatko Calusic wrote:
> 
> > Andrea Arcangeli <andrea@suse.de> writes:
> >
> > > Hello Zlatko,
> > >
> > > I'm not sure how the email thread ended but I noticed different
> > > unplugging of the I/O queues in mainline (mainline was a little more
> > > overkill than -ac) and also wrong bdflush histeresis (pre-wakekup of
> > > bdflush to avoid blocking if the write flood could be sustained by the
> > > bandwith of the HD was missing for example).
> >
> > Thank God, today it is finally solved. Just two days ago, I was pretty
> > sure that disk had started dying on me, and i didn't know of any
> > solution for that. Today, while I was about to try your patch, I got
> > another idea and finally pinpointed the problem.
> >
> > It was write caching. Somehow disk was running with write cache turned
> > off and I was getting abysmal write performance. Then I found hdparm
> > -W0 /proc/ide/hd* in /etc/init.d/umountfs which is ran during shutdown
> > but I don't understand how it survived through reboots and restarts!
> > And why only two of four disks, which I'm dealing with, got confused
> > with the command. And finally I don't understand how I could still got
> > full speed occassionaly. Weird!
> >
> > I would advise users of Debian unstable to comment that part, I'm sure
> > it's useless on most if not all setups. You might be pleasantly
> > surprised with performance gains (write speed doubles).
> 
> That's great if you don't mind losing all of your data in a power outage!

That has nothing to do with power outage, it is only run during
halt/poweroff. 

> What do you think happens if the software thinks data is committed to
> permanent storage when in fact it in only in DRAM on the drive?
> 

Bad things of course. But -W0 won't save you from file corruption when
you have megabytes of data in page cache, still not synced on disk,
and suddenly you lost power.

Of course, journalling filesystems will change things a bit...
-- 
Zlatko
