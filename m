Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUI0Pu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUI0Pu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUI0Pu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:50:28 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:1704 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266505AbUI0PuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:50:25 -0400
Message-ID: <70fda32040927085019a5cd91@mail.gmail.com>
Date: Mon, 27 Sep 2004 10:50:23 -0500
From: micah milano <micaho@gmail.com>
Reply-To: micah milano <micaho@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: SiI3112 Serial ATA Maxtor 6Y120M0 incorrect geometry detected
Cc: Andries Brouwer <andries.brouwer@cwi.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e04092603596138133a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <70fda320409251214129bba57@mail.gmail.com>
	 <70fda3204092514037c6dc039@mail.gmail.com>
	 <58cb370e04092515157e9b72ef@mail.gmail.com>
	 <20040926102937.GA27269@apps.cwi.nl>
	 <58cb370e04092603596138133a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that parted reports an error, however I think there is
something else going on. When I run fdisk there is a different CHS
reported for each disk, even though they are the same geometry. I
can't partition the second disk to have the same partition sizes as
the other disk because of this. I only mentioned parted because I was
trying every partitioner there is.

I am glad to hear I am helping tighten up some code to make things
clearer, but I was hoping someone might have a solution for how I can
partition this second identical disk so it has identical partition
sizing as the first so I can put software RAID mirroring on them. From
what it sounds like you guys are saying (IANALKH) dmesg is reporting
the wrong CHS, and parted has a fix for its error, but is there
something I can do to get the partition sizing right?

thanks for the quick replies!
micah


On Sun, 26 Sep 2004 12:59:48 +0200, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Sun, 26 Sep 2004 12:29:37 +0200, Andries Brouwer
> <andries.brouwer@cwi.nl > wrote:
> > On Sun, Sep 26, 2004 at 12:15:33AM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > > I'm tired of this issue and this is what I'm going to do:
> > > - remove CHS info from IDE printks and /proc/ide/
> > > - add BLKGETSTART ioctl for getting partition's start sector
> > >   (this is the only legitimate use of HDIO_GETGEO currently)
> > > - at least obsolete HDIO_GETGEO in IDE or even remove it (failing is
> > >   better than returning unexpected results)
> > > - silence complainers :)
> > >
> > > Bartlomiej
> >
> > Yes. Consider returning 0 for C/H/S in HDIO_GETGEO.
> >
> > We need the BLKGETSTART ioctl for another reason:
> > the field start of a struct hd_geometry has 32 bits
> > and fails for partitions starting past the 2TB mark.
> > So, just like BLKGETSIZE64, this BLKGETSTART must
> > return a u64 and return an offset in bytes.
> 
> Yes, I though so. Also u64 is 64-bit safe.
> 
> > As we all know, geometry is meaningless for IDE.
> > But it is not for MFM/RLL and similar ancient stuff.
> > If support for old disks is not broken yet, try not to break it.
> 
> OK.
>
