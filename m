Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSDABCh>; Sun, 31 Mar 2002 20:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292289AbSDABC1>; Sun, 31 Mar 2002 20:02:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16194 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292229AbSDABCT>; Sun, 31 Mar 2002 20:02:19 -0500
Date: Mon, 1 Apr 2002 03:02:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
Message-ID: <20020401030207.N1331@dualathlon.random>
In-Reply-To: <3C9807AD.65EBB69C@zip.com.au> <Pine.LNX.4.10.10203311422310.2622-100000@mikeg.wen-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 02:26:14PM +0200, Mike Galbraith wrote:
> #!/bin/sh
> # testo
> # /tmp is tmpfs
> 
> for i in 1 2 3 4 5
> do
> 	mv /test/linux-2.5.7 /tmp/.
> 	mv /tmp/linux-2.5.7 /test/.
> done

It would be important to see the /tmp and /test tests benchmarked
separately, the way tmpfs and normal filesystem writes to disk is very
different and involves different algorithms, so it's not easy to say
which one could go wrong by looking at the global result. Just in case:
it is very important that the tmpfs contents are exactly the same before
starting the two tests. If you load something into /tmp before starting
the test performance will be different due the need of additional
swapouts.

So I would suggest moving linux-2.5.7 over two normal fs and then just
moving it over two tmpfs, so we know what's running slower.

Another possibility is that the lru could be more fair (we may better at
flushing dirty pages, allowing them to be discarded in lru order), I
assume your machine cannot take in cache a kernel tree, so there should
be a total cache trashing scenario.  So you may want to verify with
vmstat that both kernels are doing the very same amount of I/O, just to
be sure one of the two isn't faster because of additional fariness in
the lru information, and not because of slower I/O.

Thanks,

Andrea
