Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWHHKo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWHHKo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWHHKnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:43:00 -0400
Received: from brick.kernel.dk ([62.242.22.158]:32053 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932561AbWHHKmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:42:45 -0400
Date: Tue, 8 Aug 2006 12:43:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@gehennom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060808104353.GK4025@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex> <200608072247.59184.rjw@sisk.pl> <44D8626F.4020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D8626F.4020101@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2006, Jiri Slaby wrote:
> Rafael J. Wysocki wrote:
> >On Monday 07 August 2006 18:23, Jason Lunz wrote:
> >>In gmane.linux.kernel, you wrote:
> >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> >>>I tried it and guess what :)... swsusp doesn't work :@.
> >>>
> >>>This time I was able to dump process states with sysrq-t:
> >>>http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> >>>
> >>>My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel 
> >>>prints is suspending device 2.0
> >>Does it go away if you revert this?
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> >>
> >>That should only affect resume, not suspend, but it does mess around
> >>with ide power management. Is this maybe happening on the *second*
> >>suspend?
> >>
> >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> >>This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> >
> >I found that git-block.patch broke the suspend for me.  Still have no idea
> >what's up with it.
> 
> I suspect elevator changes. The wait_for_completion is not woken in
> ide-io by ll_rw_blk. But I don't understand block layer too much.

The ide changes are far more likely, it's probably missing a completion.

> Where the blk_end_sync_rq should be called from (why is not called at
> all)?

It's called from ->end_io() in end_that_request_last().

-- 
Jens Axboe

