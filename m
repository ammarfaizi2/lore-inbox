Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbRLaA2x>; Sun, 30 Dec 2001 19:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285842AbRLaA2n>; Sun, 30 Dec 2001 19:28:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23624 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285783AbRLaA2f>; Sun, 30 Dec 2001 19:28:35 -0500
Date: Mon, 31 Dec 2001 01:28:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrdkern el panic woes
Message-ID: <20011231012825.P1356@athlon.random>
In-Reply-To: <3C2EC95A.79868A85@zip.com.au> <Pine.LNX.4.33.0112300918430.4869-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0112300918430.4869-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 30, 2001 at 09:40:11AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 09:40:11AM -0800, Linus Torvalds wrote:
> 
> On Sat, 29 Dec 2001, Andrew Morton wrote:
> >
> > And what should we do with BH_New?
> 
> The only point of BH_New was to not need this horror in three different
> places, and have the BH_New bit as a way of saying "this buffer has no
> contents yet", and fill it with zeroes in just _one_ place (ie the
> readpage path).

actually bh_new is needed also to serialize with the buffercache, a new
bh mapped in pagecache must be dropped from the buffercache before we
can start using it (unmap_underlying_metadata).

so at least for 2.4 I wouldn't drop it :)

> 
> However, I don't think it was ever implemented, so if you prefer the
> straightforward (brute-force but ugly) approach, just get rid of it.
> 
> 			Linus


Andrea
