Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSG0RLo>; Sat, 27 Jul 2002 13:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSG0RLo>; Sat, 27 Jul 2002 13:11:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318795AbSG0RLn>;
	Sat, 27 Jul 2002 13:11:43 -0400
Message-ID: <3D42D706.9899A4A0@zip.com.au>
Date: Sat, 27 Jul 2002 10:23:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <E17YRp5-0006H6-00@storm.christs.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Linus,
> 
> This patch introduces 64-bit versions of PAGE_{CACHE_,}MASK and
> PAGE_{CACHE_,}ALIGN:
>         PAGE_{CACHE_,}MASK_LL and PAGE_{CACHE_,}ALIGN_LL.
> 
> These are needed when 64-bit values are worked with on 32-bit
> architectures, otherwise the high 32-bits are destroyed.
> 
> ...
>  #define PAGE_SIZE      (1UL << PAGE_SHIFT)
>  #define PAGE_MASK      (~(PAGE_SIZE-1))
> +#define PAGE_MASK_LL   (~(u64)(PAGE_SIZE-1))

The problem here is that we've explicitly forced the
PAGE_foo type to unsigned long.

If we instead take the "UL" out of PAGE_SIZE altogether,
the compiler can then promote the type of PAGE_SIZE and PAGE_MASK
to the widest type being used in the expression (ie: long long)
and everything should work.

Which seems to be a much cleaner solution, if it works.

Will it work?

-
