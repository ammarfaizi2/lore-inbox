Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285940AbRLaBAY>; Sun, 30 Dec 2001 20:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285944AbRLaBAO>; Sun, 30 Dec 2001 20:00:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28238 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285940AbRLaBAA>; Sun, 30 Dec 2001 20:00:00 -0500
Date: Mon, 31 Dec 2001 02:00:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrdkern el panic woes
Message-ID: <20011231020009.R1356@athlon.random>
In-Reply-To: <20011231012825.P1356@athlon.random> <Pine.LNX.4.33.0112301634510.1011-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0112301634510.1011-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 30, 2001 at 04:35:46PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 04:35:46PM -0800, Linus Torvalds wrote:
> 
> On Mon, 31 Dec 2001, Andrea Arcangeli wrote:
> >
> > actually bh_new is needed also to serialize with the buffercache, a new
> > bh mapped in pagecache must be dropped from the buffercache before we
> > can start using it (unmap_underlying_metadata).
> 
> You're right, although it's something of an optimization (ie we could as
> well just depend on the "mapped" bit and watch it change).

we could even hold the optimization (cache coherency only on new blocks)
by pushing the cache coherency into the lowlevel just like the bh
clearing, but the current buffer_new branch in the library code seems
clean (and potentially a little faster with big softblocksize due the
partial clearing).

Andrea
