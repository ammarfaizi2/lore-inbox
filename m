Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUJMBTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUJMBTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUJMBTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:19:30 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8874 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268170AbUJMBTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:19:22 -0400
Date: Wed, 13 Oct 2004 10:24:59 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: bug in 2.6.9-rc4-mm1 ia64/mm/init.c
In-reply-to: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
To: akepner@sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       jbarnes@sgi.com
Message-id: <416C83EB.1090608@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

akepner@sgi.com wrote:
> Hi Folks; 
> 
> Tried a kernel built with akpm's 2.6.9-rc4-mm1 patch today (using 
> a default sn2 .config file.) It crashes on boot with:
> 
> ....
> SGI SAL version 3.40
> Virtual mem_map starts at 0xa0007ffe85938000
> Unable to handle kernel paging request at virtual address a0007ffeaf970000
> swapper[0]: Oops 8813272891392 [1]
> Modules linked in:
<snip>
> I traced this down to a recent patch (see 
> http://marc.theaimsgroup.com/?l=linux-mm&m=109723728329408&w=2) 
> which contains:
> 
> diff -puN arch/ia64/mm/init.c~ia64_fix arch/ia64/mm/init.c
> --- test-kernel/arch/ia64/mm/init.c~ia64_fix    2004-10-08 
> 18:29:20.510992392 +0900
> +++ test-kernel-kamezawa/arch/ia64/mm/init.c    2004-10-08 
> 18:29:20.515991632 +0900
> @@ -410,7 +410,8 @@ virtual_memmap_init (u64 start, u64 end,
>         struct page *map_start, *map_end;
> 
>         args = (struct memmap_init_callback_data *) arg;
> -
> +       start = GRANULEROUNDDOWN(start);
> +       end = GRANULEROUNDUP(end);
>         map_start = vmem_map + (__pa(start) >> PAGE_SHIFT);
>         map_end   = vmem_map + (__pa(end) >> PAGE_SHIFT);
> 
> 
> Merely commenting out the new lines containting GRANULEROUNDDOWN, and 
> GRANULEROUNDUP allowed the system to boot and me to finish the testing 
> I needed to do. 
> 
> Looks like the above patch needs to be revised. I could test it if 
> necessary. Please email me directly as I'm not subscribed to lkml 
> or linux-ia64.
> 
Hmm.. I added above 2 lines for making vmemmap to be aligned with ia64's GRANULE.
But it looks troublesome here, revising it will be needed currently.
I'd like to check my codes again and fix it.


Kame <kamezawa.hiroyu@jp.fujitsu.com>

