Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTEZNMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTEZNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:12:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264373AbTEZNMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:12:39 -0400
Date: Mon, 26 May 2003 15:25:28 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Hugh Dickins <hugh@veritas.com>, LW@KARO-electronics.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030526132528.GH845@suse.de>
References: <20030523175413.A4584@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain> <20030523112926.7c864263.akpm@digeo.com> <20030523193458.B4584@flint.arm.linux.org.uk> <1053919171.14018.2.camel@rth.ninka.net> <20030526095551.C4417@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526095551.C4417@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Russell King wrote:
> On Sun, May 25, 2003 at 08:19:32PM -0700, David S. Miller wrote:
> > Oh yes, this part is.  If you don't ensure this, everything
> > breaks.
> > 
> > At the end of an I/O operation, say to a page cache page, that
> > data ought to be visible equally to a userspace vs. a kernel
> > space mapping to that page.
> > 
> > For example, this is why we use language about "cpu visibility" in the
> > DMA api documentation and not "kernel cpu visibility" :-)  And because
> > PIO transfers are basically pseudo-DMA they need to make the same exact
> > guarentees.
> > 
> > If you've been living in a world where you didn't think this is
> > necessary, I certainly feel bad for you :-)
> 
> Ok, so the flush_dcache_page() interface looses this; the original
> placement of the flush_page_to_ram() ensured that data written by
> device drivers was visible to user space.
> 
> Maybe the BIO layer can handle this - the same problem exists when
> (and if) BIO uses a bounce buffer, so it would have to be handled
> there.  Jens?

For bouncing it's relatively trivial to add (and probably should, feel
free...). PIO etc is really a driver problem to handle, I don't see how
that could be handled generically.

-- 
Jens Axboe

