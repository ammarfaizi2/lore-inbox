Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLAWAE>; Fri, 1 Dec 2000 17:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbQLAV7x>; Fri, 1 Dec 2000 16:59:53 -0500
Received: from k2.llnl.gov ([134.9.1.1]:29572 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S129449AbQLAV7o>;
	Fri, 1 Dec 2000 16:59:44 -0500
Message-ID: <3A27D1C9.95F63366@scs.ch>
Date: Fri, 01 Dec 2000 08:28:57 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Richard Henderson <rth@twiddle.net>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org
Subject: Re: Alpha SMP problem
In-Reply-To: <3A08455E.F3583D1B@scs.ch> <20001107225749.B26542@twiddle.net> <20001124044615.A6807@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It's great that you could fix that! 

Is there any chance that we will see this patch as well as your other
Alpha patches included in future 2.2.X and 2.4.X releases?

Thanks,

Reto

Andrea Arcangeli wrote:
> 
> There were a few SMP races that could trigger only using threads:
> 
> 1) flush_tlb_other could happen after we read the mm->context and we could
>    miss a tlb flush
> 2) flush_tlb_current could bump up the asn of the current cpu and in turn
>    change the asn version after we acquired a new context leading to
>    an alias between our asn and a later one
> 3) a PAL_swpctx can't be done in the middle of alpha_switch_to
> 
> ppc/sparc64 may have similar issues and I didn't checked them (from a fast read
> it looks like sparc64 is just safe but I don't know the sparc hardware
> well enough to be sure).
> 
> I also noticed the horrible implementation of ASN in SMP so while I was
> there I rewrote it.
> 
> The rewrote is based on the fact that mm->context makes no sense. It must be an
> array of mm->context[NR_CPUS]. Almost certainly mips wants an array of NR_CPUS
> too. Anyways for mips it's not a big deal since SMP isn't supported in 2.2.x ;).
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
