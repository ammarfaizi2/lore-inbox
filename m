Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTBJO4j>; Mon, 10 Feb 2003 09:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTBJO4j>; Mon, 10 Feb 2003 09:56:39 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:52354 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261523AbTBJO4i>;
	Mon, 10 Feb 2003 09:56:38 -0500
Date: Mon, 10 Feb 2003 16:05:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       riel@conectiva.com.br
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.
Message-ID: <20030210150543.GS31401@dualathlon.random>
References: <20030210034808.7441d611.akpm@digeo.com> <XFMail.20030210154959.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20030210154959.pochini@shiny.it>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:49:59PM +0100, Giuliano Pochini wrote:
> 
> >> You can wait 10 minutes and still such command can't grow.  This is why
> >> claiming anticipatory scheduling can decrease the need for readahead
> >> doesn't make much sense to me, there are important things you just can't
> >> achieve by only waiting.
> >> 
> > 
> > The anticipatory scheduler can easily permit 512k of reading before seeking
> > away to another file.  In fact it can allow much more, without requiring that
> > readhead be cranked up.
> 
> IMHO anticipatory scheduling and readahead address different problems. RA is
> simpler and cheaper. Reading a few more KB comes almost for free and that
> helps a lot sequential reads. AS is useful for random i/o (fs metadata,
> executables, ...), but it wastes time if the timer expires, or if the new
> request wants data which is far away the previous one. AS is useful for

Yep.

> sequential reads too, but only if the application reads large chunks of
> data, otherwise RA is better. I we need both RA and AS to address the

actually even if the app reads large chunks of data RA is needed, the
size of the read/io_submit syscalls won't reach the
readpage/wait_on_page at the pagecache layer, w/o readahead we would
read PAGE_SIZE per dma and not more (ignoring PAGE_CACHE_SIZE of course,
which isn't going to be enough anyways due mem fragmentation issues)

> largest variety of workloads.
> 
> Bye.


Andrea
