Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316991AbSGIDzS>; Mon, 8 Jul 2002 23:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGIDzR>; Mon, 8 Jul 2002 23:55:17 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:4105 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S316991AbSGIDzQ>;
	Mon, 8 Jul 2002 23:55:16 -0400
Message-ID: <3D2A5F34.F38B893F@torque.net>
Date: Mon, 08 Jul 2002 23:57:40 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

>On Sun, Jul 07, 2002 at 08:19:33PM -0700, Andrew Morton wrote:
> > Question is: what do we want to do with this sucker?  These are the
> > remaining users of kiovecs:
> > 
> >       drivers/md/lvm-snap.c
> >       drivers/media/video/video-buf.c
> >       drivers/mtd/devices/blkmtd.c
> >       drivers/scsi/sg.c
> > 
> > the video and mtd drivers seems to be fairly easy to de-kiobufize.
> > I'm aware of one proprietary driver which uses kiobufs.  XFS uses
> > kiobufs a little bit - just to map the pages.
> 
> It would be nice if we could just map a set of user pages to a scatterlist.

After disabling kiobufs in sg I would like such a drop
in replacement.

> Developers of mass transfer devices (video grabbers, dsp devices, sg and
> many others) would just LOVE you for this ;-)

Agreed. Tape devices could be added to your list.
Large page support will make for very efficient zero
copy IO.

> Block devices are the common case worth optimizing for, but character
> devices just need to reimplement most of this, if they want the same 
> optimizations. Some devices need mass transfers and are NOT blockdevices.

> Please consider supporting them better for 2.5 in stuff similiar to BIOs
> and DMA to/from user pages.

CIOs?

Doug Gilbert
