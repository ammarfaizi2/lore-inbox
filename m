Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSG2XXm>; Mon, 29 Jul 2002 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318129AbSG2XXm>; Mon, 29 Jul 2002 19:23:42 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:62990 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S318128AbSG2XXl>; Mon, 29 Jul 2002 19:23:41 -0400
Message-Id: <200207292326.g6TNQcI19062@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Patrick Mochel <mochel@osdl.org>, Adam Belay <ambx1@netscape.net>
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
Date: Tue, 30 Jul 2002 01:25:22 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Juli 2002 00:21 schrieb Patrick Mochel:

> 1) devfs imposes a default naming policy. That is bad, wrong and unjust.
> There shalt not be a default naming policy in the kernel. Period.

Why not? Who really needs the ability to name anything in /dev ?
You can always use a symlink if you realy, realy want.

[..]
> devfs was already implemented in the wrong way in the first place. Instead
> of requiring modification to every driver, the devfs registration should
> have taken place in the subsystem for which the driver belongs to. In most
> cases (I won't say all), the driver already registers the devices it
> attaches to with _something_. The proper thing to do is not to create a
> parallel API, but one the subsystems can use. The subsystems already know
> most of the information about the device, they should use it.

I am afraid I have to disagree violently here.
A device on this level is a logical thing. It must not matter which subsystem it
is attached to. Furthermore, the subsystem cannot know what the physical
device actually does. That's what a driver does.

<snip comments on code quality>

> With symlinks back to the device's directory in the physical hierarchy
> layout. The user can see what devices of what type they have, and have
> access to their configuration items.
>
> It is that mapping (from logical to physical) that is really useful, not
> the other way around. Users probably aren't going to be poking around
> in the physical layout as much as they will be in the logical layout (but
> we keep all the attributes in one place with symlinks between them).

The problem is that a device without a mapping to a driver is a valid
state. In fact, this is how hotplugging scripts have to work.
 
> So why call include the devfs information at all? The SCSI people have
> been doing something similar for a couple of versions now. They export a
> driverfs file with the kdev_t value in it. Granted, they export it as one
> value, which is bad, but it's only the kdev_t number.

They export a kdev_t ???

	Regards
		Oliver
