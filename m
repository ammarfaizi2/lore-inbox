Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317812AbSGPI6z>; Tue, 16 Jul 2002 04:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317816AbSGPI6y>; Tue, 16 Jul 2002 04:58:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24590 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317812AbSGPI6w>;
	Tue, 16 Jul 2002 04:58:52 -0400
Message-ID: <3D33E2BB.9C73294A@zip.com.au>
Date: Tue, 16 Jul 2002 02:09:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de> <3D33DED8.C5C92C06@zip.com.au> <20020716084856.GR811@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, Jul 16 2002, Andrew Morton wrote:
> > Jens Axboe wrote:
> > >
> > > On Tue, Jul 16 2002, Andrew Morton wrote:
> > > > William Lee Irwin III wrote:
> > > > >
> > > > > loop.c oopses when bio_copy() returns NULL. This was encountered while
> > > > > running dbench 16 on a loopback-mounted reiserfs filesystem.
> > > >
> > > > ugh.  GFP_NOIO is evil.  I guess it's better to add __GFP_HIGH
> > > > there, but it's not a happy solution.
> > >
> > > GFP_NOIO has __GFP_WAIT set, so bio_copy -> bio_alloc -> mempool_alloc
> > > should never fail. Puzzled.
> > >
> >
> > Presumably the loop driver was called from within shrink_cache(),
> > as PF_MEMALLOC.  Those allocations can fail.
> 
> Maybe I'm being dense, but I don't see how PF_MEMALLOC would prevent
> mempool_alloc() from doing the right thing still. In the end we'll just
> end up stalling on our own pool.

Ah.  I'd forgotten about the mempool layer.

bio_copy() does alloc_page().


-
