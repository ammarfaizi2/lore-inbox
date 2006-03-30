Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWC3Hdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWC3Hdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWC3Hdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:33:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61196 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751185AbWC3Hdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:33:32 -0500
Date: Thu, 30 Mar 2006 09:33:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330073342.GK13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org> <20060329180830.50666eff.akpm@osdl.org> <20060330072149.GI13476@suse.de> <20060329233037.14a24d4f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329233037.14a24d4f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > > Right now "flags" doesn't do anything at all, and you should just pass in 
> >  > > zero.
> >  > 
> >  > In that case perhaps we should be enforcing flags==0 so that future
> >  > flags-using applications will reliably fail on old flags-not-understanding
> >  > kernels.
> >  > 
> >  > But that won't work if we later define a bit in flags to mean "behave like
> >  > old kernels used to".  So perhaps we should require that bits 0-15 of
> >  > `flags' be zero and not care about bits 16-31.
> >  > 
> >  > IOW: it might be best to make `flags' just go away, and add new syscalls in
> >  > the future as appropriate.
> > 
> >  Not if flags == 0 maintains the same behaviour. The only flag I can
> >  think of right now is the 'move' or 'gift' flag, meaning that the caller
> >  wants to migrate pages from the pipe instead of copying them. I'd
> >  imagine we'd get that in way before 2.6.17 anyways, so I think we're
> >  fine.
> 
> OK..  Do you plan to make it reject unrecognised flags?

Depends, not sure if eg a 'move' flag should be a hard or soft
indication. Say we can't move a page and the caller asked us to migrate,
we'd probably just do the sane thing and copy that one page. It would be
silly to fail that request entirely.

-- 
Jens Axboe

