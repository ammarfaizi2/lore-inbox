Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315794AbSFOXEh>; Sat, 15 Jun 2002 19:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSFOXEg>; Sat, 15 Jun 2002 19:04:36 -0400
Received: from crack.them.org ([65.125.64.184]:20489 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S315783AbSFOXEf>;
	Sat, 15 Jun 2002 19:04:35 -0400
Date: Sat, 15 Jun 2002 18:04:26 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inexplicable disk activity trying to load modules on devfs
Message-ID: <20020615180426.C19472@crack.them.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020615172244.C19123@crack.them.org> <3D0BC34E.BAE89EB9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 03:44:30PM -0700, Andrew Morton wrote:
> Daniel Jacobowitz wrote:
> > 
> > I just booted into 2.4.19-pre10-ac2 for the first time, and noticed
> > something very odd: my disk activity light was flashing at about
> > half-second intervals, very regularly, and I could hear the disk
> > moving.  I was only able to track it down to which disk controller, via
> > /proc/interrupts (are there any tools for monitoring VFS activity?
> > They'd be really useful).  Eventually I hunted down the program causing
> > it: xmms.
> > 
> > The reason turned out to be that I hadn't remembered to build my sound
> > driver for this kernel version.  Every half-second xmms tried to open
> > /dev/mixer (and failed, ENOENT).  Every time it did that there was
> > actual disk activity.  Easily reproducible without xmms.  Reproducible
> > on any non-existant device in devfs, but not for nonexisting files on
> > other filesystems.  Is something bypassing the normal disk cache
> > mechanisms here?  That doesn't seem right at all.
> > 
> 
> syslog activity from a printk, perhaps?

Nope.  No log activity whatsoever.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
MontaVista Software                         Carnegie Mellon University
