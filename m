Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281810AbRKVXHu>; Thu, 22 Nov 2001 18:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281811AbRKVXHl>; Thu, 22 Nov 2001 18:07:41 -0500
Received: from colorfullife.com ([216.156.138.34]:43787 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281810AbRKVXHa>;
	Thu, 22 Nov 2001 18:07:30 -0500
Message-ID: <3BFD852C.C4CDC39F@colorfullife.com>
Date: Fri, 23 Nov 2001 00:07:24 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re:[RFC][PATCH] flush_icache_user_range
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> The patch below changes access_one_page in kernel/ptrace.c to use a
> new function, flush_icache_user_range, instead of flush_icache_page as
> at present.  The reason for making this change is that
> flush_icache_page is also called in do_no_page and do_swap_page, where
> it does a fundamentally different job.  Decoupling the two makes it
> possible to improve performance, because we can make flush_icache_page
> do the flush only when needed.
> 

Could you also check map_user_kiobuf()?

map_user_kiobuf() calls flush_dcache_page() - if I understand
cachetlb.txt correctly that function is only suitable for dcache/mmap
cache coherency, it's not suitable for anon pages. But map_user_kiobuf()
must support arbitrary pages.

And unmap_kiobuf doesn't contain a single cache flush.

--
	Manfred
