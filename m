Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSAULdm>; Mon, 21 Jan 2002 06:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284717AbSAULdc>; Mon, 21 Jan 2002 06:33:32 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:27919 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S284300AbSAULd3>; Mon, 21 Jan 2002 06:33:29 -0500
Date: Mon, 21 Jan 2002 12:32:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Jens Axboe <axboe@suse.de>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121123243.A24754@suse.cz>
In-Reply-To: <20020121114311.A24604@suse.cz> <Pine.LNX.4.10.10201210308460.14375-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201210308460.14375-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Mon, Jan 21, 2002 at 03:22:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 03:22:20AM -0800, Andre Hedrick wrote:
> On Mon, 21 Jan 2002, Vojtech Pavlik wrote:
> 
> > On Sun, Jan 20, 2002 at 04:12:36PM -0800, Andre Hedrick wrote:
> > 
> > > > > > We only read out 4k thus the device has the the next 4k we may be wanting
> > > > > > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > > > > > to want to go south, thus [lost interrupt]
> > > > >
> > > > > Even if the drive is programmed for 16 sectors in multi mode, it still
> > > > > must honor lower transfer sizes. The fix I did was not to limit this,
> > > > > but rather to only setup transfers for the amount of sectors in the
> > > > > first chunk. This is indeed necessary now that we do not have a copy of
> > > > > the request to fool around with.
> > > 
> > > Listen and for just a second okay.
> > > 
> > > Since the set multimode command is similar to the set transfer rate, if
> > > you program the drive to run at U100 but the host can feed only U33 you
> > > have problems.  Much of this simple arguement is the same answer for
> > > multimode.
> > > 
> > > Same thing here but a variation, of the operations,
> > 
> > So you're saying that if you program the drive to multimode 16, you
> > can't read a single sector and always have to read 16? That not only
> > doesn't make sense to me, but it also contradicts anything that I've
> > heard before.
> 
> Vojtech,
> 
> If the device is programmed for to do 16 sectors in multimode, it and you
> issue a read/write multiple pio and short change the device it is not
> going to like it.  However if it is programmed for multimode and you issue
> single sector pio transfers command opcodes it is fine.
> 
> Do we differ?

I think so. Check my mail from 11:14:56 GMT today. I fully understand
that if I supply less data to the device than it expects or get less
from it than it has, it'll be a problem. But I think the specification
doesn't prohibit reading amounts not divisible by multimode setting via
the multimode command. I've read it quite carefully again.

-- 
Vojtech Pavlik
SuSE Labs
