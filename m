Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbQLATp2>; Fri, 1 Dec 2000 14:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbQLATpT>; Fri, 1 Dec 2000 14:45:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31248 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129552AbQLATpK>; Fri, 1 Dec 2000 14:45:10 -0500
Date: Fri, 1 Dec 2000 20:14:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ink@jurassic.park.msu.ru, ezolt@perf.zko.dec.com, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
Subject: Re: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
Message-ID: <20001201201444.A2098@inspiron.random>
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru> <20001201151842.C30653@athlon.random> <200012011819.KAA02951@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012011819.KAA02951@pizda.ninka.net>; from davem@redhat.com on Fri, Dec 01, 2000 at 10:19:44AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 10:19:44AM -0800, David S. Miller wrote:
>    I'm still left the #ifdef __alpha__ around the context[NR_CPUS] to
>    avoid breakage of other archs but that should be probably removed:
>    any CPU with per-CPU ASNs like alpha needs per-CPU per-MM context
>    information to avoid wasting ASNs when the task migrate CPU or with
>    threads.
> 
> I would instead suggest to declare 'context' to be of an arch-specific
> defined type, much like "thread_struct" is.

I agree, really that should been the case since the first place because the 4
bytes of context are just a waste for x86* :). I mainly wanted to make sure
other archs was doing the right thing too.

> For example, I don't need NR_CPUS contexts in the mm_struct on
> sparc64, my allocation just works differently, so I shouldn't eat
> all the space.

I think at least mips wants to use per-mm per-cpu context too btw.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
