Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbRE3Hav>; Wed, 30 May 2001 03:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262640AbRE3Hal>; Wed, 30 May 2001 03:30:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11222 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262633AbRE3HaZ>;
	Wed, 30 May 2001 03:30:25 -0400
Date: Wed, 30 May 2001 03:30:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Gergely Tamas <dice@mfa.kfki.hu>, linux-kernel@vger.kernel.org
Subject: Re: OOPS with 2.4.5 [kernel BUG at inode.c:486]
In-Reply-To: <shssnhn47tl.fsf@charged.uio.no>
Message-ID: <Pine.GSO.4.21.0105300328230.12645-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 May 2001, Trond Myklebust wrote:

> The reason we haven't seen this before is that we had 'force_delete'
> that would always set i_nlink = 0. Unfortunately force_delete is toxic
> to mmap(), as it will discard any dirty pages rather than flushing
> them to storage, so it was removed in the 2.4.5-pre series...
> 
> Al: Is there any reason why the cases
> 
>   if (!inode->i_nlink)
> 
> and the 'magic nfs path' should be treated differently? Personally,
> I'd rather prefer to merge the 2.

I don't think that it's a good idea. Why not fry the cache explicitly
when you invalidate the inode?

