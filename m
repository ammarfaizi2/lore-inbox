Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSEWMJm>; Thu, 23 May 2002 08:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316463AbSEWMJl>; Thu, 23 May 2002 08:09:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:33147 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316456AbSEWMJk>; Thu, 23 May 2002 08:09:40 -0400
Date: Thu, 23 May 2002 13:12:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Mike Black <mblack@csihq.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: page_alloc bug in 2.4.17-pre8
In-Reply-To: <00ec01c2024f$9809db90$f6de11cc@black>
Message-ID: <Pine.LNX.4.21.0205231301100.1049-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Mike Black wrote:
> This machine had been up for 2-1/2 days and had run this backup (afio) twice successfully.
> 
> Here's line 108 of page_alloc.c:
>         if (PageLRU(page))
>                 BUG();
> 
> Hopefully this doesn't indicate a CPU problem?  The power supply on this thing blew Saturday but has run OK until now.
> 
> May 22 00:51:01 picard kernel: kernel BUG at page_alloc.c:108!
> May 22 00:51:01 picard kernel: invalid operand: 0000
> May 22 00:51:01 picard kernel: CPU:    1
> May 22 00:51:01 picard kernel: EIP:    0010:[swap_duplicate+82/192]    Not tainted

There were quite a number of reports of those PageLRU BUGs on 2.4.17.
No idea what fixed them, but 2.4.18 (and 2.4.19-pre) has seemed free
of them (Ben LaHaise made a plausible change, but closer analysis
suggested it couldn't really be the fix).  Suggest you upgrade.

Your oops report, by the way, must have been using the wrong System.map:
page_alloc.c:108 is in __free_pages_ok(), swap_duplicate() is over in
swapfile.c.  But no matter, page_alloc.c:108 identifies it well enough.

Hugh 

