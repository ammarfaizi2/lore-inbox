Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRALUGo>; Fri, 12 Jan 2001 15:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRALUGe>; Fri, 12 Jan 2001 15:06:34 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:5642 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132636AbRALUGY>;
	Fri, 12 Jan 2001 15:06:24 -0500
Date: Fri, 12 Jan 2001 21:05:59 +0100
From: Frank de Lange <frank@unternet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112210559.B26555@unternet.org>
In-Reply-To: <20010112205245.A26555@unternet.org> <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 11:59:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 11:59:25AM -0800, Linus Torvalds wrote:
> > Could this really be the solution?
> 
> I'd like to know _which_ of the two makes a difference (or does it only
> trigger with both of them enabled)? And even then I'm not sure that it is
> "the" solution - both changes to io-apic handling had some reason for
> them. Ingo, what was the focus-cpu thing?

Well, with 'this' (in 'could THIS be') I really meant the move from disable_irq
to the irq_safe spinlocks. I'm currently running with the patched 8390.c
driver, patched io_apic (TARGET_CPUS 0xff) and patched apic.c (focus cpu
enabled), and have had no problems yet... even though I'm running several
simulatnsous nfs cp -rd <big_dir>, streaming network audio, scanning with an
USB scanner, etc.

So far, it seems that the patch to 8390.c removed the symptoms. The changes to
apic.c and io_apic.c did not make the network hang come back. 

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
