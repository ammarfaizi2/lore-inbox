Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136634AbREAPvm>; Tue, 1 May 2001 11:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136637AbREAPvc>; Tue, 1 May 2001 11:51:32 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:55700 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S136634AbREAPvL>; Tue, 1 May 2001 11:51:11 -0400
Date: Tue, 1 May 2001 16:50:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac2
In-Reply-To: <20010501170632.A1057@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0105011644170.1399-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, J . A . Magallon wrote:
> On 05.01 Alan Cox wrote:
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> Hangs after APIC init:
> 
> (bootlog from ac1)
> cpu: 0, clocks: 1002300, slice: 334100
> CPU0<T0:1002288,T1:668176,D:12,S:334100,C:1002300>
> cpu: 1, clocks: 1002300, slice: 334100
> CPU1<T0:1002288,T1:334080,D:8,S:334100,C:1002300>
> checking TSC synchronization across CPUs: passed.
> 
> <ac2 stops here>
> 
> PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1

Don't ask me why, but I think you may find it's Peter's patch to
the women-and-children-first in kernel/fork.c: I'm not yet running
-ac2, but I am trying that patch, fine on UP but hanging right there
(well, I get a "go go go" message too) on SMP.

Try reversing the:

-	p->counter = current->counter;
-	current->counter = 0;
+	p->counter = (current->counter + 1) >> 1;
+	current->counter >>= 1;
+	current->policy |= SCHED_YIELD;

and see if that works for you too.

Hugh

