Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSCRUv2>; Mon, 18 Mar 2002 15:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292941AbSCRUvS>; Mon, 18 Mar 2002 15:51:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:53765 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S292857AbSCRUvO>; Mon, 18 Mar 2002 15:51:14 -0500
Message-ID: <3C9652E8.67560587@zip.com.au>
Date: Mon, 18 Mar 2002 12:49:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
In-Reply-To: <3C964AA3.4B85EA0B@zip.com.au> <15780000.1016482936@w-hlinder.des>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> 
> --On Monday, March 18, 2002 12:14:27 -0800 Andrew Morton <akpm@zip.com.au> wrote:
> 
> > One other possible explanation is to do with radix-tree pagecache.
> > It has to allocate memory to add nodes to the tree.  When these
> > allocations start failing due to out-of-memory, the VM will keep
> > on calling swap_out() a trillion times without noticing that it
> > didn't work out.  But if this happened, yo would have seen a huge
> > number of "0-order allocation failed" messages.
> 
>         Yes, I did see a huge number of those messages.

OK.  Probably it would have eventually recovered, because there
would have been *some* I/O queued up somewhere.  Of course, it
would recover a damn sight faster if I hadn't added those
printk's in the page allocator :)

>         It also died
>         on 2.5.6 clean though. I chalked it up to 2.5 instability.

mm.  2.5.6 is stable in my testing.  PIIX4 IDE and aic7xxx SCSI.
So maybe a driver problem, maybe a highmem problem?

>         Will test again when things calm down. Any chance you will
>         backport to 2.4?

I don't really plan to do that.  There's still quite a lot more stuff
needs doing, and it'll end up a huuuuge patch.  Plus a fair bit of
the value isn't there, because 2.4 doesn't have BIOs.

-
