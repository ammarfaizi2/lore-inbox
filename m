Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3HRc>; Mon, 30 Oct 2000 02:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQJ3HRX>; Mon, 30 Oct 2000 02:17:23 -0500
Received: from chiara.elte.hu ([157.181.150.200]:36870 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129053AbQJ3HRM>;
	Mon, 30 Oct 2000 02:17:12 -0500
Date: Mon, 30 Oct 2000 09:26:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Andi Kleen <ak@suse.de>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030080858.A32204@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0010300924140.1270-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Andi Kleen wrote:

> One problem in Linux 2.2 is that kernel threads reload their VM on
> context switch (that would include the nfsd thread), this should be
> fixed in 2.4 with lazy mm. Hmm actually it should be only fixed for
> true kernel threads that have been started with kernel_thread(), the
> "pseudo kernel threads" like nfsd uses probably do not get that
> optimization because they don't set their MM to init_mm.

yes, but for this there is an explicit mechanizm to lazy-MM during lengthy
system calls, an example is in buffer.c:

                user_mm = start_lazy_tlb();
                error = sync_old_buffers();
                end_lazy_tlb(user_mm);

> > to get disproportiantely higher in Linux than NetWare 5.x and when it hits
> > 60% of total clock cycles, Linux starts dropping off.  NetWare 5.x is 1/8 
> 
> I think that can be explained by the copying.

yes. Constant copying contaminates the L1/L2 caches and creates dirty
cachelines all around the place. Fixed in 2.4 + TUX ;-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
