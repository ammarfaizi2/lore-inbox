Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277595AbRJHXVu>; Mon, 8 Oct 2001 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJHXVl>; Mon, 8 Oct 2001 19:21:41 -0400
Received: from [207.21.185.24] ([207.21.185.24]:3854 "EHLO smtp.lynuxworks.com")
	by vger.kernel.org with ESMTP id <S277595AbRJHXVa>;
	Mon, 8 Oct 2001 19:21:30 -0400
Message-ID: <3BC23441.1EF944A2@lnxw.com>
Date: Mon, 08 Oct 2001 16:18:25 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: discontig physical memory
In-Reply-To: <3BC0E9FD.4F3921C6@mvista.com>
		<3BC2158E.BE52400D@welho.com>
		<3BC22EA6.696604E7@lnxw.com> <20011008.160528.85686937.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already did that. I fixed MAX_DMA_ADDRESS and the
kernel now reports:

zone(0): 1024 pages
zone(1): 7168 pages	/* this should be 4096 */
...

Which is not true as we have a gap between 4 - 16MB
phys memory. I also played with add_memory_region(),
but the kernel still think we have 32MB ram instead
of 20MB as is the case.

Also it lock solid in __get_free_pages in mem_init()
Probably this is related to zone(1) wrong assumption
right?


best,
Petko



"David S. Miller" wrote:
> 
>    From: Petko Manolov <pmanolov@Lnxw.COM>
>    Date: Mon, 08 Oct 2001 15:54:30 -0700
> 
>    Any ideas how to make lowest 4MB allocatable throu
>    kmalloc(size, GFP_DMA) without breaking the kernel?
> 
> Setup ZONE_DMA correctly at boot time.
> 
> See the code around the free_area_init() call in
> arch/i386/mm/init.c for an example of how to do this.
> Intel does it for the low 16MB, you would just do it
> for the low 4MB.
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com
