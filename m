Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbQJ3HYM>; Mon, 30 Oct 2000 02:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbQJ3HYC>; Mon, 30 Oct 2000 02:24:02 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63493 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129129AbQJ3HXl>; Mon, 30 Oct 2000 02:23:41 -0500
Date: Mon, 30 Oct 2000 00:20:19 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030002019.B19136@vger.timpanogas.org>
In-Reply-To: <20001030080858.A32204@gruyere.muc.suse.de> <Pine.LNX.4.21.0010300924140.1270-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010300924140.1270-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 09:26:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 09:26:59AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Andi Kleen wrote:
> 
> > One problem in Linux 2.2 is that kernel threads reload their VM on
> > context switch (that would include the nfsd thread), this should be
> > fixed in 2.4 with lazy mm. Hmm actually it should be only fixed for
> > true kernel threads that have been started with kernel_thread(), the
> > "pseudo kernel threads" like nfsd uses probably do not get that
> > optimization because they don't set their MM to init_mm.
> 
> yes, but for this there is an explicit mechanizm to lazy-MM during lengthy
> system calls, an example is in buffer.c:
> 
>                 user_mm = start_lazy_tlb();
>                 error = sync_old_buffers();
>                 end_lazy_tlb(user_mm);
> 
> > > to get disproportiantely higher in Linux than NetWare 5.x and when it hits
> > > 60% of total clock cycles, Linux starts dropping off.  NetWare 5.x is 1/8 
> > 
> > I think that can be explained by the copying.
> 
> yes. Constant copying contaminates the L1/L2 caches and creates dirty
> cachelines all around the place. Fixed in 2.4 + TUX ;-)
> 

Ingo, we need a build option to completely disable multiple address spaces
for a start, and just map everything to a linear address space.  This 
will eliminate the overhead of the CR3 activity.  The use of segment registers
for copy_to_user, etc. causes segment register reloads, which are very 
heavyweight on Intel.  

Is there an option to map Linux into a flat address space like NetWare so
I can do an apples to apples comparison of raw LAN I/O scaling?   


> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
