Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSFRXEE>; Tue, 18 Jun 2002 19:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317663AbSFRXEC>; Tue, 18 Jun 2002 19:04:02 -0400
Received: from pc132.utati.net ([216.143.22.132]:54145 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S317662AbSFRXEA>; Tue, 18 Jun 2002 19:04:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Jacobowitz <drow@false.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Inexplicable disk activity trying to load modules on devfs
Date: Tue, 18 Jun 2002 13:05:40 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <20020615172244.C19123@crack.them.org> <3D0BC34E.BAE89EB9@zip.com.au> <20020615180426.C19472@crack.them.org>
In-Reply-To: <20020615180426.C19472@crack.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020618223800.3F3777D9@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 June 2002 07:04 pm, Daniel Jacobowitz wrote:
> On Sat, Jun 15, 2002 at 03:44:30PM -0700, Andrew Morton wrote:
> > Daniel Jacobowitz wrote:
> > > I just booted into 2.4.19-pre10-ac2 for the first time, and noticed
> > > something very odd: my disk activity light was flashing at about
> > > half-second intervals, very regularly, and I could hear the disk
> > > moving.  I was only able to track it down to which disk controller, via
> > > /proc/interrupts (are there any tools for monitoring VFS activity?
> > > They'd be really useful).  Eventually I hunted down the program causing
> > > it: xmms.
> > >
> > > The reason turned out to be that I hadn't remembered to build my sound
> > > driver for this kernel version.  Every half-second xmms tried to open
> > > /dev/mixer (and failed, ENOENT).  Every time it did that there was
> > > actual disk activity.  Easily reproducible without xmms.  Reproducible
> > > on any non-existant device in devfs, but not for nonexisting files on
> > > other filesystems.  Is something bypassing the normal disk cache
> > > mechanisms here?  That doesn't seem right at all.
> >
> > syslog activity from a printk, perhaps?
>
> Nope.  No log activity whatsoever.

Updated atime on the /dev/blah node?

Random guess...

Rob
