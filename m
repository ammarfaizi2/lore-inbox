Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316854AbSFKGgK>; Tue, 11 Jun 2002 02:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSFKGgJ>; Tue, 11 Jun 2002 02:36:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316854AbSFKGgI>;
	Tue, 11 Jun 2002 02:36:08 -0400
Message-ID: <3D059B32.8F3F13AC@zip.com.au>
Date: Mon, 10 Jun 2002 23:39:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <10339.1023773628@kao2.melbourne.sgi.com> <3D0595F7.A21AE62B@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> --- 2.4.19-pre10/mm/vmscan.c~mmap-mtime Mon Jun 10 23:00:28 2002
> +++ 2.4.19-pre10-akpm/mm/vmscan.c       Mon Jun 10 23:04:34 2002
> @@ -405,6 +405,9 @@ static int shrink_cache(int nr_pages, zo
>                                 page_cache_get(page);
>                                 spin_unlock(&pagemap_lru_lock);
> 
> +                               if (!PageSwapCache(page))
> +                                       update_mtime(page->mapping->host);
> +
>                                 writepage(page);
>                                 page_cache_release(page);
> 

Actually, calling mark_inode_dirty here could well cause
the complex filesystems to explode under high VM pressure.

Probably, we should only touch the file inside msync()
(in 2.4 kernels, at least).

-
