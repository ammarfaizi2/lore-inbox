Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSHAPfs>; Thu, 1 Aug 2002 11:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSHAPfs>; Thu, 1 Aug 2002 11:35:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:30996 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315459AbSHAPfq>; Thu, 1 Aug 2002 11:35:46 -0400
Date: Thu, 1 Aug 2002 17:39:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.19rc3aa4 once again?
Message-ID: <20020801153911.GC1132@dualathlon.random>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es> <20020709124807.D1510@mail.muni.cz> <20020710163422.GB2513@dualathlon.random> <20020801113124.GA755@mail.muni.cz> <20020801140348.GM1132@dualathlon.random> <20020801141940.GB755@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801141940.GB755@mail.muni.cz>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 04:19:40PM +0200, Lukas Hejtmanek wrote:
> On Thu, Aug 01, 2002 at 04:03:48PM +0200, Andrea Arcangeli wrote:
> > you can use elvtune, in my more recent trees I returned in sync with
> > mainline with the parameters to avoid being penalized in the benchmarks,
> > but if you need lower latency you can execute stuff like this by yourself.
> > 
> > 	elvtune -r 10 -w 20 /dev/hd[abcd] /dev/sd[abcd]
> > 
> > etc... (hda or hda[1234] will be the same, it only care about disks)
> > 
> > the smaller the lower latency you will get. In particular you care about
> > the read latency, so the -r parameters is the one that has to be small
> > for you, writes can be as well big.
> 
> Hmm however I think i/o subsystem should allow parallel reading/writing don't
> you think?

of course it does, what you're tuning is the "how many requests can
delay a read request" or "how many requests can delay a write request"?

it's not putting synchronous barriers, it only controls the ordering.

If a read requests can ba passed by 10mbytes of data you will
potentially read one block every 10mbyte written to disk. Of course
there will be less seeks and the global workload will be faster (faster
at least for most cases), but your read latency will be very very bad.

You can see the default values by not passing arguments to elvtune IIRC.

Andrea
