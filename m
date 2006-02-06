Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWBFGDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWBFGDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 01:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWBFGDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 01:03:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751014AbWBFGDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 01:03:04 -0500
Date: Sun, 5 Feb 2006 22:02:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060205220204.194ba477.akpm@osdl.org>
In-Reply-To: <20060205215052.c5ab1651.pj@sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > >  I'd have thought it would be saner to split these things apart:
> > >  "slab_spread", "pagecache_spread", etc.
> > 
> > This, please.   It impacts the design of the whole thing.
> 
> It was still in my queue to respond to, yes.
> 
> All I am aware that is needed is to distinguish between:
> 
>   (1) application space pages, such as data and stack space,
>       which the applications can page and place under their
>       detailed control, and
> 
>   (2) what from the application's viewpoint is "kernel stuff"
>       such as large amounts of pages required by file i/o,
>       and their associated inode/dentry structures.
> 
> The application space pages are typically anonymous pages
> which go away when the owning tasks exits, while the kernel
> space pages are typically accessible by multiple tasks and
> can stay around long after the initial faulting task exits.
> 
> I prefer to keep the tunable knobs to a minimum.  One boolean
> was sufficient for this.
> 
> Just because a distinction seems substantial from the kernel
> internals perspective, doesn't mean we should reflect that in
> the tunable knobs.  We should have an actual need first, not
> a strawman.
> 
> If there is some reason, or preference, for adding two knobs
> (slab and page) instead of one, I can certainly do it.
> 
> I am not yet aware that such is useful.
> 

I suspect that you'll find different workload patterns and sequences which
cause similar regressions in the future.  It'd be useful to sit down and
try to think of some and try them out.

I think the bottom line here is that the kernel just cannot predict the
future and it will need help from the applications and/or administrators to
be able to do optimal things.  For that, finer-grained one-knob-per-concept
controls would be better.
