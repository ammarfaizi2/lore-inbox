Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317004AbSEWU5M>; Thu, 23 May 2002 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSEWU5L>; Thu, 23 May 2002 16:57:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11280 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317004AbSEWU5K>; Thu, 23 May 2002 16:57:10 -0400
Message-ID: <3CED48C8.80406@evision-ventures.com>
Date: Thu, 23 May 2002 21:53:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
In-Reply-To: <20020523195757.GW21164@dualathlon.random> <Pine.LNX.4.33.0205231300530.4338-100000@penguin.transmeta.com> <20020523204101.GY21164@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andrea Arcangeli napisa?:

> What I don't understand is how the BTB can invoke random userspace tlb
> fills when we are running do_munmap, there's no point at all in doing
> that. If the cpu see a read of an user address after invalidate_tlb,
> the tlb must not be started because it's before an invalidate_tlb.
> 
> And if it's true not even irq are barriers for the tlb fills invoked by
> this p4-BTB thing, so if leave_mm is really necessary, then 2.5 is as
> well wrong in UP, because the pagetable can be scribbled by irqs in a UP
> machine, and so the fastmode must go away even in 1 cpu systems.

I for one would be really really surprised if the execution of an
interrupt isn't treating the BTB specially. If one reads
about CPU validation "exception handling" aka irq handling
is something that is paramount there. Hard to beleve they
would implement software IRQ commands by not just toggling the
IRQ input line of the chip themself. This safes testing.
But it may be as well indeed just "accidental" that system
call gates are implemented on recent ia32 systems by an op code
which belongs to the IRQ handling family...

