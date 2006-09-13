Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWIMLd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWIMLd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 07:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIMLd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 07:33:57 -0400
Received: from [212.33.161.65] ([212.33.161.65]:24960 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750805AbWIMLd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 07:33:57 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: What's in linux-2.6-block.git
Date: Wed, 13 Sep 2006 14:35:31 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200609131359.04972.a1426z@gawab.com> <20060913105932.GA4792@kernel.dk>
In-Reply-To: <20060913105932.GA4792@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609131435.31390.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Sep 13 2006, Al Boldi wrote:
> > Jens Axboe  wrote:
> > > This lists the main features of the 'block' branch, which is bound for
> > > Linus when 2.6.19 opens:
> > >
> > > - Splitting of request->flags into two parts:
> > >         - cmd type
> > >         - modified flags
> > >   Right now it's a bit of a mess, splitting this up invites a cleaner
> > >   usage and also enables us to implement generic "messages" passed on
> > >   the regular queue for the device.
> > >
> > > - Abstract out the request back merging and put it into the core io
> > >   scheduler layer. Cleans up all the io schedulers, and noop gets
> > >   merging for "free".
> > >
> > > - Abstract out the rbtree sorting. Gets rid of duplicated code in
> > >   as/cfq/deadline.
> > >
> > > - General shrinkage of the request structure.
> > >
> > > - Killing dynamic rq private structures in deadline/as/cfq. This
> > > should speed up the io path somewhat, as we avoid allocating several
> > > structures (struct request + scheduler private request) for each io
> > > request.
> > >
> > > - meta data io logging for blktrace.
> > >
> > > - CFQ improvements.
> > >
> > > - Make the block layer configurable through Kconfig (David Howells).
> > >
> > > - Lots of cleanups.
> >
> > Does it also address the strange "max_sectors_kb<>192 causes a
> > 50%-slowdown" problem?
>
> (remember to cc me/others when replying, I can easily miss lkml
> messages for several days otherwise).
>
> It does not, the investigation of that is still pending I'm afraid. The
> data is really puzzling, I'm inclined to think it's drive related. Are
> you reproducing it just one box/drive, or on several?

Several boxes, same drive.

/dev/hda:

ATA device, with non-removable media
	Model Number:       WDC WD1200JB-00DUA0                     
	Serial Number:      WD-WMACM1007651
	Firmware Revision:  65.13G65
Standards:
	Supported: 6 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  234441648
	LBA48  user addressable sectors:  234441648
	device size with M = 1024*1024:      114473 MBytes
	device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 98	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct


Thanks!

--
Al

