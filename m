Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSIBXPg>; Mon, 2 Sep 2002 19:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSIBXP3>; Mon, 2 Sep 2002 19:15:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47886 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318542AbSIBXP0>; Mon, 2 Sep 2002 19:15:26 -0400
Date: Mon, 2 Sep 2002 16:27:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <20020902230824.GB9359@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209021622330.1265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Andries Brouwer wrote:
> 
> I think it important to get rid of partition table reading in the kernel.

Why? 

> It (pt reading) is wrong in principle, as we agree already.

No, we don't agree.

I see that some people would like to remove it from the kernel, and I'm 
not violently opposed to it if it can be done without breaking existing 
behaviour.

But I do _not_ see any really fundamental reason why the kernel shouldn't
parse the partition tables. I see a lot of problems if the kernel were to 
stop, and I don't see a lot of advantages to not doing so.

> But there are also all kinds of practical reasons.
> 
>  One argument is that our traditional DOS-type partition table will soon
>  be at the end of its useful life. Yes, maybe it survives a few more years
>  but our own stability requires slow changes, so we must start thinking a
>  long time in advance.

That's a bad argument. It's not as if we want to have random formats for 
this thing. Partitioning is damn important, and it has to be portable 
across different machines and different operating systems. That all means 
that there is absolutely _zero_ incentive to make up a partition format of 
our own, since there are perfectly fine and existing formats.

>  Another argument is that it sometimes takes a *long* time, like several
>  minutes, especially when this reading triggers hardware bugs.

This is only an argument for doing it on demand, not for dropping it.

>  Another argument is that nobody knows whether there is a partition table.
>  In the case of ZIP drives there sometimes is a jumper or special SCSI command
>  to switch between the "large floppy" and "removable disk" statuses, and
>  the kernel doesnt know.
>  Another argument is that tricky things happen in the presence of disk managers.

And none of these work any better in user space.

> > But if that is the case, then we _still_ need to fix the media change and 
> > partition read issue. Right? Which brings back _all_ my points for why it 
> > should be done at open time, and by the generic routine. Agreed?
> 
> The above was mainly about the partition reading at boot time.
> There are two other situations: partition reading at insmod time,
> and partition reading at media change time.
> 
> But these are easier situations. There is a functioning userspace already.

You seem to think that kernel space somehow cannot do something that user 
space can. I just don't see the overriding problems you claim.

		Linus

