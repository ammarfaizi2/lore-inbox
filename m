Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSHHEFN>; Thu, 8 Aug 2002 00:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSHHEFM>; Thu, 8 Aug 2002 00:05:12 -0400
Received: from smtp01.web.de ([194.45.170.210]:2829 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S317352AbSHHEFM>;
	Thu, 8 Aug 2002 00:05:12 -0400
Date: Wed, 7 Aug 2002 22:55:42 +0200
From: Lars Ellenberg <l.g.e@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: stacked bdev driver, howto? locking of lower level block device
Message-ID: <20020807205542.GA2359@johann>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020805221652.A4250@johann> <20020807105059.A18751@vato.org> <20020805221652.A4250@johann> <200208060542.g765gc856679@sullivan.realtime.net> <20020805221652.A4250@johann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020807105059.A18751@vato.org> <200208060542.g765gc856679@sullivan.realtime.net> <20020805221652.A4250@johann>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, I got some answers. not that much though.

On Mon, Aug 05, 2002 at 10:16:52PM +0200, I wrote:
> I'd like to implement some kind of locking of the lower level
> block device, so nobody can mount it/modify it underneath the drbd
> driver.
> 
> I know drivers/md/md.c does this somehow. I tried to understand
> and adapt, but it does not work.
to be more explicit:
/*
 * prevent the device from being mounted, repartitioned or
 * otherwise reused by a RAID array (or any other kernel
 * subsystem), by opening the device. [simply getting an
 * inode is not enough, the SCSI module usage code needs
 * an explicit open() on the device]
 */
static int lock_rdev(mdk_rdev_t *rdev)

but this does _not_ prevent the device from being mounted or used, I
did not check the repartitioning.

On Tue, Aug 06, 2002 at 12:42:38AM -0500, Milton Miller suggested:
>> In 2.5 see bd_claim and bd_release in fs/block_dev.c
well, I need to have this on 2.4 for now. I did not check the 2.5 code
yet. other opinions whether this will work when we swithc to 2.5?

>> In 2.4 as fars as I know you have to add yourself to the list of checks
>> that are incomplete and don't all check against each other (swap,
>> filesystems, raid, etc).
could someone be so kind an be more explicit please.
what piece of code do "list of checks" translate to?

or do I have to follow this?
On Wed, Aug 07, 2002 at 10:51:00AM -0700, Tim Pepper had the impression:
>> this is not possible from what I've seen inside the kernel.  You can
>> do a bdget/blkdev_get() on teh underlying dev, but as far as I saw
>> that only prevents somebody from fdisking the device.
>> 
>> I think a lot of people figure this is just in line with the unix way
>> of allowing you to shoot yourself in the foot if you want.  I don't
>> have a big problem with that, but understand the arguments to the
>> contrary.
is this the case? it is not possible?
I understand that all this is not that important, but I want do do it
anyways, to reduce the careless foot shooter. I suppose, iff someone
really wants to, the shooting can be done with raw io anyways.
no problem, then every now and then someone will have to do some
transplantation...

BTW: why can I mount just about every device multiple times on different
     mountpoints at the same time?

ok, my questions remain:
> 
> - How does block device locking work?
> - In which mode do I have to open it?
> - Which flags have to be set?
> - What else am I missing?

Thanks.
	Lars-Gunnar
