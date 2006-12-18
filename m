Return-Path: <linux-kernel-owner+w=401wt.eu-S1754376AbWLRSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbWLRSd4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbWLRSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:33:56 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:11046 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754375AbWLRSdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:33:55 -0500
Message-ID: <4586DF1D.6040501@cfl.rr.com>
Date: Mon, 18 Dec 2006 13:34:05 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Wiebe Cazemier <halfgaar@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Software RAID1 (with non-identical discs) performance
References: <em0pdq$r7o$2@sea.gmane.org>
In-Reply-To: <em0pdq$r7o$2@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2006 18:34:06.0954 (UTC) FILETIME=[19CB34A0:01C722D3]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14880.003
X-TM-AS-Result: No--7.786400-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiebe Cazemier wrote:
> When using non-identical discs (not just size, but also geometry) to contruct
> your array, you can never get the partitions of the underlying discs to be
> equal in size because the size of a partition can only be N*cylindersize,
> where cylindersize varies across discs; the array always assumes the size of
> the smallest partition. When one of the discs fails, you need to replace it
> and make a partition that is exactly equal in size to the array, but because
> that usually is impossible, it mostly will be bigger. To cover for this, I
> have always left a small bit of unpartioned space on my discs. This not only
> provides me with headroom in making the partitions on discs with different
> geometry, but it's also possible that brand B's 250 GB is a little smaller
> than brand A's, and staying (well) below the 250 GB, makes sure any 250 GB
> disc fits in the array.

The entire concept of geometry is a a carryover from days gone by. 
These days it is just a farse maintained for backwards compatibility. 
You can put fdisk into sector mode with the 'u' command and create 
partitions of any number of sectors you desire, regardless of the 
perceived geometry.

> My first question is, is this a necessary/convenient technique to ensure you
> can replace discs over time, especially when you can't get the exact same
> replacement disc?

I don't believe you need to do anything; md will simply not use the few 
extra sectors at the end of the larger disk/partition and round down to 
the appropriate size.

> My second question is about the performance impact of using non-identical discs
> and partitions. I can't really find any info about this, but I've read someone
> making the statement that it would slow things down.

Yes, it slows things down.  You want to try to match disk speeds as 
closely as possible for best performance.

> My third question: write performance of RAID1 is usually lower than non-RAID,
> because the data has to be sent over the bus twice. But, with for example an
> NForce4 based mainboard using SATA, does that matter? I don't know if the SATA
> ports are connected to the chipset by means of PCI express or hypertransport,
> but both should be able to handle the double data transfer with room to spare.
> So, as I understand it, as long as the kernel can perform both transfers
> simultaniously, there should be no slow down, because when writing, there will
> simply be two discs writing data simultaniously, at the same speed one drive
> would. Is this correct?

Theoretically yes, more time will be spent sending the data across the 
bus twice, but most systems have enough spare capacity there that you 
probably won't notice.


