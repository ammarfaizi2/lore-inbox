Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132650AbRAJAFA>; Tue, 9 Jan 2001 19:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRAJAEu>; Tue, 9 Jan 2001 19:04:50 -0500
Received: from ns.sysgo.de ([213.68.67.98]:3576 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S130157AbRAJAEl>;
	Tue, 9 Jan 2001 19:04:41 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: <mingo@elte.hu>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Date: Wed, 10 Jan 2001 00:44:03 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.30.0101092354140.9990-100000@e2>
In-Reply-To: <Pine.LNX.4.30.0101092354140.9990-100000@e2>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01011001040704.03050@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 09 Jan 2001 you wrote:
> On Tue, 9 Jan 2001, Robert Kaiser wrote:
> 
> > Now comes the amazing (to me) part: I split the above statement up into:
> >
> > 	temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> > 	*pte = temp;
> 
> this is almost impossible (except some really weird compiler bug) - unless
> the mem_map address is invalid. This could happen if your kernel image is
> *just* too large. Do things improve if you disable eg. ext2fs support (i
> know, but should be enough to boot).

Sorry, no ext2fs in this kernel (it is for a diskless embedded system). I seem
to recall though that the problem at one point magically went away when I
disabled the FPU emulation, but I have not been able to reproduce this
recently, so I'm not sure. Making minor changes to the kernel code (such as
adding/removing some test-prints) certainly does not affect the behavior.

> Or if that part is not mapped
> correctly (which does happen sometimes as well).

What could I do to check/fix this ? 

> 
> and are you sure it crashes there? [are you putting delays between your
> printouts?]

I have put a "halting statement" (i.e. "while(1);") after my printouts to make
sure execution does not go any further than that point. I moved this halting
statement ahead in the code line by line until the crash would occur again.
So, yes, I am pretty sure.

> 
> > where temp is declared "volatile pte_t". I inserted test-prints between the
> > above two lines. Accoding to that, the _first_ line , i.e. the evaluation of the
> > mk_pte_phys() macro is causing the crash!
> 
> it accesses mem_map variable, which is near to the end of the kernel
> image, so it could indeed something of that sort. An uncompressed kernel
> image (including the data area) must not be bigger than 4MB (IIRC).

According to my System.map file, mem_map is at 0xc0244f78. Does that help ?



----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
