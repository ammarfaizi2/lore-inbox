Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267523AbRGMSVU>; Fri, 13 Jul 2001 14:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267522AbRGMSVK>; Fri, 13 Jul 2001 14:21:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:43529 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267520AbRGMSU6>;
	Fri, 13 Jul 2001 14:20:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107131820.f6DIKvg190902@saturn.cs.uml.edu>
Subject: Re: [PATCH] 64 bit scsi read/write
To: bcrl@redhat.com (Ben LaHaise)
Date: Fri, 13 Jul 2001 14:20:57 -0400 (EDT)
Cc: kernel@ragnark.vestdata.no (=?iso-8859-1?Q?Ragnar_Kj=F8rstad?=),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
In-Reply-To: <Pine.LNX.4.33.0107050310570.1063-100000@toomuch.toronto.redhat.com> from "Ben LaHaise" at Jul 05, 2001 03:35:31 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise writes:
> On Thu, 5 Jul 2001, Ragnar Kj\370rstad wrote:

>> What do you mean?
>> Is it not feasible to fix this in LVM as well, or do you just not know
>> what needs to be done to LVM?
>
> Fixing LVM is not on the radar of my priorities.  The code is sorely in
> need of a rewrite and violates several of the basic planning tenents that
> any good code in the block layer should follow.  Namely, it should have 1)
> planned on supporting 64 bit offsets, 2) never used multiplication,
> division or modulus on block numbers, and 3) don't allocate memory
> structures that are indexed by block numbers.  LVM failed on all three of
> these -- and this si just what I noticed in a quick 5 minute glance
> through the code.  Sorry, but LVM is obsolete by design.  It will continue
> to work on 32 bit block devices, but if you try to use it beyond that, it
> will fail.  That said, we'll have to make sure these failures are graceful
> and occur prior to the user having a chance at loosing any data.
> 
> Now, thankfully there are alternatives like ELVM, which are working on
> getting the details right from the lessons learned.  Given that, I think
> we'll be in good shape during the 2.5 cycle.

How does can any of this even work?

Say I have N disks, mirrored, or maybe with parity. I'm trying
to have a reliable system. I change a file. The write goes out
to my disks, and power is lost. Some number M, such that 0<M<N,
of the disks are written before the power loss. The rest of the
disks don't complete the write. Maybe worse, this is more than
one sector, and some disks have partial writes.

Doesn't RAID need a journal or the phase-tree algorithm?
How does one tell what data is old and what data is new?

