Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbQLOS0i>; Fri, 15 Dec 2000 13:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbQLOS03>; Fri, 15 Dec 2000 13:26:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8252 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130330AbQLOS0M>; Fri, 15 Dec 2000 13:26:12 -0500
Date: Fri, 15 Dec 2000 18:55:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ink@jurassic.park.msu.ru, ezolt@perf.zko.dec.com, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
Subject: Re: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
Message-ID: <20001215185528.C17781@inspiron.random>
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru> <20001201151842.C30653@athlon.random> <200012011819.KAA02951@pizda.ninka.net> <20001201201444.A2098@inspiron.random> <20001215164626.C16586@inspiron.random> <200012151711.JAA20826@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012151711.JAA20826@pizda.ninka.net>; from davem@redhat.com on Fri, Dec 15, 2000 at 09:11:31AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 09:11:31AM -0800, David S. Miller wrote:
> Can you name the mm_struct member "context" [..]

I got you was proposing that but once we change it I preferred to use a generic
mm_arch structure (not just a context field) to have a more generic interface
in the long run.  (maybe some port wants to collect something else than a MM
`context')

> Then all the code changes will make the accesses look less
> meaningful.  Consider:
> 
> 	if (CTX_VALID(mm->mm_arch))
> 
> whereas before the code said:
> 
> 	if (CTX_VALID(mm->context))
> 
> which tells the reader lot more. [..]

What I propose is to convert the current:

	if (CTX_VALID(mm->context)) 

to

	if (CTX_VALID(mm->mm_arch.context))

(that's the same I did in the alpha tree from mm->context[] to
mm->mm_arch.context[])

I'm aware this way all ports actively using `mm->context' needs to be changed
but the change is certainly a no-brainer... OK?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
