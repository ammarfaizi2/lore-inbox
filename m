Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWBFNCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWBFNCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBFNCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:02:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53106 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751113AbWBFNCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:02:21 -0500
Date: Mon, 6 Feb 2006 14:04:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206130442.GV13598@suse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz> <200602062213.24735.nigel@suspend2.net> <20060206124034.GH4101@elf.ucw.cz> <20060206125035.GT13598@suse.de> <20060206125253.GJ4101@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206125253.GJ4101@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2006, Pavel Machek wrote:
> > > I'll get same bandwidth as you, without need for async I/O. Async I/O
> > > is not really a feature, suspend speed is. (There are existing
> > > interfaces for doing AIO from userspace, anyway, but I'm pretty sure
> > > they will not be needed
> > 
> > If you keep writing single pages sync, you sure as hell wont get
> > anywhere near async io in speed...
> 
> well, we can perfectly do 128K block... just read 128K into userspace
> buffer, flush it via single write to block device. That should get us
> very close enough to media speed.

That'll help naturally, 128k sync blocks will be very close to async
performance for most cases. Most cases here being drives with write back
caching enabled, if that is disabled async will still be a big win.

Is there any reason _not_ to just go with async io? Usually the code is
just as simple (or simpler), since the in-kernel stuff is inherently
async to begin with.

-- 
Jens Axboe

