Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276826AbRJ2RQC>; Mon, 29 Oct 2001 12:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJ2RPp>; Mon, 29 Oct 2001 12:15:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24327 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276641AbRJ2RP1>; Mon, 29 Oct 2001 12:15:27 -0500
Subject: Re: Pls apply this spinlock patch to the kernel
To: jdoelle@de.ibm.com (Juergen Doelle)
Date: Mon, 29 Oct 2001 17:22:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BDD8241.8002B946@de.ibm.com> from "Juergen Doelle" at Oct 29, 2001 05:22:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yG7P-0003Kb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and occupies the full cacheline. The five hottest spinlocks for this 
> work load are set to that type (kmap_lock, lru_list_lock, 
> pagecache_lock, kernel_flag, pagemap_lru_lock)  The change is done in 
> the common code, except for the kernel_flag. 

That seems overkill. What you are saying is that static spinlocks need
to be declared in some cases to be followed by padding.

> +static spinlock_cacheline_t lru_list_lock_cacheline = {SPIN_LOCK_UNLOCKED};
> +#define lru_list_lock  lru_list_lock_cacheline.lock

So why not just add a macro for aligning then do

spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
cache_line_pad;

where cache_line_pad is an asm(".align") - I would assume that is
sufficient - Linus ?

Alan
