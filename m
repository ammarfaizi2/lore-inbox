Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317801AbSGPIj7>; Tue, 16 Jul 2002 04:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317802AbSGPIj6>; Tue, 16 Jul 2002 04:39:58 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:20531 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317801AbSGPIj4>; Tue, 16 Jul 2002 04:39:56 -0400
Date: Tue, 16 Jul 2002 09:42:34 +0100
To: Kevin Corry <corryk@us.ibm.com>
Cc: linux-lvm@sistina.com, Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [Announce] device-mapper beta3 (fast snapshots)
Message-ID: <20020716084234.GA431@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com> <20020715124035.GA4609@fib011235813.fsnet.co.uk> <02071513565400.06209@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02071513565400.06209@boiler>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,

On Mon, Jul 15, 2002 at 01:56:54PM -0500, Kevin Corry wrote:
> In the current design, there are two cases when the COW table is written to 
> disk. Either when current COW sector is full, or on a clean system shutdown. 
> All snapshots will thus be persistent across a clean shutdown or reboot. 
> Currently, an async snapshot will be disabled if the system crashes. This 
> wasn't a big secret. In the latest HOWTO, the section on snapshotting 
> explains this, and in the EVMS gui, there is a note attached to the "async" 
> option saying this as well.
> 
> We designed async snapshots in EVMS for maximum performance. Allowing for the 
> one above condition provides for a significant performance increase. Writing 
> the COW table only when it's full prevents a lot of unnecessary disk head 
> seeking.

...

> But, the synchronous option is still available 
> for those who are scared about system crashes. Personally, I'm not that 
> scared. I'd have a hard time remembering the last time one of my production 
> machines crashed unexpectedly.

So you are saying that your async snapshots should only be used on
production machines, and where the data stored on the snapshot is so
unimportant that you don't mind loosing it.  Nice.

In future could you mention this caveat when you post comparison
benchmarks.

device-mapper *does* ensure that the snapshot is always consistent.

I don't believe the benchmarks posted at the top of this thread at
all.  Not only are you claiming poor performance for device-mapper,
but that this performance degrades as chunk size reduces.
device-mapper has been tested by a variety of people on many different
machines/architectures and we've only ever seen a flat performance
profile as chunk size increases, if anything, there is a very slight
degradation as chunk size gets too large.

For instance I just ran a test on my dev. box, this should
not be considered a tuned benchmark by any means.

dbench -2 on a 32M RAM system:

no snapshot	8.22
8k		13.59
16k		13.99
32k		13.33
64k		12.90
128k		13.442
256k		13.654
512k		13.84

As far as I'm concerned you should be comparing this with the slower
but consistent synchronous snapshots in EVMS.

- Joe
