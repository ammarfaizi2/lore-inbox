Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWGNRR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWGNRR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWGNRR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:17:58 -0400
Received: from lucidpixels.com ([66.45.37.187]:52916 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1422646AbWGNRR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:17:56 -0400
Date: Fri, 14 Jul 2006 13:17:55 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Mark Lord <liml@rtr.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: Follow up? LibPATA code issues / 2.6.15.4 (found the opcode=0x35)!
In-Reply-To: <44B7D0F7.6000302@rtr.ca>
Message-ID: <Pine.LNX.4.64.0607141317300.1687@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>
  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>
  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan> 
 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan> 
 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>
 <1152545639.27368.137.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan> <44B7D0F7.6000302@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Mark Lord wrote:

>> Jeff/Mark, from these errors can we reach a consensus as to the cause
>> of these errors and how to eliminate the problem? 
>
> It is up to the current subsystem maintainer to help investigate this
> and come up with a solution, in cooperation with eager testers such
> as yourself.  I gave away my kernel subsystem maintainer's duties about
> seven years ago, because it just takes too much time to do it really well.
>
> In this case, I'm proving a tiny amount of help, simply because I don't
> see anyone else even trying, and there is obviously something wrong here.
>
> Now.. your hacked version of my simple patch is incorrect.  It is frequently
> dumping out ata_op=0x51, which is obviously the ATA status value not the
> original ATA command byte.
>
> But ignoring that, we also see some valid output from where it does trip
> the code from my original patches:  ata_op=0x35.
>
> So, the drive is rejecting an LBA48 WRITE operation, which should happen
> only if the drive does not have LBA48 support.  Now, I know you posted all
> of this nice info months ago, but let's see it again now, for the exact
> drive that is generating that specific message.  We need to see the output
> from "hdparm --Istdout /dev/sdX" for that drive.
>
> Thanks
>

Here it is:

They are identical disks (the WD 400KD), both show up as 373GB 
(formatted):

p34:~# hdparm --Istdout /dev/sdc

/dev/sdc:
  IO_support   =  0 (default 16-bit)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 48641/255/63, sectors = 781422768, start = 0
0c5a 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 2020 2020
334e 4631 514a 3345 0000 8000 0004 332e
4141 4820 2020 5354 3334 3030 3633 3341
5320 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0010 ffff 0fff 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 001f 0502 0000 0040 0040
00fe 0000 346b 7d01 4023 3469 3c01 4023
407f 0000 0000 fefe fffe 0000 fe00 0000
0000 0000 0000 0000 90b0 2e93 0000 0000
0000 0000 4000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0100 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 90b0 2e93 90b0 2e93 2020 0002 02b6
0002 008a 3c06 3c0a 0000 07c6 0100 0800
100f 3000 0002 0080 0000 0000 00a0 0202
0000 0404 0000 0000 0000 0000 1000 000b
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 9da5
p34:~# hdparm --Istdout /dev/sdd

/dev/sdd:
  IO_support   =  0 (default 16-bit)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 48641/255/63, sectors = 781422768, start = 0
427a 3fff c837 0010 e100 0258 003f 0000
0000 000e 2020 2020 2057 442d 574d 414d
5931 3131 3335 3636 0003 8000 003f 3031
2e30 3641 3031 5744 4320 5744 3430 3030
4b44 2d30 304e 4142 3020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4001 0280 0000 0007 3fff 0010
003f fc10 00fb 0100 ffff 0fff 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 001f 0702 0000 0044 0040
00fe 001d 746b 7f01 4023 7469 3c01 4023
207f 0000 0000 0000 0000 0000 80fe 0000
0000 0000 0000 0000 90b0 2e93 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0141 0000 0000 0000 075a 0000 0000
0000 0000 0000 0000 0000 0000 0002 0001
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0087
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 103f 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 48a5
p34:~#

