Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUCSIsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 03:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUCSIsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 03:48:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46260 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261966AbUCSIsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 03:48:23 -0500
Date: Fri, 19 Mar 2004 09:48:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: markw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040319084819.GI22234@suse.de>
References: <200403181737.i2IHbCE09261@mail.osdl.org> <20040318100615.7f2943ea.akpm@osdl.org> <20040318192707.GV22234@suse.de> <20040318191530.34e04cb2.akpm@osdl.org> <20040319073919.GY22234@suse.de> <20040318235200.25c376a9.akpm@osdl.org> <20040319075704.GD22234@suse.de> <20040319001921.269380a3.akpm@osdl.org> <20040319083125.GE22234@suse.de> <20040319003937.41b9ede4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319003937.41b9ede4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Fri, Mar 19 2004, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > > Is it not the case that two dm maps can refer to the same queue?  Say, one
> > > > > map uses /dev/hda1 and another map uses /dev/hda2?
> > > > > 
> > > > > If so, then when the /dev/hda queue is plugged we need to tell both the
> > > > > higher-level maps that this queue needs an unplug.  So blk_plug_device()
> > > > > and the various unplug functions need to perform upcalls to an arbitrary
> > > > > number of higher-level drivers, and those drivers need to keep track of the
> > > > > currently-plugged queues without adding data structures to the
> > > > > request_queue structure.
> > > > > 
> > > > > It can be done of course, but could get messy.
> > > > 
> > > > That would get nasty, it's much more natural to track it from the other
> > > > end. I view it as a dm (or whatever problem) that they need to track who
> > > > has pending io on their behalf, which is pretty easy to to from eg
> > > > __map_bio().
> > > 
> > > But dm doesn't know enough.  Suppose it is managing a map which includes
> > > /dev/hda1 and I do some I/O against /dev/hda2 which plugs the queue.  dm
> > > needs to know about that plug.
> > 
> > I don't follow at all. If dm initiates io against /dev/hda2, it's part
> > of that mapped device and it can trigger and note the unplug just fine.
> 
> Right.  But suppose I have a plain old ext2 fs mounted on /dev/hda1.  I do
> some I/O against /dev/hda1, and that causes the /dev/hda queue to be
> plugged.  Device mapper doesn't know that the queue is currently plugged,
> because it was some totally unrelated piece of code which caused the plug.

You are right, that breaks. No good.

-- 
Jens Axboe

