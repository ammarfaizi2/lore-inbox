Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319141AbSIJOik>; Tue, 10 Sep 2002 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319144AbSIJOik>; Tue, 10 Sep 2002 10:38:40 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:6670 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S319141AbSIJOij> convert rfc822-to-8bit; Tue, 10 Sep 2002 10:38:39 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC] Multi-path IO in 2.5/2.6 ?
Date: Tue, 10 Sep 2002 09:43:20 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D03B@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Multi-path IO in 2.5/2.6 ?
Thread-Index: AcJY1cJ4rAGXqKXUTL2KjxJDl1VVPQAABDPw
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2002 14:43:20.0578 (UTC) FILETIME=[684BE620:01C258D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-09-10 at 15:06, Cameron, Steve wrote:
> > We can use the md driver for this.  However, we cannot boot from
> > such a multipath device.  Lilo and grub do not understand md multipath
> > devices, nor do anaconda or other installers.  (Enhancing all of those,
> > I'd like to avoid.  Cramming multipath i/o into the low level driver
> > would accomplish that, but, too yucky.) 
> > 
> > If there is work going on to enhance the multipath support in linux
> > it would be nice if you could boot from and install to such devices.
> 
> Booting from them is a BIOS matter. If the BIOS can do the block loads
> off the multipath device we can do the rest. The probe stuff 
> can be done
> in the boot initrd - as some vendors handle raid for example.

Well, the BIOS can do it if it has one working path, right?
(I think the md information is at the end of the partition,)
Maybe it will have some trouble if the primary path is failed,
but ignoring that for now.  In the normal case, the bios shouldn't
even have to know it's a multipath device, right?

lilo and grub as they stand today, and anaconda (et al) as it 
stands today, cannot do it.  They can do RAID1 md devices only.  
lilo for example will complain if you try to run it with 
boot=/dev/md0, and /dev/md0 is not a RAID1 device.   At least 
it did when I tried it.  When I looked at the lilo source, it
goes through each disk in the raid device and puts the boot 
code on each one, a la RAID1.  No provision is made for any other
kind of raid.  Raid 5, naturally is much harder, and is unlikely
to have BIOS support, so this is understandable.  Multipath seems
much closer to raid1 in terms of what's necessary for booting,
that is, much much easier than raid 5.  I tried hacking on lilo a
bit, but so far, I am unsuccessful.  I think grub cannot even do
RAID1.

I agree in principle, the initrd scripts can insmod multipath.o
to get things rolling, etc.  The trouble comes from lilo, grub 
and install time configuration.

-- steve


