Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUCSKAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 05:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUCSKAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 05:00:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22222 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262128AbUCSKAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 05:00:36 -0500
Date: Fri, 19 Mar 2004 11:00:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Miquel van Smoorenburg <miquels@cistron.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040319100031.GK22234@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403181737.i2IHbCE09261@mail.osdl.org> <20040318100615.7f2943ea.akpm@osdl.org> <20040318192707.GV22234@suse.de> <20040318191530.34e04cb2.akpm@osdl.org> <20040319073919.GY22234@suse.de> <E1B4Gjz-0003BI-00@subspace.cistron-office.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1B4Gjz-0003BI-00@subspace.cistron-office.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, Miquel van Smoorenburg wrote:
> In article <20040318235200.25c376a9.akpm@osdl.org> you write:
> >Jens Axboe <axboe@suse.de> wrote:
> >>  I thought about this last night, and I have a better idea that gets the
> >>  same accomplished. The problem right now is indeed that we aren't
> >>  tracking who needs to be unplugged, like we used to. The solution is to
> >>  do the exact same style plugging (with block helpers) that we used to,
> >>  except the plug_list is maintained in the driver. So when you do
> >>  dm_unplug(), it doesn't _have_ to iterate the full device list, only
> >>  those that do need kicking.
> >
> >Yes, it would be nice but I fear that it gets complicated.
> >
> >Is it not the case that two dm maps can refer to the same queue?  Say, one
> >map uses /dev/hda1 and another map uses /dev/hda2?
> >
> >If so, then when the /dev/hda queue is plugged we need to tell both the
> >higher-level maps that this queue needs an unplug.  So blk_plug_device()
> >and the various unplug functions need to perform upcalls to an arbitrary
> >number of higher-level drivers, and those drivers need to keep track of the
> >currently-plugged queues without adding data structures to the
> >request_queue structure.
> >
> >It can be done of course, but could get messy.
> 
> I implemented exactly this for the congestion stuff. It
> isn't perfect, but perhaps it is of some use:
>
> https://www.redhat.com/archives/linux-lvm/2004-February/msg00215.html
> 
> It got shot down because it was too complicated..

It is, at least the profiles so far don't even warrant it. It's worth to
keep in mind, though.

-- 
Jens Axboe

