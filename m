Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSI0GR0>; Fri, 27 Sep 2002 02:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSI0GR0>; Fri, 27 Sep 2002 02:17:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9993 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261642AbSI0GRZ>; Fri, 27 Sep 2002 02:17:25 -0400
Date: Thu, 26 Sep 2002 23:21:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "David S. Miller" <davem@redhat.com>
cc: jgarzik@pobox.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [RFC] {read,write}s{b,w,l} or iobarrier_*()
In-Reply-To: <20020926.141223.128110378.davem@redhat.com>
Message-ID: <Pine.LNX.4.10.10209261951560.13669-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, David S. Miller wrote:

>    From: Jeff Garzik <jgarzik@pobox.com>
>    Date: Thu, 26 Sep 2002 12:23:41 -0400
> 
>    Benjamin Herrenschmidt wrote:
>    >  - Have all archs provide {read,write}s{b,w,l} functions.
>    > Those will hide all of the details of bytewapping & barriers
>    > from the drivers and can be used as-is for things like IDE
>    > MMIO iops.
>    
>    I prefer this solution...
> 
> I'm starting to think about taking back all the previous
> arguments I had against this idea.  It's starting to sound
> like the preferred way to go.

Hi Dave,

One of the main reasons for changing the core iops of the ata/ide driver
results from newer HBA's either supporting dual transports modes or in
some case exclusive MMIO, similar to current IOMIO x86 HBA's today.

Additionally, I suspect the current dual path for execution may end up
going N-ways.  As there are a few PATA hosts and in the future all SATA
hosts will convert to the FP-DMA (First Party DMA) messaging service
protocol.

This will then make (3) different execution transports.  The bad news is
during transition period (just now starting) it will become more painful
if we do not make the drive independent of iops regardless of arch/bus
issues.

One of the key ideas hottly debated between Ben, Jeff, and myself were the
impacts resulting from this change in direction.  Obviously Ben lives in a
world of MMIO and has suffered with a driver which was designed around
IOMIO.  Thus all the bastardized macros we all hate resulted from
x86-centric lameness (industry driven for the most part, yeah me included).

Now if we expand the issue into Jeff's world of the net-stack drivers, he
banged me over the head with the issue of "pci-posting delays".  Ben got
his shots in also about the issue, too.  Thus the resulting io_barrier
additions by Ben to the original ATA-driver transformation, can be extened
to the Net-Drivers.  Oh and the slope is increasing fast now.

So if it works for ATA and NET, could it not migrate to all hardware?
If it makes it to all hardware, should it not be coupled to the BUS?
If it is coupled to the BUS, are there going to be problems with
exceptions?

Well once I leave ATA (storage in general), I am not really able to
discuss those issues from a position of first hand experience.  So here is
my nickel spent.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


