Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSIJQ3t>; Tue, 10 Sep 2002 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSIJQ3t>; Tue, 10 Sep 2002 12:29:49 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:33029 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S317708AbSIJQ3r> convert rfc822-to-8bit; Tue, 10 Sep 2002 12:29:47 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC] Multi-path IO in 2.5/2.6 ?
Date: Tue, 10 Sep 2002 11:34:26 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D03E@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Multi-path IO in 2.5/2.6 ?
Thread-Index: AcJY23LaJOFmBSpqTAS7aIEtC6IeFAACRGLw
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2002 16:34:27.0740 (UTC) FILETIME=[EE3C15C0:01C258E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:

> On Tue, 2002-09-10 at 15:43, Cameron, Steve wrote:
> > Well, the BIOS can do it if it has one working path, right?
> > (I think the md information is at the end of the partition,)
> 
> Yes. A good PC bios will spot an hda boot fail, and try hdc. Good PC
> bioses are alas slightly hard to find nowdays. In that set up raid1
> works very well. Multipath is obviously a lot more complicated.

For the failed primary path case yes.  In the case the primary path is
working, I would think booting from a multipath device and a RAID1 
device would be very very similar, or even identical, from the 
perspective of the BIOS, right?

> > lilo and grub as they stand today, and anaconda (et al) as it 
> > stands today, cannot do it.  They can do RAID1 md devices only.  
> > lilo for example will complain if you try to run it with 
> > boot=/dev/md0, and /dev/md0 is not a RAID1 device.   At least 
> 
> It relies on the BIOS to do the data loading off the md0. In your
> scenario you would tell it the boot is on /dev/sdfoo where that is the
> primary path. I guess the ugly approach would be to add lilo/grub
> entries for booting off either path as two seperate kernel entries.
> 

Hmm, I thought I had tried this, but, I had tried so many things.
If anyone has successfully set up a system booting from a multipath
md device, I'd like to hear about it.

What I tried was more or less this:

1. Install normally to disk-A, remove disk-A from the system.
2. Install normally to disk-B.  Install disk-A into the system.
   and boot from disk-B.  (now I can safely copy from disk-A, which has
   no actively mounted partitions.)
3.  Create multipath devices on disk-C, one for each partition.
   The partitions are bigger than those on disk-A, to allow for md to
	put its data at the end.
4.  Copy, (using dd) the partitions from disk-A to the md devices.

5.  mount the md devices, and chroot to the md-root device.
    Try to figure out how to run lilo to make booting from disk-C possible
    also, initrd modifications to insmod multipath.o, mount the md devices,
    etc.  This part, (making lilo work) I never was able to figure out.

  Would boot up and say "LI" then stop... or various other problems
  that I can't quite recall now.  (this was a couple weeks ago)

I guess this is getting a little off topic for linux-kernel, so maybe I 
should let this drop now, or take it over to linux-raid, but I _would_ 
like to hear from anyone who has got a multipath boot device working.

Anyway, even if this can be made to work, this leaves a rather ugly and
convoluted method of installation.

> > bit, but so far, I am unsuccessful.  I think grub cannot even do
> > RAID1.
> 
> Works for me

Ok, good to hear.  (I had it only on hearsay that grub couldn't do it,
so my experiments were confined to lilo.)

-- steve

 
