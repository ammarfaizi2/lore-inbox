Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRACVM7>; Wed, 3 Jan 2001 16:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRACVMt>; Wed, 3 Jan 2001 16:12:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35406 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130072AbRACVMj>; Wed, 3 Jan 2001 16:12:39 -0500
Date: Wed, 3 Jan 2001 22:12:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
Message-ID: <20010103221221.I32185@athlon.random>
In-Reply-To: <20010103204354.E32185@athlon.random> <Pine.LNX.4.21.0101031745380.1403-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101031745380.1403-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Jan 03, 2001 at 05:47:39PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 05:47:39PM -0200, Rik van Riel wrote:
> Not really. Under very high VFS loads we'd just scan
> through the list twice and free the entries anyway.

You're obviously wrong.

The higher was the load, the faster your working set was getting dropped from
the dcache. (with the patch the working set will have a chance to remains in
cache also with polluting going on instead, that's the whole point of aging:
to find out if something is worthwhile to keep in cache or not)

So the higher the VFS load definitely the higher improvement you will get.

The example with only pollution in the cache doesn't make sense, if you want to
optimize that case then remove the dcache in first place since it's only
overhead for such case.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
