Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbSBDSsa>; Mon, 4 Feb 2002 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBDSsV>; Mon, 4 Feb 2002 13:48:21 -0500
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:40462 "EHLO
	leng.internal") by vger.kernel.org with ESMTP id <S282902AbSBDSsJ>;
	Mon, 4 Feb 2002 13:48:09 -0500
Message-ID: <0d4d01c1adad$37bf5cc0$7e93a8c0@sac.unify.com>
From: "Manuel McLure" <manuel@mclure.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Andre Hedrick" <andre@linuxdiskcert.org>
In-Reply-To: <20020202170244.A12338@ulthar.internal> <Pine.LNX.4.10.10202021715180.26613-100000@master.linux-ide.org> <20020203102109.C12338@ulthar.internal> <20020203103216.E12338@ulthar.internal>
Subject: Re: 2.4.17 Oops when trying to mount ATAPI CDROM
Date: Mon, 4 Feb 2002 10:53:21 -0800
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



----- Original Message -----
From: "Manuel McLure" <manuel@mclure.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Andre Hedrick" <andre@linuxdiskcert.org>
Sent: Sunday, February 03, 2002 10:32 AM
Subject: Re: 2.4.17 Oops when trying to mount ATAPI CDROM


>
> On 2002.02.03 10:21 Manuel McLure wrote:
> >
> > On 2002.02.02 22:04 Andre Hedrick wrote:
> > >
> > > Manuel,
> > >
> > > Would you be kind enough to be a little more specific on the hardware?
> > > The attached devices bu make model and real vender if known.
> > kml/
> >
> > The CD-ROM is detected as a Pioneer CD-ROM ATAPI Model DR-A24X 0104 - I
> > haven't opened the case to look at it but I do recall that it is
> > definitely a 24X Pioneer ATAPI CDROM.
> >
>
> Some more information - if I boot without "hdc=noprobe hdc=cdrom", I don't
> get the oops whel loading the "ide-cd" module - instead I get
>
> hdc: set_drive_speed_status: status=0x00 { }
> hdc: lost interrupt
> hdc: ATAPI 20X CD-ROM drive, 128kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt
>
> The module eventually finishes initializing but is not usable due to the
> "lost interrupt"s.

After checking through the code, I can't see any way that "noprobe" with an
existing device would ever work on 2.4. Unless I'm missing something the
only place where "drive->id" is allocated is in do_probe() which isn't
called for a device with "noprobe" set, yet all the config_drive_xfer_rate()
functions will oops if "drive->id" is NULL.

Is "noprobe" on an existing device no longer supported in 2.4?
--
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft



