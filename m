Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281771AbRKQPzR>; Sat, 17 Nov 2001 10:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281769AbRKQPzH>; Sat, 17 Nov 2001 10:55:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27712 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281768AbRKQPyw>; Sat, 17 Nov 2001 10:54:52 -0500
Date: Sat, 17 Nov 2001 16:54:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
Message-ID: <20011117165441.S1381@athlon.random>
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <20011109033851.A15099@asooo.flowerfire.com> <20011115184036.D1381@athlon.random> <3BF3FFF4.A4768C43@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3BF3FFF4.A4768C43@redhat.com>; from arjanv@redhat.com on Thu, Nov 15, 2001 at 05:48:36PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ sorry for the delay ]

On Thu, Nov 15, 2001 at 05:48:36PM +0000, Arjan van de Ven wrote:
> Andrea Arcangeli wrote:
> 
> > loop that can trigger with the -ac VM when all the ZONE_DMA is
> > unfreeable (now fixed in mainline with classzone) have nothing to do
> 
> Ok I think I've misunderstood classzone then.
> As I understand it, it prevents looping in ZONE_NORMAL when ZONE_DMA has
> memory free,
> and looping in ZONE_HIGHMEM if ZONE_NORMAL or ZONE_DMA have memory free.

correct.

> Can you please explain how it also solves the ZONE_DMA problem ? 

It also solves the ZONE_DMA problem with the ->need_balance trigger in
combination with the classzone logic.

With classzone in combination with the need_balance kswapd will never
ever waste time trying to balance a never used classzone. 

If all your hardware is PCI nobody will make an allocation from the
ZONE_DMA classzone and so kswapd will never loop on the ZONE_DMA, as
instead can happen with -ac as soon as the ZONE_DMA becomes unfreeable
and under the low watermark (and "unfreeable" of course also means all
anon not locked memory but no swap installed in the machine).

Andrea
