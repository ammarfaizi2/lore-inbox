Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288484AbSBDFT3>; Mon, 4 Feb 2002 00:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288498AbSBDFTU>; Mon, 4 Feb 2002 00:19:20 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:14979 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S288484AbSBDFTN>;
	Mon, 4 Feb 2002 00:19:13 -0500
Date: Mon, 4 Feb 2002 00:19:13 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <a3l4uc$laf$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0202040014180.1272-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


n 3 Feb 2002, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
> By author:    "Calin A. Culianu" <calin@ajvar.org>
> In newsgroup: linux.dev.kernel
> >
> >
> > Is there any way, other than by polling, to have a user process be
> > notified of a change in status on a cdrom drive?  (Such as if the drive
> > opens, closes, gets new media, etc)?
> >
> > Also, come think of it, other types of asynchronous events would be nice
> > too, like when a cdrom usb device gets hot-plugged into the system, etc.
> >
> > The current ioctls are inadequate for this type of thing (they are
> > synchronous in nature). One nice thing would be if we can register SIGUSR
> > or other types of signals with the cdrom driver(s) so that it can notify a
> > user process of (cdrom) events it may be interested in.
> >
> > The reason I ask this is that the current autorun program that comes with
> > kde is very inefficient because it polls the cdrom drives.  Also, this
> > program is completely unable to determine that a usb device has come
> > online, because it basically can't differentiate between bogus /etc/fstab
> > entries and offline usb devices.
> >
> > At any rate, if anyone can suggest a way to asynchronously receive cdrom
> > events in userland, it would be appreciated.
> >
> > If not what do you guys think about extensions to the cdrom drivers to
> > handle these types of things?
> >
>
> Rather than a signal, it should be a file descriptor of some sort, so
> one can select() etc on it.  Personally I can't imagine polling would
> take any appreciable amount of resources, though.

Yes, select()ing on it would be more useful, but I don't know if this
would clash with existing semantics, because currently select() on a set
of readfds that are cdrom drives always returns right away (I am not sure
why this would be, as if you open /dev/cdrom with O_NONBLOCK|O_RDONLY
you are supposed to be doing ioctls and no actual reading, no?).

Maybe such events can be in the exception fds?

-Calin

>
> A more important issue is probably to get notification when the eject
> button is pushed and the device is locked, so that it can try to
> umount and eject it, unless busy.
>
> 	-hpa
>
>
>

