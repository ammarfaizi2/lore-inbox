Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBBKgu>; Fri, 2 Feb 2001 05:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbRBBKgk>; Fri, 2 Feb 2001 05:36:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:45580 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129110AbRBBKgW>; Fri, 2 Feb 2001 05:36:22 -0500
Message-ID: <3A7A8D6D.2C13D5EB@idb.hist.no>
Date: Fri, 02 Feb 2001 11:35:25 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: "Michael B. Trausch" <fd0man@crosswinds.net>, linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <Pine.LNX.4.21.0101311746540.3842-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael B. Trausch" wrote:
[...]
> DevFSd provides symlinks as follows:
> 
>         /dev/ttyS0 = /dev/tts/0
>         /dev/tty0 = /dev/vc/0
>         /dev/pty* = /dev/pty/*
> 
> Until programs use the new names (e.g., init should tell getty to use
> /dev/vc/0 instead of /dev/tty0), and everything on the system doesn't need
> support for the old-style names, you need to use devfsd and
> such.

You don't have to wait for every program to use the new names, if devfs
is
the way you want to go.  Do a "rgrep /dev /etc/*" and you'll find
that many device-using programs have their device names stored in
configuration files.  Fixing these files is simple, just replace 
/dev/device with whatever the symlink points to.  [This leaves a few
files like /etc/securetty that use relative pathnames.  These are
of course fixable too, they just don't have the /dev to search for.]

This lets you get rid of a lot of symlinks.  I still need symlinks for
/dev/tty* (hardcoded in X), isdn stuff and sound stuff.  Everything else
is gone from dev, sitting comfortably in subdirectories only.
Getting rid of all "possible" disks helped in particular, "ls /dev"
fits in a standard 80x25 screen now. :-)

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
