Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTKBHRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTKBHRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:17:43 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:60165 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261509AbTKBHRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:17:42 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton), Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Organization: Core
In-Reply-To: <20031029141931.6c4ebdb5.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
Date: Sun, 02 Nov 2003 18:17:27 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> 
>> (These buffers are there because reiserfs first reads that offset (in bytes)
>> with whatever current blocksize is, except they should have been invalidated of
>> course).
>> Even if invalidate_bdev() -> invalidate_inode_pages() have not cleaned
>> everything, truncate_inode_pages() should have done this.
> 
> yup.

The person who had the problem is actually using the Debian tree which
carried over a patch from 2.4 that removed the truncate_inode_pages
call in set_blocksize.  So I appologise for the noise.

However, may I ask what is preventing us from achieving the goal that
the page cache backed buffer heads can be resized without throwing away
the pages?

In particular, aside from the buffer_error() call, is there any problems
with not throwing the pages away upon a resize?

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
