Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWBFN5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWBFN5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWBFN5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:57:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932112AbWBFN5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:57:17 -0500
Date: Mon, 6 Feb 2006 14:59:37 +0100
From: Jens Axboe <axboe@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <nigel@suspend2.net>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206135937.GA13598@suse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060206125253.GJ4101@elf.ucw.cz> <20060206130442.GV13598@suse.de> <200602061445.55966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602061445.55966.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2006, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday 06 February 2006 14:04, Jens Axboe wrote:
> > On Mon, Feb 06 2006, Pavel Machek wrote:
> > > > > I'll get same bandwidth as you, without need for async I/O. Async I/O
> > > > > is not really a feature, suspend speed is. (There are existing
> > > > > interfaces for doing AIO from userspace, anyway, but I'm pretty sure
> > > > > they will not be needed
> > > > 
> > > > If you keep writing single pages sync, you sure as hell wont get
> > > > anywhere near async io in speed...
> > > 
> > > well, we can perfectly do 128K block... just read 128K into userspace
> > > buffer, flush it via single write to block device. That should get us
> > > very close enough to media speed.
> > 
> > That'll help naturally, 128k sync blocks will be very close to async
> > performance for most cases. Most cases here being drives with write back
> > caching enabled, if that is disabled async will still be a big win.
> > 
> > Is there any reason _not_ to just go with async io? Usually the code is
> > just as simple (or simpler), since the in-kernel stuff is inherently
> > async to begin with.
> 
> Actually the userland tools we're working on use async I/O.  [There's
> no real need for sync, I think.]  Still we write one page at a time,
> for now, so the I/O performance is not that much better than for the
> built-in swsusp, but it _is_ better.

How many pages you write out at the time doesn't matter very much - that
usually just boils down to how efficient you are wrt CPU usage,
something that suspend probably doesn't need to care a whole lot about.
What matters is how often you wait for a page. Writing 256MiB here, on a
plain SATA drive:

4k sync writes:         17.9MiB/sec
4k async writes:        29.6MiB/sec
128k sync writes:       36.0MiB/sec
128k async writes:      41.9MiB/sec

-- 
Jens Axboe

