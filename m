Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVAXRWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVAXRWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVAXRWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:22:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11653 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261490AbVAXRVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:21:33 -0500
Date: Mon, 24 Jan 2005 18:21:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       linux-kernel@vger.kernel.org
Subject: Re: DVD burning still have problems
Message-ID: <20050124172112.GM2707@suse.de>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de> <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de> <5a4c581d05012408481adbd5f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d05012408481adbd5f4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2005, Alessandro Suardi wrote:
> On Mon, 24 Jan 2005 16:07:55 +0100, Jens Axboe <axboe@suse.de> wrote:
> > On Sun, Jan 23 2005, Alessandro Suardi wrote:
> > > On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
> > > <volker.armin.hemmann@tu-clausthal.de> wrote:
> > > > Hi,
> > > >
> > > > have you checked, that cdrecord is not suid root, and growisofs/dvd+rw-tools
> > > > is?
> > > >
> > > > I had some probs, solved with a simple chmod +s growisofs :)
> > >
> > > Lucky you. Burning as root here, cdrecord not suid. Tried also
> > >  burning with a +s growisofs, but...
> > >
> > >  794034176/4572807168 (17.4%) @2.4x, remaining 18:47
> > >  805339136/4572807168 (17.6%) @2.4x, remaining 18:42
> > > :-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
> > > builtin_dd: 396976*2KB out @ average 2.4x1385KBps
> > > :-( write failed: Input/output error
> > 
> > As with the original report, the drive is sending back a write error to
> > the issuer. Looks like bad media.
> 
> I'm definitely unconvinced about the possibility of bad media...

The error is quite clear, sense 0x03/0x0c/0x00 is write error with no
additional specification of what kind. It's 100% certainly a drive
generated error, and I don't see any way that software is involved
there. Sense key 0x03 is a medium error.

> Retrying the burn process works, sometimes on first attempt,
>  sometimes after tray reload, and all checksums from original
>  files to the burned files are just okay. This happens with different
>  discs from different brands.

Could be dirty drive, perhaps it needs cleaning?

> So far I had *one* bad disc - that would keep the light on my
>  DVD burner blinking forever until I hit the eject button, and
>  made my laptop (2.6.11-rc2-bk1) DVD player barf:
> 
> Jan 24 03:02:13 incident kernel: ATAPI device hdc:
> Jan 24 03:02:13 incident kernel:   Error: Not ready -- (Sense key=0x02)
> Jan 24 03:02:13 incident kernel:   No reference position found (media
> may be upside down) -- (asc=0x06, ascq=0x00)
> Jan 24 03:02:13 incident kernel:   The failed "Read Cd/Dvd Capacity"
> packet command was:
> Jan 24 03:02:13 incident kernel:   "25 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 "

Could also be a focus problem.

-- 
Jens Axboe

