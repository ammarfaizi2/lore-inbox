Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRATXGi>; Sat, 20 Jan 2001 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbRATXG3>; Sat, 20 Jan 2001 18:06:29 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:10244
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130485AbRATXGU>; Sat, 20 Jan 2001 18:06:20 -0500
Date: Sat, 20 Jan 2001 15:06:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Minors remaining in Major 10 ??
In-Reply-To: <3A6A0DA3.FF1EB559@transmeta.com>
Message-ID: <Pine.LNX.4.10.10101201501290.657-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, H. Peter Anvin wrote:

> Andre Hedrick wrote:
> > 
> > HPA,
> > 
> > Thoughts on granting all block subsystems a general access misc-char minor
> > to do special service access that can not be down to a given device if it
> > is open.  There are some things you can not do to a device if you are
> > using its device-point to gain entry.  Also do the grab a neighboor and
> > force the migration to find the desired major/minor is painful.
> > 
> 
> Hmmm... this would be better done using a dedicated major (and then minor
> = block major.)  This is something we can do in 2.5 once we have the
> larger dev_t; at this point, I'd be really hesitant to allocate
> additional that aren't obligatory.

Er, I did not make the point clear enough, drat.

mknod /dev/ide-service c 10 ???
mknod /dev/scsi-service c 10 ???

These would be char devices that would allow one to pass a struct to an
ioctl to do device or host services that normally have to attempted by
opening the device desired.  This fails if you are trying to unload the
driver (with KMOD enabled) so that you could switch devices or change
driver types.  Yes this is the migration to a hotswap^H^H^H^H^H^H^H
general host/device services calls.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
