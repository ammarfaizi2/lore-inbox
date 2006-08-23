Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWHWR66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWHWR66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWHWR66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:58:58 -0400
Received: from brick.kernel.dk ([62.242.22.158]:51554 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932324AbWHWR66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:58:58 -0400
Date: Wed, 23 Aug 2006 20:01:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       okuji@enbug.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
Message-ID: <20060823180118.GY5893@suse.de>
References: <20060823113243.210352005@localhost.localdomain> <20060823113317.722640313@localhost.localdomain> <20060823120355.GD5893@suse.de> <20060823102741.b927e092.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823102741.b927e092.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23 2006, Andrew Morton wrote:
> On Wed, 23 Aug 2006 14:03:55 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > On Wed, Aug 23 2006, Akinobu Mita wrote:
> > > This patch provides fail-injection capability for disk IO.
> > > 
> > > Boot option:
> > > 
> > > 	fail_make_request=<probability>,<interval>,<times>,<space>
> > > 
> > > 	<probability>
> > > 
> > > 		specifies how often it should fail in percent.
> > > 
> > > 	<interval>
> > > 
> > > 		specifies the interval of failures.
> > > 
> > > 	<times>
> > > 
> > > 		specifies how many times failures may happen at most.
> > > 
> > > 	<space>
> > > 
> > > 		specifies the size of free space where disk IO can be issued
> > > 		safely in bytes.
> > > 
> > > Example:
> > > 
> > > 	fail_make_request=100,10,-1,0
> > > 
> > > generic_make_request() fails once per 10 times.
> > 
> > Hmm dunno, seems a pretty useless feature to me.
> 
> We need it.  What is the FS/VFS/VM behaviour in the presence of IO
> errors?  Nobody knows, because we rarely test it.  Those few times where
> people _do_ test it (the hard way), bad things tend to happen.  reiserfs
> (for example) likes to go wobble, wobble, wobble, BUG.

You misunderstood me - a global parameter is useless, as it makes it
pretty impossible for people to use this for any sort of testing (unless
it's very specialized). I didn't say a feature to test io errors was
useless!

> > Wouldn't it make a lot
> > more sense to do this per-queue instead of a global entity?
> 
> Yes, I think so.  /sys/block/sda/sda2/make-it-fail.

Precisely.

-- 
Jens Axboe

