Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSKDJhz>; Mon, 4 Nov 2002 04:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSKDJhy>; Mon, 4 Nov 2002 04:37:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40603 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262067AbSKDJhx>;
	Mon, 4 Nov 2002 04:37:53 -0500
Date: Mon, 4 Nov 2002 10:44:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021104094413.GF13587@suse.de>
References: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com> <Pine.LNX.4.44.0211031452380.11657-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031452380.11657-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Linus Torvalds wrote:
> 
> On Sun, 3 Nov 2002, Linus Torvalds wrote:
> > 
> > The above should work pretty much on all block drivers out there, btw:
> > the ones that don't understand SCSI commands should just ignore requests
> > that aren't the regular REQ_CMD commands.
> 
> Note that "should work" does not necessarily mean "does work". For
> example, in the IDE world, some of the generic packet command stuff is
> only understood by ide-cd.c, and the generic IDE layer doesn't necessarily
> understand it even if you have a disk that speaks ATAPI. I think Jens will 
> fix that wart.

It's probably not a good idea to rely on ata drives that also speak
atapi, to my knowledge only a few old WDC drives ever did that. Since we
are basically moving to the point where "SCSI" commands is the
commandset that the block layer uses to make drivers do things for it,
I had the idea of doing a rq -> taskfile conversion for ide. Just for
simple things like read/write and sync cache, basically stuff that is
directly translatable. That would make Linus' example actually work, and
it would also make the direct read/write programs using SG_IO work on
IDE drives as well.

-- 
Jens Axboe

