Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSEINQo>; Thu, 9 May 2002 09:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSEINQn>; Thu, 9 May 2002 09:16:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5563 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311121AbSEINQm>; Thu, 9 May 2002 09:16:42 -0400
Date: Thu, 9 May 2002 14:18:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
In-Reply-To: <20020509.045643.27562731.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0205091416360.10889-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, David S. Miller wrote:
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

Of course we do, and then we don't map it into user address space;
if it ever gets mapped into user address space later, do_no_page
does the flush_page_to_ram then.

Hugh

