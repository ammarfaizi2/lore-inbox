Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289335AbSA1TWD>; Mon, 28 Jan 2002 14:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289336AbSA1TVx>; Mon, 28 Jan 2002 14:21:53 -0500
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:40890 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S289335AbSA1TVr>; Mon, 28 Jan 2002 14:21:47 -0500
Message-ID: <000501c1a831$05e80480$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Andrew Morton" <akpm@zip.com.au>, "lkml" <linux-kernel@vger.kernel.org>,
        "Grant" <gcoady@bendigo.net.au>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au> <000701c1a5d5$812ef580$6caaa8c0@kevin> <3C53711B.F8D89811@zip.com.au> <3C53A116.81432588@zip.com.au>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Date: Mon, 28 Jan 2002 12:21:44 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works very well on my system; I'm now able to rip audio from both drives
in DMA mode (one in UDMA-2, the other in MDMA-2) simultaneously. Even though
they are on the same IDE cable, rip performance increased slightly (average
of 12x per drive, instead of 11x), and CPU usage dropped drastically (less
then 10% usage, even with the WAV files going onto a software RAID-5 array
with ext3 filesystem).

Great job Andrew!

----- Original Message -----
From: "Andrew Morton" <akpm@zip.com.au>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>; "lkml"
<linux-kernel@vger.kernel.org>; "Grant" <gcoady@bendigo.net.au>
Sent: Saturday, January 26, 2002 11:41 PM
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio


> Andrew Morton wrote:
> >
> > "Kevin P. Fleming" wrote:
> > >
> > > When reading from the N drive, get lots of "cdrom_pc_intr: read too
> > > little data 0 < 2352",
> >
> > OK, thanks Kevin (Dan, Kristian, Grant..)
> >
> > Seems that some devices simply terminate their DMA in a normal
> > manner, report no errors and don't tell us how much data they
> > transferred.  From my reading of the ATA spec, they're allowed
> > to do that - they only need to report the transfer byte count
> > in PIO mode.
> >
>
> There's an updated patch at
>
> http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/ide-akpm.patch
>
> It now supports multi-frame transfers and should fix the problem
> which you observed.
>
> -
>
>
>

