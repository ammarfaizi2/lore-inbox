Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292366AbSBBTyT>; Sat, 2 Feb 2002 14:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292369AbSBBTyJ>; Sat, 2 Feb 2002 14:54:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14662 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292367AbSBBTxx>; Sat, 2 Feb 2002 14:53:53 -0500
Date: Sat, 2 Feb 2002 20:54:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Chris Wedgwood <cw@f00f.org>, Steve Lord <lord@sgi.com>,
        Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020202205438.D3807@athlon.random>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234710000.1012674008@tiny>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 01:20:08PM -0500, Chris Mason wrote:
> 
> Ok, the tricky part of direct io on reiserfs is the tails.  But, 
> since direct io isn't allowed on non-page aligned file sizes, we'll
> never have direct io onto a normal file tail.
> 
> < 2.4.18 reiserfs versions allowed expanding truncates to set i_size
> without creating the corresponding metadata, so we still have to deal
> with that.  It means we could have a packed tail on any file size,
> including those bigger than the 16k limit after which we don't create
> tails any more.
> 
> Chris and I had initially decided to unpack the tails on file open
> if O_DIRECT is used, but it seems cleaner to add a 
> reiserfs_get_block_direct_io, and have it return -EINVAL if a read
> went to a tail.  writes that happen to a tail will trigger tail
> conversion.

This is a safe approch (no risk of corruption etc..). However to provide
the same semantics of the other filesystems it would be even better if
we could unpack the tail within reiserfs_get_block_direct_io rather than
returning -EINVAL, but ok, most apps should work fine anyways (and as
worse people can workaround the magic by remounting reiserfs with notail
before writing the data that will need to be handled later via
O_DIRECT).

thanks for the patch,

Andrea
