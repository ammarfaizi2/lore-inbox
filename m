Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUGGVBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUGGVBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbUGGVA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:00:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:50391 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265489AbUGGU7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:59:49 -0400
Subject: Re: Unnecessary barrier in sync_page()?
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040707184202.GN28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet>
	 <20040707182025.GJ28479@dualathlon.random>
	 <20040707112953.0157383e.akpm@osdl.org>
	 <20040707184202.GN28479@dualathlon.random>
Content-Type: text/plain
Message-Id: <1089233823.3956.80.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 16:57:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 14:42, Andrea Arcangeli wrote:
> On Wed, Jul 07, 2004 at 11:29:53AM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > however the smp_mb() isn't needed in sync_page, simply because it's
> > >  perfectly ok if we start running sync_page before reading pagelocked.
> > >  All we care about is to run sync_page _before_ io_schedule() and that we
> > >  read PageLocked _after_ prepare_to_wait_exclusive.
> > > 
> > >  So the locking in between PageLocked and sync_page is _absolutely_
> > >  worthless and the smp_mb() can go away.
> > 
> > IIRC, Chris added that barrier (and several similar) for the reads in
> > page_mapping().
> 
> how does it help to know the page is not locked before executing
> page_mapped?

I wasn't worried about the locked bit when I added the barrier, my goal
was to order things with people that set page->mapping to null.

-chris


