Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbRACUz2>; Wed, 3 Jan 2001 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRACUzJ>; Wed, 3 Jan 2001 15:55:09 -0500
Received: from zeus.kernel.org ([209.10.41.242]:63758 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131165AbRACUXl>;
	Wed, 3 Jan 2001 15:23:41 -0500
Date: Wed, 3 Jan 2001 17:47:39 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <20010103204354.E32185@athlon.random>
Message-ID: <Pine.LNX.4.21.0101031745380.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Andrea Arcangeli wrote:
> On Wed, Jan 03, 2001 at 04:59:16PM -0200, Rik van Riel wrote:
> > I know this probably isn't of any help under very low
> > and very high loads, but it should provide a nice
> > improvement under medium loads...
> 
> It should provide an improvement under high VFS load (lots of
> files lookedup and not kept referenced all the time).

Not really. Under very high VFS loads we'd just scan
through the list twice and free the entries anyway.

The only time when this scanning is an improvement is
when we have something like a "working set" for the
dentry cache *and* the refill/scan rate is constant
enough that that "working set" doesn't get flooded out
by the new dentry pages.

Note that creating a new dentry doesn't set the
referenced bit exactly to avoid this from happening.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
