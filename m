Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCOXf5>; Thu, 15 Mar 2001 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRCOXfr>; Thu, 15 Mar 2001 18:35:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:35525 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129115AbRCOXfl>;
	Thu, 15 Mar 2001 18:35:41 -0500
Date: Fri, 16 Mar 2001 00:31:07 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103152331.AAA2159588.aeb@vlet.cwi.nl>
To: adilger@turbolinux.com, lars@larsshack.org, mikpe@csd.uu.se
Subject: Re: [util-linux] Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Cc: amnet@amnet-comp.com, hch@caldera.de, jjasen1@umbc.edu,
        linux-kernel@vger.kernel.org, util-linux@math.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've implemented a patch for util-linux-2.11a
> which adds LABEL support to mkswap(8) and swapon/swapoff(8).

Yes, maybe a reasonable idea.

But I would prefer a somewhat more ambitious approach.

My first thought was: why label individual swap partitions?
I almost never want to distinguish swap partitions, and just do
"swapon -a". In case one wants to guard against changing device names,
why not add an option -A so that "swapon -A" does swapon on each
partition with a swap signature?

However, that would greatly increase the risk that exists already
today: someone has a swap partition, and does mkfs.foo, and
it so happens that foofs does not use the sector with the swapsignature.
Now this foofs partition has a swap signature, but we would be very
unhappy if it were used as swap space.

The real problem is that our disks usually do not have a volume label.
Outside of all file systems.
The "signatures" that we rely on today are located in different places,
so that a filesystem can have several valid signatures at the same time.
And we first know where to look when we know the type already.

Design a Linux partition table format, where a partition descriptor
has fields start, end, fstype, fslabel, and the whole disk has a vollabel.
Put it in sector 0-N for an all-Linux disk, and in sectors pointed at
by a classical DOS-type partition table entry when the disk is shared.

(Maybe I already did that once - it sounds so familiar now that I write
this. Then why was it not pursued? Maybe LVM already does these things?)

Andries
