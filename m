Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRKMOZP>; Tue, 13 Nov 2001 09:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281632AbRKMOZG>; Tue, 13 Nov 2001 09:25:06 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21493 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276424AbRKMOY7>; Tue, 13 Nov 2001 09:24:59 -0500
Importance: Normal
Subject: Re: [Evms-devel] Re: Re: Hardsector size support in 2.4 and 2.5
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@caldera.de>, dalecki@evision.ag,
        linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF2769A354.FD887DD7-ON85256B03.004C650C@raleigh.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Tue, 13 Nov 2001 08:24:42 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/13/2001 09:24:48 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13 2001, Jens Axboe wrote:
> On Mon, Nov 12 2001, Christoph Hellwig wrote:
> > On Mon, Nov 12, 2001 at 02:05:19PM -0600, Mark Peloquin wrote:
> > > So any block device, can always expect to receive buffer heads
> > > whose b_rsector value represents the offset from the beginning
> > > of that device in 512 byte multiples? And this will continue
> > > to hold true in 2.5 as well?
> >
> > There is a good chance that no 2.5 block driver will ever see a
buffer_head,
> > take a look at
http://www.kernel.org/pub/linux/kernel/people/axboe/v2.5/ for
> > details.

> To expand on the specific point -- in 2.5, what will change is that
> b_rsector (or equiv field, bi_sector in bio) will be offset from the
> beginning of the disk, not the beginning of the partition. This moves
> toe partion remaps out of the driver itself.

This is an important difference, so I'd like to make sure I fully
understand the scope. Ok, so bi_sector for partitions will be
disk relative, not partition relative. I'll assume that bi_sector
will be set inside of submit_bh. So top level block devices always
see something that is disk relative. Is this change ONLY for
partitions? And if not, how will this affect what top and
intermediate levels of stacked block devices receive for a
bi_sector value? If I had MD on LVM on partitions, what would
bi_sector value initially be relative to? The MD device, the
LVM device, or the disk underlying the partitions? It seems it
would need to be set relative to the MD device. If so, then either
partitions or MD/LVM (non-partition devices) would seem to have to
be special cased. I could continue going on making assumptions and
theorizing the affects, but I'll stop here and wait for your
clarification on how you see things working.

Mark

