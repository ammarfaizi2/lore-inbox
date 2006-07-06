Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWGFJ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWGFJ23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWGFJ22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:28:28 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:48694 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S965174AbWGFJ22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:28:28 -0400
Date: Thu, 6 Jul 2006 11:27:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060706092703.GB9416@osiris.boeblingen.de.ibm.com>
References: <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706081639.GA24179@elte.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: spinlocks: remove 'volatile'
> From: Ingo Molnar <mingo@elte.hu>
> 
> remove 'volatile' from the spinlock types, it causes gcc to
> generate really bad code. (and it's pointless anyway)
> 
> this reduces the non-debug SMP kernel's size by 0.2% (!).
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  include/asm-i386/spinlock_types.h   |    4 ++--
>  include/asm-x86_64/spinlock_types.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux/include/asm-i386/spinlock_types.h
> ===================================================================
> --- linux.orig/include/asm-i386/spinlock_types.h
> +++ linux/include/asm-i386/spinlock_types.h
> @@ -6,13 +6,13 @@
>  #endif
>  
>  typedef struct {
> -	volatile unsigned int slock;
> +	unsigned int slock;
>  } raw_spinlock_t;
>  
>  #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
>  
>  typedef struct {
> -	volatile unsigned int lock;
> +	unsigned int lock;
>  } raw_rwlock_t;

Shouldn't the __raw_read_can_lock and __raw_write_can_lock macros be changed too, just
to make sure the value gets read every single time if it's used in a loop?
Just like the __raw_spin_is_locked already has a (volatile signed char * cast)?
