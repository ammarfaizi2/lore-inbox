Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281240AbRKEQyK>; Mon, 5 Nov 2001 11:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRKEQyE>; Mon, 5 Nov 2001 11:54:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34084 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281234AbRKEQxt>; Mon, 5 Nov 2001 11:53:49 -0500
Date: Mon, 5 Nov 2001 17:53:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification
Message-ID: <20011105175337.D18319@athlon.random>
In-Reply-To: <E160aCK-0001Fs-00@localhost> <200111050552.AAA06451@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200111050552.AAA06451@ccure.karaya.com>; from jdike@karaya.com on Mon, Nov 05, 2001 at 12:52:51AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 12:52:51AM -0500, Jeff Dike wrote:
> bodnar42@phalynx.dhs.org said:
> > >  Mounting it synchronous will  disable caching in the VM.  
> > Who told
> > you that? Synchronous mounting turns off write buffering. Even with
> > "-o sync" writes will still end up in the page cache, they'll just be
> > commited immediately.
> 
> Ummm, how about O_DIRECT instead of O_SYNC (or maybe as well, my googling
> hasn't been clear on whether O_DIRECT bypasses the cache on writes as well)?

O_DIRECT is synchronous but only in terms of data, if you want the
metadata to be synchronous as well you need to open with
O_SYNC|O_DIRECT, and even in such case all the metadata reads will came
from cache.

For example if you only care about being able to reach the data after a
crash (not about the inode info) in a file with all its logical blocks
mapped to physical blcoks (no holes) and then you fsync, later you can
as well avoid O_SYNC and you still don't risk to lose data after a crash
because the block mappings never changes, if you grow/shrink the file
you definitely need O_SYNC to be sure the O_DIRECT data is still there
after a crash instead.

Andrea
