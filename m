Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTKQGFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 01:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTKQGFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 01:05:43 -0500
Received: from dp.samba.org ([66.70.73.150]:59542 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263340AbTKQGFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 01:05:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lib.a causing modules not to load 
In-reply-to: Your message of "08 Nov 2003 09:16:10 MDT."
             <1068304571.2048.5.camel@mulgrave> 
Date: Mon, 17 Nov 2003 13:47:34 +1100
Message-Id: <20031117060542.088D32C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1068304571.2048.5.camel@mulgrave> you write:
> On Sat, 2003-11-08 at 02:51, Christoph Hellwig wrote:
> > On Fri, Nov 07, 2003 at 08:34:19PM -0800, Andrew Morton wrote:
> > > How about we just link that function into the kernel and be done with it?
 
> > > We'll waste a few bytes on SMP machines which have neither ext2 nor ext3
> > > linked-in or loaded as modules, but that doesn't sound very important...
> > > 
> > > (We don't have a kernel/random-support-stuff.c, but we have
> > > mm/random-support-stuff.c which for some reason is called mm/swap.c, so
> > > I put it there).
> > 
> > Well, this solves the problem for this particular case, but not other
> > stuff in lib for other situations.
> 
> I agree...there's much more in lib than just percpu_counter_mod.

I think lib.a should be linked as is if !CONFIG_MODULES, and done as a
..o if CONFIG_MODULES.  Other alternatives are possible, but make it
tricky if someone adds a module later which wants something in lib.a.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
