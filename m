Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEINBa>; Thu, 9 May 2002 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSEINBa>; Thu, 9 May 2002 09:01:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16247 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310206AbSEINB2>; Thu, 9 May 2002 09:01:28 -0400
Date: Thu, 9 May 2002 15:01:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
Message-ID: <20020509150146.O12382@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0205091252350.1205-100000@localhost.localdomain> <20020509.045643.27562731.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 04:56:43AM -0700, David S. Miller wrote:
>    From: Hugh Dickins <hugh@veritas.com>
>    Date: Thu, 9 May 2002 13:03:52 +0100 (BST)
> 
>    filemap_nopage and shmem_nopage do flush_page_to_ram before returning
>    page, but do_no_page also does flush_page_to_ram on any page it slots
>    into the user address space.  It's memory.c's business, remove it from
>    shmem and filemap (and cut outdated comment from when filemap copied).
>    
> Wrong, consider the case where we do early COW in do_no_page, you miss
> a flush on the new-new page.

so you mean we need a flush_page_to_ram also before the
copy_user_highpage to be sure we copy uptodate contents of the
pagecache? (possibly mapped writeable elsewhere in the user address
space?)

If not then I don't see how non-flushed pagecache can be mapped into
user address space.

Andrea
