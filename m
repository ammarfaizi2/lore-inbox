Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbTCZR7d>; Wed, 26 Mar 2003 12:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbTCZR7d>; Wed, 26 Mar 2003 12:59:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56326 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261803AbTCZR7c>; Wed, 26 Mar 2003 12:59:32 -0500
Date: Wed, 26 Mar 2003 13:06:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
In-Reply-To: <20030325171223.7a2c50ee.akpm@digeo.com>
Message-ID: <Pine.LNX.3.96.1030326130415.8110A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Andrew Morton wrote:

> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > shrink_list's may_enter_fs (may_write_page would be a better name)
> > currently reflects that swapcache page I/O won't suffer from FS
> > complications, so can be done if __GFP_IO without __GFP_FS; but
> > the same is true of a tmpfs page (which is just this stage away
> > from being a swapcache page), so check bdi->memory_backed instead.
> > 
> > ...
> >
> > +			if (!(gfp_mask & (bdi->memory_backed?
> > +					__GFP_IO: __GFP_FS)))
> >  				goto keep_locked;
> 
> Barf.  I haven't used a question mark operator in ten years, and this is a
> fine demonstration of why ;)
> 
> I think a feasibly comprehensible transformation would be:
> 
> 	/*
> 	 * A comment goes here
> 	 */
> 	if (bdi->memory_backed)
> 		may_enter_fs = gfp_mask & __GFP_IO;
> 	else
> 		may_enter_fs = gfp_mask & __GFP_FS;

Unless there's a subtle difference in functionality here that I'm missing,
you are doing the same thing in a larger and slower way, and the logic is
less clear.

Is there some benefit I'm missing?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

