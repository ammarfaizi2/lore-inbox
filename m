Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbUCJVEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbUCJVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:04:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60136 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262846AbUCJVCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:02:11 -0500
Date: Wed, 10 Mar 2004 22:02:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310210207.GL15087@suse.de>
References: <20040310124507.GU4949@suse.de> <20040310130046.2df24f0e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310130046.2df24f0e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Here's a first cut at killing global plugging of block devices to reduce
> > the nasty contention blk_plug_lock caused.
> 
> Shouldn't we take read_lock(&md->map_lock) in dm_table_unplug_all()?

Ugh yes, we certainly should.

> If so, what are the lock ranking issues here?  The queue lock is not
> held yet, so it seems pretty simple?

As far as I can tell, it's pretty straight forward. The unplug_fn() will
grab the queue lock for 'ordinary' devices, for dm on dm you'd nest the
maplock inside each other (which should be quite alright, as far as I
can tell, without pulling any nasty tricks).

-- 
Jens Axboe

