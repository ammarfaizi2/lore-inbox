Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289111AbSAGEcH>; Sun, 6 Jan 2002 23:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSAGEb6>; Sun, 6 Jan 2002 23:31:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24929 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289111AbSAGEbn>; Sun, 6 Jan 2002 23:31:43 -0500
Date: Mon, 7 Jan 2002 05:31:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern el panic woes
Message-ID: <20020107053154.M1561@athlon.random>
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>, <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>; <20011231010537.K1356@athlon.random> <3C36E6E8.628BF0BF@zip.com.au>, <3C36E6E8.628BF0BF@zip.com.au>; <20020107040828.H1561@athlon.random> <3C391AB1.21F8F48C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C391AB1.21F8F48C@zip.com.au>; from akpm@zip.com.au on Sun, Jan 06, 2002 at 07:49:05PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 07:49:05PM -0800, Andrew Morton wrote:
> which is probably better than just ignoring it as we do at present.
> I'll leave it as shown above unless there be objections.

by design defintely better as shown than mainline. a MS_ASYNC currently
doesn't work because the VM will never care flushing dirty mapped pages,
first it will have to unmap them that will never happen unless there's
low-on mem condition, while the filemap_fdatasync will ensure those
pages will hit the disk asynchronously in a sane amount of time
(depending on kupdate). MS_ASYNC manpage says an update is scheduled,
currently it will instead never happen for example if the machine is
idle and there's no vm swap etc... your change will fix it.

> I'll wait until Marcelo looks like he has his head above water and
> then send out the final version of the ramdisk, truncate and
> fsync/msync patches, cc'ed to yourself and lkml.

I'd like to release a new -aa within tomorrow afternoon with every known
bug discussed in this thread fixed, so then I can concentrate back on
another thing, so I'd like to get those new versions ASAP :)

for the buffer_new thing I guess it's simpler to just change the
semantics of it rather than allocating ram on the stack.

Andrea
