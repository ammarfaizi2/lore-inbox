Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316395AbSEOPKn>; Wed, 15 May 2002 11:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316396AbSEOPKm>; Wed, 15 May 2002 11:10:42 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:36320 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S316395AbSEOPKm>;
	Wed, 15 May 2002 11:10:42 -0400
Date: Wed, 15 May 2002 16:10:39 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Justin Cormack <kernel@street-vision.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <200205151454.g4FEsh419684@street-vision.com>
Message-ID: <Pine.LNX.4.33.0205151601230.2611-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Justin Cormack wrote:

> >
> > On Wed, 15 May 2002, Dead2 wrote:
> > > So, I now have a new problem I hope someone can help me out with.
> > > It now mounts the cdrom as root like it should, but then gives me the error:
> > > "Warning: unable to open an initial console."
> > >
> > > I have checked everything I can think of, but if someone could point me to
> > > exactly generates this error, I would be forever grateful.
> >
> > Yes, that is well-known.
> >
> > Unix root filesystem cannot be readonly in its entirety. Linux is much
> > better, but even Linux is not perfect.
> >
> > So, what I do is --- I prepare the /var, /home, /etc, /dev in a tar.gz
> > file and place it on CD. Then, from rc.sysinit I mount tmpfs on those
> > points and unpack the tar.gz from / --- thus ending up with readwrite /var
> > /home /etc and /dev. (you could avoid /dev issue by using devfs but then
> > you will have other little problems to deal with :)
>
> no this is not true. I use busybox plus devfs and it works perfecly read
> only. Or you can run the entire system out of an initrd which you can
> of course write to if you want to write (it makes some things a little
> easier). You can always mount /tmp with tmpfs if you want some write space.
>
> Unable to open an initial console sounds to me like dev is not populated.
> Have you got /dev/console and /dev/tty0? I do recommend devfs for this
> type of thing, as it makes scripting your initial installer easier (you
> can loop over /dev/hd* and so on).

if he is scripting a (limited) initial installer then that is fine. What I
was talking about is a complete system which is flexible enough to be run
either from the CD or from HD. So, I don't say the word "installation", I
say "replicating itself onto a stable (and writeable) media, e.g. hard
disk". And the "system configuration" is not a "passive" one (i.e. you
just store info to be applied to the installed system) but an "active" one
(i.e. you immediately configure the running instance and then, possibly
(if desired) replicate that configuration onto the installed system).

And for such system, my statement is correct, i.e. you do need writeable
/var (for daemons to do logging etc), writeable /home (for multiple users
to compile their programs in there), writeable /dev for gettys etc.

I don't know what a "busybox" is, another recent invention?

Regards
Tigran

--------
The progress is a stupid being, because it is always going forward instead
of stopping for a little while to think and to contemplate its own existence.

