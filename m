Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRBFSXH>; Tue, 6 Feb 2001 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129833AbRBFSW6>; Tue, 6 Feb 2001 13:22:58 -0500
Received: from hermes.mixx.net ([212.84.196.2]:42002 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129942AbRBFSWt>;
	Tue, 6 Feb 2001 13:22:49 -0500
Message-ID: <3A80408C.E854B37A@innominate.de>
Date: Tue, 06 Feb 2001 19:21:00 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o
In-Reply-To: <200102061424.PAA32284@hell.wii.ericsson.net> <E14Q9U2-0005gX-00@the-village.bc.nu> <20010206173437.A19836@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Tue, Feb 06, 2001 at 02:52:40PM +0000, Alan Cox wrote:
> > > According to the man page for fsync it copies in-core data to disk
> > > prior to its return. Does that take async i/o to the media in account?
> > > I.e. does it wait for completion of the async i/o to the disk?
> >
> > Undefined.
> 
> > In practice some IDE disks do write merging and small amounts of write
> > caching in the drive firmware so you cannot trust it 100%.
> 
> It's worth noting that it *is* defined unambiguously in the standards:
> fsync waits until all the data is hard on disk.  Linux will obey that
> if it possibly can: only in cases where the hardware is actively lying
> about when the data has hit disk will the guarantee break down.

Sometimes I want to know that the write is safely on disk and sometimes
I only need to know that the io has gone over the bus and is on its way
to disk.  In the latter case the buffer/page can be unlocked a lot
sooner.  Please correct me if I'm wrong, but I don't think the current
API can make that distinction for IDE, much less provide a uniform way
of controlling this behaviour across all types of block devices.  We
need that, or else we have to choose between the following: 1) slow 2)
risky.

I'd like to be able to set a bit in the buffer_head that says 'get back
to me when it's on disk' vs 'get back to me when it's hit the bus'.
	
--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
