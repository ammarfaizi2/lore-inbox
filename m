Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318934AbSICVCb>; Tue, 3 Sep 2002 17:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSICVCb>; Tue, 3 Sep 2002 17:02:31 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:4869 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318934AbSICVC3>;
	Tue, 3 Sep 2002 17:02:29 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209032107.g83L71h10758@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <20020903185344.GA7836@marowsky-bree.de> from Lars Marowsky-Bree
 at "Sep 3, 2002 08:53:44 pm"
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Tue, 3 Sep 2002 23:07:01 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, root@chaos.analogic.com,
       Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Lars Marowsky-Bree wrote:"
> On 2002-09-03T18:29:02,
>    "Peter T. Breuer" <ptb@it.uc3m.es> said:
> 
> > > Lets say you have a perfect locking mechanism, a fake SCSI layer
> > OK.
> 
> BTW, I would like to see your perfect distributed locking mechanism.

That bit's easy and is done. The "trick" is NOT to distribute the lock,
but to have it in one place - on the driver that guards the remote
disk resource.

> > The directory entry would certainly have to be reread after a write
> > operation on disk that touched it - or more simply, the directory entry
> > would have to be reread every time it were needed, i.e. be uncached.
> 
> *ouch* Sure. Right. You just have to read it from scratch every time. How
> would you make readdir work?

Well, one has to read it from scratch. I'll set about seeing how to do.
CLues welcome.

> > If that presently is not possible, then I would like to think about
> > making it possible.
> 
> Just please, tell us why.

You don't really want the whole rationale. It concerns certain 
european (nay, world ..) scientific projects and the calculations of the
technologists about the progress in hardware over the next few years.
We/they foresee that we will have to move to multiple relatively small
distributed disks per node in order to keep the bandwidth per unit of
storage at the levels that they will have to be at to keep the farms
fed.  We are talking petabytes of data storage in thousands of nodes
moving over gigabit networks.

The "big view" calculations indicate that we must have distributed
shared writable data.

These calculations affect us all. They show us what way computing
will evolve under the price and technology pressures. The calculations
are only looking to 2006, but that's what they show. For example
if we think about a 5PB system made of 5000 disks of 1TB each in a GE
net, we calculate the aggregate bandwidth available in the topology as
50GB/s, which is less than we need in order to keep the nodes fed
at the rates they could be fed at (yes, a few % loss translates into
time and money).  To increase available bandwidth we must have more
channels to the disks, and more disks, ... well, you catch my drift.

So, start thinking about general mechanisms to do distributed storage.
Not particular FS solutions.

Peter
