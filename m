Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313217AbSDTXt4>; Sat, 20 Apr 2002 19:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSDTXtz>; Sat, 20 Apr 2002 19:49:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:24221 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313217AbSDTXtz>;
	Sat, 20 Apr 2002 19:49:55 -0400
Date: Sun, 21 Apr 2002 09:47:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Mel <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc comments patch
Message-ID: <20020420234752.GA26727@krispykreme>
In-Reply-To: <Pine.LNX.4.44.0204201740480.3995-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> + * To give a safety margin, the linear address starts about 8MB after the end
> + * of physical memory at VMALLOC_START. This is to try and catch memory
> + * overruns.

Thats architecture dependent. On ppc64 for example the kernel text
starts at 0xC000000000000000 and the vmalloc region starts at
0xD000000000000000, 2^60 bits apart.

> +		/* The page table is unlocked because we don't need to traverse
> +		 * the page tables while a page is been allocated. As
> +		 * alloc_page could block for a long time, let go the lock
> +		 */
>  		spin_unlock(&init_mm.page_table_lock);
>  		page = alloc_page(gfp_mask);
>  		spin_lock(&init_mm.page_table_lock);

Since alloc_page can sleep we must drop the spinlock.

Anton
