Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSIEIZk>; Thu, 5 Sep 2002 04:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSIEIZk>; Thu, 5 Sep 2002 04:25:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28942 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317302AbSIEIZj>;
	Thu, 5 Sep 2002 04:25:39 -0400
Message-ID: <3D77190C.F4562547@zip.com.au>
Date: Thu, 05 Sep 2002 01:42:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] __write_lock_failed() oops
References: <20020905080310.GF18800@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> After running 64 simultaneous tiobench 256's a few times,
> I get the following oops, which I've been seeing intermittently
> for a number of 2.5.x releases (since 2.5.x booted on NUMA-Q):
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xc0106693 in __write_lock_failed () at semaphore.c:176
> 176     semaphore.c: No such file or directory.
>         in semaphore.c
> 
> for some reason, I'm unable to get a backtrace:
> 
> (gdb) bt
> #0  0xc0106693 in __write_lock_failed () at semaphore.c:176
> Reply contains invalid hex digit 36
> 

That's all the assembly hacks in the rwlock code not having proper
stack frames.  You may have to ksymoops it.

At a guess: use-after-free bug against an address_space.  You may
be able to catch it with slab poisoning.
