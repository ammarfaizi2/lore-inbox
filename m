Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTGKTRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264813AbTGKS54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:57:56 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:59912
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264810AbTGKSZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:25:09 -0400
Date: Fri, 11 Jul 2003 11:39:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, rathamahata@php4.ru,
       linux-kernel@vger.kernel.org
Subject: Re:  Very HIGH File & VM system latencies and system stop responding while extracting big tar  archive file.
Message-ID: <20030711183950.GB976@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Nick Piggin <piggin@cyberone.com.au>, rathamahata@php4.ru,
	linux-kernel@vger.kernel.org
References: <3F0E8A22.6020700@cyberone.com.au> <20030711034510.30065dc2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711034510.30065dc2.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:45:10AM -0700, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> > You're sure 2.5.74 got processes stuck in D? That means its possibly
> >  a driver bug. If you can get 2.5.75 to hang, please also try with
> >  elevator=deadline. Thank you.
> 
> No, this will be the reiserfs bug.

Is this in 2.5.75, or -mm?

(I just compiled vanilla 2.5.75, and I have a reiserfs root partition, so
I'd like to know it I need to patch and recompile)

> 
> --- 25/fs/reiserfs/tail_conversion.c~reiserfs-dirty-memory-fix	2003-07-10 22:22:54.000000000 -0700
> +++ 25-akpm/fs/reiserfs/tail_conversion.c	2003-07-10 22:22:54.000000000 -0700
> @@ -191,7 +191,7 @@ unmap_buffers(struct page *page, loff_t 
>  	bh = next ;
>        } while (bh != head) ;
>        if ( PAGE_SIZE == bh->b_size ) {
> -	ClearPageDirty(page);
> +	clear_page_dirty(page);
>        }
>      }
>    } 
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
