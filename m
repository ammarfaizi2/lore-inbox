Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262419AbSJHNMt>; Tue, 8 Oct 2002 09:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262435AbSJHNMt>; Tue, 8 Oct 2002 09:12:49 -0400
Received: from 62-190-201-48.pdu.pipex.net ([62.190.201.48]:10244 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262419AbSJHNMr>; Tue, 8 Oct 2002 09:12:47 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210081325.g98DP6MY000340@darkstar.example.net>
Subject: Re: [patch] IDE driver model update
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 8 Oct 2002 14:25:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, mochel@osdl.org, torvalds@transmeta.com,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu> from "Alexander Viro" at Oct 08, 2002 08:24:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > _ALL_ buses that have driverfs support (IDE, SCSI, USB, PCI) have their
> > > own rules for lifetimes of their structures.  And that's not likely to
> > > change - these objects belong to drivers and in some cases (IDE) are
> > > not even allocated dynamically - they are reused if nothing is holding
> > > them.
> > 
> > IDE objects can also outlast the hardware - consider an active mount on
> > an ejected pcmcia card. Right now we don't do the right stuff to
> > reconnect that on re-insert but one day we may need to. As it is we keep
> > the instance around to avoid crashes
> 
> Ouch.  That (reconnects) may require interesting things from queue-related
> code.  What behaviour do you want while card is disconnected?  All requests
> getting errors / all requests getting blocked / reads failing, writes blocking?

This raises the interesting possibility of being able to refer to
things like removable media directly, instead of the device the media
is inserted in.

The Amiga was doing this years ago.  You could access floppy drives
as, E.G. df0:, df1:, etc, but if you formatted a volume and called it
foobar, you could access foobar: no matter which floppy drive you put
it in to.

Also, Plan 9 does similar interesting things - you can do the equivilent of:

ls /internet/websites/kernel.org/

and treat the website as a filesystem.

John.
