Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQKFR4q>; Mon, 6 Nov 2000 12:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129049AbQKFR4g>; Mon, 6 Nov 2000 12:56:36 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:14746 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129042AbQKFR42>; Mon, 6 Nov 2000 12:56:28 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 17:53:16 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <00110617370400.24534@dax.joh.cam.ac.uk> <6786.973530532@redhat.com> <10507.973532648@redhat.com>
In-Reply-To: <10507.973532648@redhat.com>
MIME-Version: 1.0
Message-Id: <00110617560604.24534@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, David Woodhouse wrote:
> jas88@cam.ac.uk said:
> >  Except this isn't possible with the hardware in question! If it were,
> > there would be no problem. In cases where the hardware doesn't support
> > the functionality userspace "needs", why put the kludge in the kernel?
> 
> > If userspace wants to know what settings it set last time, it should
> > store those values somewhere.
> 
> No. You have to reset the hardware fully each time you load the module. 
> Although you _expect_ it to be in the state in which you left it, you can't 
> be sure of that. 

If a reset is needed, I think it should come explicitly from userspace.

> jas88@cam.ac.uk said:
> > Eh? You just load the driver once, probably on boot, to configure sane
> > values. This time round, you use an argument (or an ioctl or whatever)
> > to specify the values you want. (cat /etc/sysconfig/sound/
> > defaultvolume > /dev/sound/mixer or whatever). After that, the module
> > can be unloaded and loaded as needed, without any need to touch the
> > mixer settings except in response to *explicit* "set volume" commands
> > from userspace. 
> 
> Agreed. Where 'whatever' == persistent storage of some form. I care not 
> what form that takes. If you can store the data entirely in userspace and 
> still have them present at the time the driver initialises the hardware, 
> that's fine. 

That's what I've been getting at all along...

Probably have a simple load and unload script, which dumps state to a file
on unload, and restores it on load. Whenever the module's state is not saved,
the refcount is >0, so you can't unload it without saving state.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
