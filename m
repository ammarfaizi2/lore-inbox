Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRI3MUk>; Sun, 30 Sep 2001 08:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRI3MU3>; Sun, 30 Sep 2001 08:20:29 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:31975 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S273345AbRI3MUP>; Sun, 30 Sep 2001 08:20:15 -0400
Date: Sun, 30 Sep 2001 06:19:04 -0600
Message-Id: <200109301219.f8UCJ4H16858@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Race between init_idle and reschedule_idle
In-Reply-To: <1076429074.1001803809@[10.10.1.2]>
In-Reply-To: <1076429074.1001803809@[10.10.1.2]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh writes:
> Thanks to Alan Cox & Andrew Morton for showing me how to serialise
> the cpus to make the panic legible. The following patch holds back
> the boot cpu at the end of smp_init until all the secondarys have
> done init_idle:

One thing that bothers me about your patch is how it limits the number
of CPU's to the number of bits in an unsigned long. While I realise
there are other places that do the same (last time I looked), we
shouldn't be perpeturating these kinds of limitations.

I'd suggest you use an atomic_t instead. Increment for each CPU, and
decrement when each CPU is ready. Just test for 0 in your wait loop.
One less piece of code we have to overhaul later.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
