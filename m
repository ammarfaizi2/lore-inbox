Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbRBEKhf>; Mon, 5 Feb 2001 05:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129912AbRBEKhZ>; Mon, 5 Feb 2001 05:37:25 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:57864 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129849AbRBEKhN>; Mon, 5 Feb 2001 05:37:13 -0500
Message-ID: <3A7E821B.C153B197@idb.hist.no>
Date: Mon, 05 Feb 2001 11:36:11 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: "Michael B. Trausch" <fd0man@crosswinds.net>, linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <Pine.LNX.4.21.0102021453560.27604-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael B. Trausch" wrote:
> 
> On Fri, 2 Feb 2001, Helge Hafting wrote:
> 
> > "Michael B. Trausch" wrote:
> > [...]
> > > DevFSd provides symlinks as follows:
> > >
> > >         /dev/ttyS0 = /dev/tts/0
> > >         /dev/tty0 = /dev/vc/0
> > >         /dev/pty* = /dev/pty/*
> > >
> > > Until programs use the new names (e.g., init should tell getty to use
> > > /dev/vc/0 instead of /dev/tty0), and everything on the system doesn't need
> > > support for the old-style names, you need to use devfsd and
> > > such.
> >
> > You don't have to wait for every program to use the new names, if
> > devfs is the way you want to go.  Do a "rgrep /dev /etc/*" and you'll

> /dev/sound/dsp and /dev/sound/mixer are owned by root:root, and start with
> 0600 permissions.  I want them to be owned by the console owner, and
> retain that 0600 permission.  I can't think of a way to do that exactly,
> so what I'm doing for now, is make them 0666 so that I can use them in my
> programs.  (I run from a 33.6 modem, for now, so I'm not worried about
> people snooping into my audio, becuase that's a *lot* of data for them to
> try to snoop).
> 
> Is this fixable the "right" way?

Sure.  Run devfsd (devfs daemon), and set up a good /etc/devfsd.conf
devfsd.conf can specify ownership and permissions instead of the
default created by the driver.  I get /dev/sound/dsp owned
by group "audio", and my non-root user is a member of that group.

devfsd.conf also specify which devices to create compatibility
symlinks for.  The default seems to be all, but you may
decide to create symlinks for only those devices that really need it,
such as sound.

Read the docs for devfsd and devfsd.conf.  

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
