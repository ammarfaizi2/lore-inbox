Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318340AbSG3Q31>; Tue, 30 Jul 2002 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318329AbSG3Q31>; Tue, 30 Jul 2002 12:29:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45457 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318337AbSG3Q3Z>;
	Tue, 30 Jul 2002 12:29:25 -0400
Date: Tue, 30 Jul 2002 09:32:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: Adam Belay <ambx1@netscape.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
In-Reply-To: <200207292326.g6TNQcI19062@fachschaft.cup.uni-muenchen.de>
Message-ID: <Pine.LNX.4.44.0207300902280.22697-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 1) devfs imposes a default naming policy. That is bad, wrong and unjust.
> > There shalt not be a default naming policy in the kernel. Period.
> 
> Why not? Who really needs the ability to name anything in /dev ?
> You can always use a symlink if you realy, realy want.

You can use a symlink, but it was an explicit design decision to not go 
that direction. If we create device nodes in the kernel, we're giving 
userspace something to use, even if we really, really want them to use 
symlinks. We're implementing a default naming policy. And, if it is there, 
people will use it. 

We don't want people to use that naming scheme. We don't want people to
rely on the naming scheme. It gives us a little more freedom and room to
move around in the future, should we ever decide that some part of it was
a bad idea. That's not to say that the interface is going to be volatile
forever. But, it will happen that some part of it will suck and need to be
redone.

But, why should the kernel even deal with it? It's a problem that is so 
much better done in userspace. It's configurable, scalable, and easily 
managable. Forcing userspace to have and use this freedom makes things so 
much simpler for both us and them. 

> [..]
> > devfs was already implemented in the wrong way in the first place. Instead
> > of requiring modification to every driver, the devfs registration should
> > have taken place in the subsystem for which the driver belongs to. In most
> > cases (I won't say all), the driver already registers the devices it
> > attaches to with _something_. The proper thing to do is not to create a
> > parallel API, but one the subsystems can use. The subsystems already know
> > most of the information about the device, they should use it.
> 
> I am afraid I have to disagree violently here.
> A device on this level is a logical thing. It must not matter which subsystem it
> is attached to. Furthermore, the subsystem cannot know what the physical
> device actually does. That's what a driver does.

A little clarification about the term subsystem: I use the term to talk
about both class drivers and bus drivers. I don't have an exact definition 
of the word, but I basically consider it to be a collection of programming 
interfaces and components that register with it. 

Ok, it's a shoddy definition. But, in the context, I was talking about the 
class subsystem that the driver registers the device with. Does that help 
at all?

> > With symlinks back to the device's directory in the physical hierarchy
> > layout. The user can see what devices of what type they have, and have
> > access to their configuration items.
> >
> > It is that mapping (from logical to physical) that is really useful, not
> > the other way around. Users probably aren't going to be poking around
> > in the physical layout as much as they will be in the logical layout (but
> > we keep all the attributes in one place with symlinks between them).
> 
> The problem is that a device without a mapping to a driver is a valid
> state. In fact, this is how hotplugging scripts have to work.

Yes, and the idea is to pass the physical device path to /sbin/hotplug 
when the device is inserted, so it can get at the device attributes. 

> > So why call include the devfs information at all? The SCSI people have
> > been doing something similar for a couple of versions now. They export a
> > driverfs file with the kdev_t value in it. Granted, they export it as one
> > value, which is bad, but it's only the kdev_t number.
> 
> They export a kdev_t ???

Yep.

	-pat

