Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265215AbRGEOj5>; Thu, 5 Jul 2001 10:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbRGEOjh>; Thu, 5 Jul 2001 10:39:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21520 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265247AbRGEOjf>; Thu, 5 Jul 2001 10:39:35 -0400
Date: Thu, 5 Jul 2001 16:37:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
Message-ID: <20010705163716.R17051@athlon.random>
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>, <3B3C4CB4.6B3D2B2F@kegel.com>; <20010705155350.O17051@athlon.random> <3B44797F.DD9EAC99@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B44797F.DD9EAC99@uow.edu.au>; from andrewm@uow.edu.au on Fri, Jul 06, 2001 at 12:28:15AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 12:28:15AM +1000, Andrew Morton wrote:
> ext3 journals data.  That's unique and it breaks things (or rather,
> things break it).   It'd be trivial to support O_DIRECT in ext3's
> writeback mode (metadata-only), but nobody uses that.

I thought everybody uses metadata-only to avoid killing data-write
performance. So I thought it was ok to at first support O_DIRECT only
for metadata journaling, doing that should be a three liner as you said
and that is what I expected.

> >From a quick look it seems that we'll need fs-private implementations
> of generic_direct_IO() and brw_kiovec() at least.

brw_kiovec is called by generic_direct_IO, so yes, all you need is a
private generic_direct_IO implementation to deal with the journaled data
writes.

> I'll take a closer look.

OK, thanks!

Andrea
