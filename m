Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbQLGSnI>; Thu, 7 Dec 2000 13:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQLGSm5>; Thu, 7 Dec 2000 13:42:57 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:64996 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131671AbQLGSmv>; Thu, 7 Dec 2000 13:42:51 -0500
Date: Thu, 7 Dec 2000 19:04:12 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "Richard B. Johnson" <root@chaos.analogic.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <F00C8C3408E@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001207185903.21086J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Petr Vandrovec wrote:

> No. If interrupt uses task gate, task switch happens. Nothing is stored
> in context of old process except registers into TSS. There is only one
> (bad) problem. If you want to get it 100% proof (it is not needed for double
> fault, but it is definitely needed for NMI, as NMI is very often on SMP
> ia32), each CPU's IRQ vector must point to different task, otherwise you
> can get TSS in use during doublefault, leading to triplefault again...

 Well, I expect wasting a descriptor and a page of memory for the purpose
of a TSS is not a big problem.

> Yes. Currently if any ESP related problem happens in kernel, machine silently
> reboots without any message. With task gate (as Jeff Merkey proposed

 You might handle the stack fault with a task gate, actually, but I'm not
sure it's worth the hassle.  Handling just the double fault should be
sufficient. 

> some months ago, btw), you can even suspend offending task and recover
> from it... I think that also bluesmoke should use task gate, but I
> did not read documentation on this yet.

 Yep.  An MCE is an abort like a double-fault, so the CPU state might be
corrupted (by definition -- I have no idea whether it really happens). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
