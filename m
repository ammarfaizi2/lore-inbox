Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbRATXlB>; Sat, 20 Jan 2001 18:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131804AbRATXkv>; Sat, 20 Jan 2001 18:40:51 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13316
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131441AbRATXke>; Sat, 20 Jan 2001 18:40:34 -0500
Date: Sat, 20 Jan 2001 15:40:19 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Minors remaining in Major 10 ??
In-Reply-To: <3A6A1B40.459A1B7@transmeta.com>
Message-ID: <Pine.LNX.4.10.10101201521320.657-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, H. Peter Anvin wrote:

> Andre Hedrick wrote:
> > 
> > On Sat, 20 Jan 2001, H. Peter Anvin wrote:
> > 
> > > Andre Hedrick wrote:
> > > >
> > > > HPA,
> > > >
> > > > Thoughts on granting all block subsystems a general access misc-char minor
> > > > to do special service access that can not be down to a given device if it
> > > > is open.  There are some things you can not do to a device if you are
> > > > using its device-point to gain entry.  Also do the grab a neighboor and
> > > > force the migration to find the desired major/minor is painful.
> > > >
> > >
> > > Hmmm... this would be better done using a dedicated major (and then minor
> > > = block major.)  This is something we can do in 2.5 once we have the
> > > larger dev_t; at this point, I'd be really hesitant to allocate
> > > additional that aren't obligatory.
> > 
> > Er, I did not make the point clear enough, drat.
> > 
> > mknod /dev/ide-service c 10 ???
> > mknod /dev/scsi-service c 10 ???
> > 
> > These would be char devices that would allow one to pass a struct to an
> > ioctl to do device or host services that normally have to attempted by
> > opening the device desired.  This fails if you are trying to unload the
> > driver (with KMOD enabled) so that you could switch devices or change
> > driver types.  Yes this is the migration to a hotswap^H^H^H^H^H^H^H
> > general host/device services calls.
> > 
> 
> No, I think I understood perfectly well.  I said that if it's going to be
> bound to each block device subsystem it would make more sense to
> establish that tie explicitly -- if that isn't possible I'm a bit
> confused.

Okay, I am definitely not clear because I am leading the wrong direction.
A single char-device would access all of ATA or all of SCSI.

Seek by a number of known things by the running kernel to find and select
the needed host/device by a passive method.
	host[I]
	interrupt[J]
	iobases[K]
	lun_index[L]
	memmaps[M]
or
	direct MAJOR|MINOR

The idea is to have a char not a block because there is no buffered access
to the dummy driver.  It is very painful to have to open one block device
and pass parameters to select the one you really want to service in a
passive mode.

However, this looks like a case for another phone call because I am not
able to explain it in email the way it needs to be explained :-((

Somebody please write a book, 'Communication for DUMMIES' please.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
