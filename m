Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUGVXjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUGVXjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGVXjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:39:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62873 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261951AbUGVXiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:38:55 -0400
Date: Thu, 22 Jul 2004 19:40:17 -0200
From: Jens Axboe <axboe@suse.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: audio cd writing causes massive swap and crash
Message-ID: <20040722214016.GO3987@suse.de>
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de> <40FBBAAE.5060405@comcast.net> <40FC2E60.2030101@comcast.net> <40FF4563.5070407@comcast.net> <20040722125450.GC3987@suse.de> <1090529059.10205.34.camel@nosferatu.lan> <41004E05.8020804@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41004E05.8020804@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22 2004, Ed Sweetman wrote:
> Martin Schlemmer wrote:
> 
> >On Thu, 2004-07-22 at 14:54, Jens Axboe wrote:
> > 
> >
> >>On Thu, Jul 22 2004, Ed Sweetman wrote:
> >>   
> >>
> >>>I've had other people test writing.  It appears that scsi-emu is not 
> >>>effected by this memory leak when writing audio cds.  So it would appear 
> >>>that ide-cd along with any of the dependent ide source files is the 
> >>>culprit. But I cannot find anywhere in ide-cd that is apparent to being 
> >>>a mem leak.  There are various conditions in ide_do_drive_cmd that state 
> >>>that the cdrom driver has to be very careful about handling but without 
> >>>intimate knowledge of the driver, I can't be sure that it's sufficiently 
> >>>handling those situations.  
> >>>
> >>>Surprisingly, it's very hard to find anyone who's used the native atapi 
> >>>mode to write an audio cd in 2.6.  Which is partly why this problem 
> >>>hasn't generated more mail traffic here I would guess. 
> >>>     
> >>>
> >>That's not true, lots of people use it. But, oddly, the leak isn't
> >>reproducable on any machine I've tested.
> >>   
> >>
> >
> >I seem to remember he noted a patch about dma during audio writing,
> >and his 'testing' if it might be the cause was to just disable dma
> >on the drive ...
> > 
> >
> 
> 
> The patch is now part of vanilla 2.6.   It was an audio dma api that was 
> a workaround for the broken dma api that only allows ide commands 
> 512bytes long.  Schilling mentioned something about this in an earlier 
> lkml posting around january.  
> 
> I've asked some other people in an irc channel to test out the problem.  
> Basically You need to be using the native atapi method for recording 
> audio.   Also, it appears that the mem leak is just what happens to some 
> people, other people like some of those who tested in the irc channel 
> experienced random program sigsevs and no mem leak at all.  It would 
> appear from this that what may be happening is the cdrom ide module is 
> mangling a pointer and either can't free it due to it possibly randomly 
> pointing to null or cause crashes due to it randomly pointing to other 
> anonymous/shared memory regions as kfree is called. That's obviously 
> just a guess.  But some sort of memory mangling is apparently 
> happening.  This is not just happening on my computer. 
> 
> 
> My drive is using udma33 and not mdma so maybe that makes the problem 
> occur more quickly.    I disabled dma to test it writing the old way but 
> it appears to be occuring in ide-cd or somewhere between cdrom.o and the 
> block device layer.  ide-scsi people dont have the problem at all 
> apparently.

Does turning on all the debug options (memory related, mostly) reveal
anything interesting?

-- 
Jens Axboe

