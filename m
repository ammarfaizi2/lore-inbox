Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVC1M4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVC1M4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVC1M4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:56:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18696 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261693AbVC1M4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:56:08 -0500
Date: Mon, 28 Mar 2005 14:56:00 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Turbo Fredriksson <turbo@bayour.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile fails on SPARC64 - include/linux/sched.h:1171: request for member `break_lock' in something not a structure or union
Message-ID: <20050328125600.GT30052@alpha.home.local>
References: <87d5tk2b9d.fsf@pumba.bayour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5tk2b9d.fsf@pumba.bayour.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should work if you disable PREEMPT.

Willy

On Mon, Mar 28, 2005 at 02:41:34PM +0200, Turbo Fredriksson wrote:
> Tried 2.6.11.6, 2.6.11.6-bk1 and 2.6.12-rc1.
> 
> ----- s n i p -----
> CHROOT Aurora/Woody-devel# make
>   CHK     include/linux/version.h
>   CC      init/main.o
> In file included from include/linux/module.h:10,
>                  from init/main.c:16:
> include/linux/sched.h: In function `lock_need_resched':
> include/linux/sched.h:1171: request for member `break_lock' in something not a structure or union
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> ----- s n i p -----
> 
> rgrep'ing in include/ shows that it's defined in all
> but 'include/asm-sparc64/spinlock.h':
> 
> ----- s n i p -----
> CHROOT Aurora/Woody-devel# rgrep break_lock include | sort | uniq
> include/asm-alpha/spinlock.h:   unsigned int break_lock;
> include/asm-arm/spinlock.h:     unsigned int break_lock;
> include/asm-i386/spinlock.h:    unsigned int break_lock;
> include/asm-ia64/spinlock.h:    unsigned int break_lock;
> include/asm-m32r/spinlock.h:    unsigned int break_lock;
> include/asm-mips/spinlock.h:    unsigned int break_lock;
> include/asm-parisc/spinlock.h:  unsigned int break_lock;
> include/asm-parisc/system.h:    unsigned int break_lock;
> include/asm-ppc/spinlock.h:     unsigned int break_lock;
> include/asm-ppc64/spinlock.h:   unsigned int break_lock;
> include/asm-s390/spinlock.h:    unsigned int break_lock;
> include/asm-sh/spinlock.h:      unsigned int break_lock;
> include/asm-sparc/spinlock.h:   unsigned int break_lock;
> include/asm-x86_64/spinlock.h:  unsigned int break_lock;
> include/linux/sched.h:# define need_lockbreak(lock) ((lock)->break_lock)
> ----- s n i p -----
> 
> Kernel config can be found at http://www.bayour.com/config-2.6.12-rc1.txt.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
