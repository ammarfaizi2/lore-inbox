Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbRBBUB2>; Fri, 2 Feb 2001 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRBBUBS>; Fri, 2 Feb 2001 15:01:18 -0500
Received: from mdmgrp1-144.accesstoledo.net ([207.43.106.144]:14085 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129103AbRBBUBD>;
	Fri, 2 Feb 2001 15:01:03 -0500
Date: Fri, 2 Feb 2001 15:00:00 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <3A7A8D6D.2C13D5EB@idb.hist.no>
Message-ID: <Pine.LNX.4.21.0102021453560.27604-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Helge Hafting wrote:

> "Michael B. Trausch" wrote:
> [...]
> > DevFSd provides symlinks as follows:
> > 
> >         /dev/ttyS0 = /dev/tts/0
> >         /dev/tty0 = /dev/vc/0
> >         /dev/pty* = /dev/pty/*
> > 
> > Until programs use the new names (e.g., init should tell getty to use
> > /dev/vc/0 instead of /dev/tty0), and everything on the system doesn't need
> > support for the old-style names, you need to use devfsd and
> > such.
> 
> You don't have to wait for every program to use the new names, if
> devfs is the way you want to go.  Do a "rgrep /dev /etc/*" and you'll
> find that many device-using programs have their device names stored in
> configuration files.  Fixing these files is simple, just replace
> /dev/device with whatever the symlink points to.  [This leaves a few
> files like /etc/securetty that use relative pathnames.  These are of
> course fixable too, they just don't have the /dev to search for.]
> 

Yeah, also mpg123 has /dev/dsp hardcoded.  Which reminds me of a problem
that I'm having with DevFS - I have a minor fix for it, but I don't think
that's "correct" due to the way it works.  Myabe DevFS was supposed to
have this behavior change:  The console owner can't play sound. =(

/dev/sound/dsp and /dev/sound/mixer are owned by root:root, and start with
0600 permissions.  I want them to be owned by the console owner, and
retain that 0600 permission.  I can't think of a way to do that exactly,
so what I'm doing for now, is make them 0666 so that I can use them in my
programs.  (I run from a 33.6 modem, for now, so I'm not worried about
people snooping into my audio, becuase that's a *lot* of data for them to
try to snoop).

Is this fixable the "right" way?

> This lets you get rid of a lot of symlinks.  I still need symlinks for
> /dev/tty* (hardcoded in X), isdn stuff and sound stuff.  Everything
> else is gone from dev, sitting comfortably in subdirectories only.
> Getting rid of all "possible" disks helped in particular, "ls /dev"
> fits in a standard 80x25 screen now. :-)
> 

That's the one thing that I really like, I can look at /dev/ide/hd/* and
see what I *have*, not what I *could* have.  That saves me the trouble of
having to do an fdisk -l every time I want to see what partitions I have
on my drives.

I just need to get ide-scsi working and I'll be all set, I still don't
have ide-scsi working in 2.4.x but I haven't tried it yet.  When I do, I'm
hoping that I can get it working completely so that I can use my burner.

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
