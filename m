Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSHDNTC>; Sun, 4 Aug 2002 09:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSHDNTC>; Sun, 4 Aug 2002 09:19:02 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34317 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314553AbSHDNTB>;
	Sun, 4 Aug 2002 09:19:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 make allmodconfig - undefined symbols 
In-reply-to: Your message of "Sun, 04 Aug 2002 14:35:13 +0200."
             <20020804123513.GC13316@alpha.home.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Aug 2002 23:22:24 +1000
Message-ID: <1876.1028467344@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002 14:35:13 +0200, 
Willy Tarreau <willy@w.ods.org> wrote:
>On Sun, Aug 04, 2002 at 08:13:20PM +1000, Keith Owens wrote:
>> 2.4.19 make allmodconfig.  Besides the perennial drivers/net/wan/comx.o
>> wanting proc_get_inode, there was only one undefined symbol.  In the
>> extremely unlikely event that binfmt_elf is a module (how do you load
>> modules when binfmt_elf is a module?), smp_num_siblings is unresolved.
>
>I also get an unresolved reference to __io_virt_debug in misc.o:puts()
>when building bzImage. If you don't get it, it means that my tree is
>corrupted.

Neither.  It is a problem with CONFIG_DEBUG_IOVIRT which allmod and
allyesconfig turn on.  My builds stop at vmlinux and do not build
bzImage so I did not detect this problem.  The outb_p calls in misc.c
need fixing for CONFIG_DEBUG_IOVIRT=y, or force CONFIG_DEBUG_IOVIRT=n.

Interesting that the comment for CONFIG_DEBUG_IOVIRT says "Temporary
debugging check to catch old code using unmapped ISA addresses. Will be
removed in 2.4".

