Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSAUL3L>; Mon, 21 Jan 2002 06:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSAUL3C>; Mon, 21 Jan 2002 06:29:02 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5904 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S284180AbSAUL2o>; Mon, 21 Jan 2002 06:28:44 -0500
Date: Mon, 21 Jan 2002 03:22:20 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Davide Libenzi <davidel@xmailserver.org>, Jens Axboe <axboe@suse.de>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121114311.A24604@suse.cz>
Message-ID: <Pine.LNX.4.10.10201210308460.14375-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Vojtech Pavlik wrote:

> On Sun, Jan 20, 2002 at 04:12:36PM -0800, Andre Hedrick wrote:
> 
> > > > > We only read out 4k thus the device has the the next 4k we may be wanting
> > > > > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > > > > to want to go south, thus [lost interrupt]
> > > >
> > > > Even if the drive is programmed for 16 sectors in multi mode, it still
> > > > must honor lower transfer sizes. The fix I did was not to limit this,
> > > > but rather to only setup transfers for the amount of sectors in the
> > > > first chunk. This is indeed necessary now that we do not have a copy of
> > > > the request to fool around with.
> > 
> > Listen and for just a second okay.
> > 
> > Since the set multimode command is similar to the set transfer rate, if
> > you program the drive to run at U100 but the host can feed only U33 you
> > have problems.  Much of this simple arguement is the same answer for
> > multimode.
> > 
> > Same thing here but a variation, of the operations,
> 
> So you're saying that if you program the drive to multimode 16, you
> can't read a single sector and always have to read 16? That not only
> doesn't make sense to me, but it also contradicts anything that I've
> heard before.

Vojtech,

If the device is programmed for to do 16 sectors in multimode, it and you
issue a read/write multiple pio and short change the device it is not
going to like it.  However if it is programmed for multimode and you issue
single sector pio transfers command opcodes it is fine.

Do we differ?

Regards,



Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

