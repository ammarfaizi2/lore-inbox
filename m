Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270508AbTGNDGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270510AbTGNDGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:06:47 -0400
Received: from remt25.cluster1.charter.net ([209.225.8.35]:21235 "EHLO
	remt25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S270508AbTGNDGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:06:40 -0400
From: Chris Morgan <cmorgan@alum.wpi.edu>
To: Doug McNaught <doug@mcnaught.org>
Subject: Re: 2.5.XX very sluggish
Date: Sun, 13 Jul 2003 23:21:26 -0400
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307131228.00155.cmorgan@alum.wpi.edu> <m38yr2e5pv.fsf@varsoon.wireboard.com>
In-Reply-To: <m38yr2e5pv.fsf@varsoon.wireboard.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307132321.26835.cmorgan@alum.wpi.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.4.21:

For my boot drive, ide:

/dev/hdc2:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2100/255/63, sectors = 32740470, start = 996030

For the scsi drives(2 drives in a raid 1 setup):
/dev/sda:
 readonly     =  0 (off)
 geometry     = 17885/255/63, sectors = 287332384, start = 0

And some performance numbers, maybe these are helpful:

/dev/md1:
 Timing buffer-cache reads:   128 MB in  0.60 seconds =213.33 MB/sec
 Timing buffered disk reads:  64 MB in  2.22 seconds = 28.83 MB/sec

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.56 seconds =228.57 MB/sec
 Timing buffered disk reads:  64 MB in  4.33 seconds = 14.78 MB/sec



Under 2.5.75:

/dev/hdc:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 33483/16/63, sectors = 33750864, start = 0

These are with X running:

/dev/hdc:
 Timing buffer-cache reads:   128 MB in 30.58 seconds =  4.19 MB/sec
 Timing buffered disk reads:  64 MB in 20.98 seconds =  3.05 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.

/dev/md1:
 Timing buffer-cache reads:   128 MB in 108.76 seconds =  1.18 MB/sec
 Timing buffered disk reads:  64 MB in 44.86 seconds =  1.43 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.

With X shutdown:
/dev/hdc:
 Timing buffer-cache reads:   128 MB in 11.26 seconds = 11.36 MB/sec
 Timing buffered disk reads:  64 MB in  6.88 seconds =  9.30 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.

/dev/md1:
 Timing buffer-cache reads:   128 MB in 11.88 seconds = 10.77 MB/sec
 Timing buffered disk reads:  64 MB in  7.74 seconds =  8.27 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.

I'm running xf4.2.1 and the 'nv' driver.

Any ideas as to what else I can look at?

Thanks,
Chris


On Sunday 13 July 2003 12:45 pm, Doug McNaught wrote:
> Chris Morgan <cmorgan@alum.wpi.edu> writes:
> > 1.4Ghz Athlon via 82cxx chipset, software raid 1 scsi drives, currently
> > running 2.4.21
> >
> > With 2.5.73/74/75(the only ones I've tried thus far) the kernel boots
> > fine until it tries to mount the reiserfs partition on the raid1 set. 
> > Replaying the journal takes many times longer than with 2.4.  Once it
> > gets past that point the whole machine appears to be quite sluggish.  Is
> > this a known issue with reiserfs + software raid 1?  What information
> > would be useful to aid in debugging?
>
> What does 'hdparm' say about DMA settings on your drive under 2.5?
>
> -Doug

