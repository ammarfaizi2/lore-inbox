Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280818AbRKBUU6>; Fri, 2 Nov 2001 15:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280819AbRKBUUq>; Fri, 2 Nov 2001 15:20:46 -0500
Received: from [65.198.37.66] ([65.198.37.66]:60893 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S280818AbRKBUUg>; Fri, 2 Nov 2001 15:20:36 -0500
Date: Fri, 2 Nov 2001 12:16:40 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Zlatko's I/O slowdown status
In-Reply-To: <87g07xdj6x.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.33.0111021215260.15759-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Nov 2001, Zlatko Calusic wrote:

> Andrea Arcangeli <andrea@suse.de> writes:
>
> > Hello Zlatko,
> >
> > I'm not sure how the email thread ended but I noticed different
> > unplugging of the I/O queues in mainline (mainline was a little more
> > overkill than -ac) and also wrong bdflush histeresis (pre-wakekup of
> > bdflush to avoid blocking if the write flood could be sustained by the
> > bandwith of the HD was missing for example).
>
> Thank God, today it is finally solved. Just two days ago, I was pretty
> sure that disk had started dying on me, and i didn't know of any
> solution for that. Today, while I was about to try your patch, I got
> another idea and finally pinpointed the problem.
>
> It was write caching. Somehow disk was running with write cache turned
> off and I was getting abysmal write performance. Then I found hdparm
> -W0 /proc/ide/hd* in /etc/init.d/umountfs which is ran during shutdown
> but I don't understand how it survived through reboots and restarts!
> And why only two of four disks, which I'm dealing with, got confused
> with the command. And finally I don't understand how I could still got
> full speed occassionaly. Weird!
>
> I would advise users of Debian unstable to comment that part, I'm sure
> it's useless on most if not all setups. You might be pleasantly
> surprised with performance gains (write speed doubles).

That's great if you don't mind losing all of your data in a power outage!
What do you think happens if the software thinks data is committed to
permanent storage when in fact it in only in DRAM on the drive?

-jwb

