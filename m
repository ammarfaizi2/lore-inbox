Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLOR6o>; Fri, 15 Dec 2000 12:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbQLOR6f>; Fri, 15 Dec 2000 12:58:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10633 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129289AbQLOR6W>;
	Fri, 15 Dec 2000 12:58:22 -0500
Date: Fri, 15 Dec 2000 09:11:31 -0800
Message-Id: <200012151711.JAA20826@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andrea@suse.de
CC: ink@jurassic.park.msu.ru, ezolt@perf.zko.dec.com, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
In-Reply-To: <20001215164626.C16586@inspiron.random> (message from Andrea
	Arcangeli on Fri, 15 Dec 2000 16:46:26 +0100)
Subject: Re: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru> <20001201151842.C30653@athlon.random> <200012011819.KAA02951@pizda.ninka.net> <20001201201444.A2098@inspiron.random> <20001215164626.C16586@inspiron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 15 Dec 2000 16:46:26 +0100
   From: Andrea Arcangeli <andrea@suse.de>

   This one breaks all archs but i386 and alpha. If some arch maintainer likes me
   to update its arch blindly implementing mm_arch structure as an `unsigned long
   context' and fixing up the miscompilation I will do.

Can you name the mm_struct member "context" still instead of
"mm_arch"?  Because many ports will simply:

typedef unsigned long mm_arch_t;

Then all the code changes will make the accesses look less
meaningful.  Consider:

	if (CTX_VALID(mm->mm_arch))

whereas before the code said:

	if (CTX_VALID(mm->context))

which tells the reader lot more.  In fact, retaining the "context" member
name allows most ports to operate with only one change, creating
the asm/mm_arch.h header.  You can in fact do this for all ports
which care about MMU tlb contexts (a simple grep such as
egrep -e "m->context" `find . -type f -name "*.[ch]"`
will show you which ports care).

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
