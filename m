Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313084AbSDLANX>; Thu, 11 Apr 2002 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSDLANW>; Thu, 11 Apr 2002 20:13:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313084AbSDLANW>; Thu, 11 Apr 2002 20:13:22 -0400
Date: Thu, 11 Apr 2002 17:12:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andreas Dilger <adilger@clusterfs.com>, Alexander Viro <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB612EF.A20AA3C9@zip.com.au>
Message-ID: <Pine.LNX.4.33.0204111708550.1403-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Apr 2002, Andrew Morton wrote:
>
> One problem with having a bitmap at page->private is that
> we don't know how big the blocks are.  You could have
> 0x00000003 but you don't know if that's two 1k blocks
> or two 2k blocks.  Not hard to work around I guess.

I think the more fundamental problem is that we want to have a generic
mechanism, and for other filesystems the writeback data is a lot different
from "this sector is dirty".

That, in the end, convinced me that there's no point to trying to keep
per-sector dirty data around in a generic formal - it just wasn't generic
enough.

So now it's up to the writeback mechanism itself to keep track of which
part of the page is dirty, be it with the NFS kind of "nfs_page"
structures, or with things like "struct buffer_head", and I certainly no
longer have any plans at all to try to keep anything like a "dirty bitmap"
in the generic data structures.

		Linus

