Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCKGnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCKGnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:43:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15327 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261604AbUCKGnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:43:50 -0500
Date: Thu, 11 Mar 2004 07:43:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040311064345.GB6955@suse.de>
References: <20040310124507.GU4949@suse.de> <20040310130046.2df24f0e.akpm@osdl.org> <20040310210207.GL15087@suse.de> <c2o212$4h0$1@news.cistron.nl> <20040310150542.13d71a39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310150542.13d71a39.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Andrew Morton wrote:
> 
> (Please use reply-to-all)
> 
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > In article <20040310210207.GL15087@suse.de>,
> > Jens Axboe  <axboe@suse.de> wrote:
> > >On Wed, Mar 10 2004, Andrew Morton wrote:
> > >> Jens Axboe <axboe@suse.de> wrote:
> > >> >
> > >> > Here's a first cut at killing global plugging of block devices to reduce
> > >> > the nasty contention blk_plug_lock caused.
> > >> 
> > >> Shouldn't we take read_lock(&md->map_lock) in dm_table_unplug_all()?
> > >
> > >Ugh yes, we certainly should.
> > 
> > With the latest patches from Joe it would be more like
> > 
> > 	map = dm_get_table(md);
> > 	if (map) {
> > 		dm_table_unplug_all(map);
> > 		dm_table_put(map);
> > 	}
> > 
> > No lock ranking issues, you just get a refcounted map (table, really).
> 
> Ah, OK.  Jens, you'll be needing this (on rc2-mm1):
> 
> dm.c: protect md->map with a rw spin lock rather than the md->lock
> semaphore.  Also ensure that everyone accesses md->map through
> dm_get_table(), rather than directly.

Neato, much better. I'll build on top of that.

-- 
Jens Axboe

