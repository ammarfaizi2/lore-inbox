Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269795AbRHINMM>; Thu, 9 Aug 2001 09:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269794AbRHINLw>; Thu, 9 Aug 2001 09:11:52 -0400
Received: from host217-33-139-17.ietf.ignite.net ([217.33.139.17]:18824 "HELO
	bee5.dirksteinberg.de") by vger.kernel.org with SMTP
	id <S269793AbRHINLs>; Thu, 9 Aug 2001 09:11:48 -0400
Message-ID: <3B728C20.99A41239@dirksteinberg.de>
Date: Thu, 09 Aug 2001 14:12:00 +0100
From: "Dirk W. Steinberg" <dws@dirksteinberg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-mosix106 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <no.id> <E15Ulnx-0006zZ-00@the-village.bc.nu> <20010809125033.E1200@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to second that example where you have weak diskless nodes and
a big server with a lot of memory. The important point here is that the
remote paging does not need to really write to the remote disk, especially
not synchronously. The page could eventually be migrated to the remote
disk asynchronously, or maybe not at all if there is no memory pressure
at the remote system.

In such a scenario I would disagree with Alan that network paging is 
high latency as compared to disk access. I have a fully switched 100 Mpbs
full-duplex ethernet network, and sending a page across the net into
the memory of a fast server could have much less latency that writing 
that page out to a local old, slow IDE disk. Clusters could even have
special high-bandwidth, low latency networks that could be used for
remote paging.

In a perfect world, all nodes in a cluster would be able to dynamically 
share a pool of "cluster swap" space, so any locally available swap that
is not used could be utilized by other nodes in the cluster.

/ Dirk

Ingo Oeser wrote:
> On Thu, Aug 09, 2001 at 10:08:37AM +0100, Alan Cox wrote:
> > > what is the best/recommended way to do remote swapping via the network
> > > for diskless workstations or compute nodes in clusters in Linux 2.4?=20
> > > Last time i checked was linux 2.2, and there were some races related=20
> > > to network swapping back then. Has this been fixed for 2.4?
> >
> > The best answer probably is "don't". Networks are high latency things for
> > paging and paging is latency sensitive. If performance is not an issue then
> > the nbd driver ought to work. You may need to check it uses the right
> > GFP_ levels to avoid deadlocks and you might need to up the amount of atomic
> > pool memory. Hopefully other hacks arent needed
> 
> While we are on it: I have an old machine with 64MB of RAM and a
> new, fast machine with 1GB of RAM.
> 
> Sometimes I need more RAM on the old one and asked myself,
> whether I could first swap over network to the other one, into
> its tmpfs, before digging into real swap on a hard disk.
> 
> I have only three machines attached to this small internal
> 100Mbit LAN.
> 
> Both machines use Kernel 2.4.x.
