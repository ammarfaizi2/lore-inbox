Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131125AbRADQTZ>; Thu, 4 Jan 2001 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131329AbRADQTP>; Thu, 4 Jan 2001 11:19:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44909 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131125AbRADQTC>; Thu, 4 Jan 2001 11:19:02 -0500
Date: Thu, 4 Jan 2001 17:18:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
Message-ID: <20010104171807.B1507@athlon.random>
In-Reply-To: <20010104013201.B6256@athlon.random> <Pine.LNX.4.21.0101041255320.1188-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101041255320.1188-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Jan 04, 2001 at 01:00:28PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 01:00:28PM -0200, Rik van Riel wrote:
> Other tasks tend not to stress the dcache like updatedb does,
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> leading to the effect that updatedb can "flush out" the other
> cached values faster than the other processes reference them.
> 
> This is something no amount of 2nd chance replacement or even
> aging can prevent.

Your arguments are senseless.

The dcache aging is mostly useful with _high_ VFS load like updatedb in
background. The logic is the same of the VM aging (ask yourself when the VM
aging is most useful: when there's high VM load, like a `cp /dev/zero .` in
background, the updatedb is the equivalent of `cp /dev/zero .` but for the
dcache).  Without the aging the "referenced" cache would be thrown away as well
with the rest of the cache pollution, while with the aging the "referenced"
cache will have a chance to remain in cache. This is true for both VM cache and
dcache.  The higher the load, the more times your working set would been thrown
away without the aging, so the higher improvement you get thanks to the aging.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
