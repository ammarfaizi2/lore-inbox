Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282568AbRKZVkX>; Mon, 26 Nov 2001 16:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282583AbRKZVjJ>; Mon, 26 Nov 2001 16:39:09 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58885
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282598AbRKZViJ>; Mon, 26 Nov 2001 16:38:09 -0500
Date: Mon, 26 Nov 2001 13:36:06 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Steve Brueggeman <xioborg@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <b0b50u0s566g9fusmrfs275lsjvr0dd0hu@4ax.com>
Message-ID: <Pine.LNX.4.10.10111261323270.9208-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Steve Brueggeman wrote:

> Well, since you don't clearify what part you object to, I'll have to
> assume that you object to my statement that the disk drive will not
> auto-reallocate when it cannot recover the data.
> 
> If you think that a disk drive should auto-reallocate a sector (ARRE
> enabled in the mode pages) that it cannot recover the original data
> from, than you can dream on.  I seriously hope this is not what you're

One has to go read the general purpose error logs to determine the
location of the original platter assigned sector of the relocated LBA.

Reallocation generally occurs on write to media not read, and you should
know that point.

> recommending for ATA.  If a disk drive were to auto-reallocate a
> sector that it couldn't get valid data from, you'd have serious
> corruptions probelms!!!  Tell me, what data should exist in the sector
> that gets reallocated if it cannot retrieve the data the system
> believes to be there???  If the reallocated sector has random data,
> and the next read to it doesn't return an error, than the system will
> get no indication that it should not be using that data.
> 
> If the unrecoverable error happens durring a write, the disk drive
> still has the data in the buffer, so auto-reallocation on writes (AWRE
> enabled in the mode pages), is usually OK

By the time an ATA device gets to generating this message, either the bad
block list is full or all reallocation sectors are used.  Unlike SCSI
which has to be hand held, 90% of all errors are handle by the device.
Good or Bad -- that is how it does it.

Well there is an additional problem in all of storage, that drives do
reorder and do not always obey the host-driver.  Thus if the device is
suffering from performance and you have disabled WB-Cache, it may elect to
self enable.  Now you have the device returning ack to platter that may
not be true.  Most host-drivers (all of Linux, mine include) release and
dequeue the request once the ack has been presented.  This is dead wrong.
If a flush cache fails I get back the starting lba of the write request,
and if the request is dequeued -- well you know -- bye bye data!  SCSI
will do the same, even with TCQ.  Once the sense is cleared to platter and
the request is dequeued, and a hiccup happens -- bye bye data!

> That said, it'd be my bet that most disk drives still have a window of
> opportunity durring the reallocation operation, where if the drive
> lost power, they'd end up doing bad things.

That is a given.

> You can force a reallocation, but the data you get when you first read
> that unreadable reallocated sector is usually undefined, and often is
> the data pattern written when the drive was low-level formatted.
> 
> That IS what is done, my knowledge is also first hand.

Excellent to see another Storage Industry person here.

> I have no descrepency with your description of how spare sectors are
> dolled out.

Cool.

Question -- are you up to fixing the low-level drivers and all the stuff
above ?

> Steve Brueggeman
> 
> 
> On Mon, 26 Nov 2001 12:36:02 -0800 (PST), you wrote:
> 
> >
> >Steve,
> >
> >Dream on fellow, it is SOP that upon media failure the device logs the
> >failure and does an internal re-allocation in the slip-sector stream.
> >If the media is out of slip-sectors then it does an out-of-bounds
> >re-allocation.  Once the total number of out-of-bounds sectors are gone
> >you need to deal with getting new media or exectute a seek and purge
> >operation; however, if the badblock list is full you are toast.
> >
> >That is what is done - knowledge is first hand.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

