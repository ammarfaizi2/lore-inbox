Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUCRM2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUCRM2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:28:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56732 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262580AbUCRM2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:28:34 -0500
Date: Thu, 18 Mar 2004 13:28:31 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy driver 2.6.3 question
Message-ID: <20040318122831.GO22234@suse.de>
References: <20040318113506.GL22234@suse.de> <200403181223.i2ICNkE13506@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181223.i2ICNkE13506@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Peter T. Breuer wrote:
> > > know.  128 requests have just previously been errored due to readahead
> > > and the check_media_changed result setting the driver request function
> > > to error out requests.  Perhaps we have run out of requests (they're
> > > all put_ as far as I can see). Maybe the block layers get tired of
> > > talking to a device that errors requests. I'm just feeling my way!
> > > Any wild ideas are welcome!
> > 
> > If the 129th request fails, then that's a pretty good clue that you
> > aren't getting the requests freed. Perhaps you are overwriting something
> > in the request after allocating it? Always mask change ->flags (don't
> > just set it), and don't overwrite ->rl.
> 
> Good idea. rl is inviolate, but I set at least |=REQ_NOMERGE sometimes
> on flags. And I pass ioctl information in fake requests by setting

May I ask on what commands you set that bit?

> the bit just beyond the edge of those currently used (__REQ_BITS) to
> indicate its an ioctl and treating it specially in end request. Maybe
> on error I forgot to remove the extra bit before doing put_blk_request

Ugh, that sounds like very bad practice... The 'standard' way of doing
something like that is to flag REQ_SPECIAL and put whatever structure
you want in ->special.

-- 
Jens Axboe

