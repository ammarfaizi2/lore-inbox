Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUBMStc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267187AbUBMStc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:49:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:9090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267185AbUBMStW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:49:22 -0500
Date: Fri, 13 Feb 2004 10:49:17 -0800
From: cliff white <cliffw@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [ANNOUNCE] kernbench-0.20
Message-Id: <20040213104917.72f45aa8.cliffw@osdl.org>
In-Reply-To: <200402131518.41209.kernel@kolivas.org>
References: <200402131518.41209.kernel@kolivas.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 15:18:34 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Martin J. Bligh has for some time been producing results of a benchmark he 
> devised called "kernbench" which is designed to measure cpu throughput, with 
> emphasis on SMP systems.
> 
> I set out to make this benchmark a portable and easy to use script for anyone 
> with adequate hardware to perform kernbench, after some feedback from MJB. 
> All the SMP work currently underway inspired this. So here is the first 
> public release:
> 
> http://ck.kolivas.org/kernbench/
> 
> What it does:
> It runs the venerable kernel compile a number of different ways:
> It cleans and primes a kernel tree with a make defconfig. Then it reads all 
> the kernel source to cache it in ram. Then it will perform a number of 
> different kernel compiles after a warmup run compile the same as the one it 
> is about to test. Then it times the following runs 5 times:
> 
> half load: make -j (NR_CPUS/2)
> optimal load: make -j (NR_CPUS*4)
> maximum load: make -j
> 
> Optionally it can also perform a single threaded make, the number of jobs for 
> optimal can be defined, the number of runs can be defined, and any of the 
> default runs can be disabled.
> 
> Then it will print out an average of each of the loads with some useful 
> statistics. A sample from an IBM X440 8x1.5Ghz P4HT on linux-2.6.3-rc2 
> follows:
> 
[ snip ]
> A few points:
> Do not try to run the maximum load on a machine with less than 2Gb ram, as 
> swap thrashing is likely, so the benchmark will not be a cpu throughput one 
> but a vm benchmark (of course you may want to do this too).
> 
> It is best run on a non-journalled filesystem to minimise the effects of the 
> journal write-out; although this is probably not greatly important.
> 
> If run on a 4x box, the half load will be make -j2. The problem with compiling 
> a kernel at make -j2 is that usually only one job spawns so the results may 
> not be very useful.
> 
> 
> Cliff if you want to wrap this into an OSDL benchmark, it may be worthwhile 
> profiling each group of runs together and using the -s option by default as a 
> separate "kernbench-long" to include the single threaded runs. 

Thanks!
We'll get it into STP asap.
cliffw

> 
> Thanks, Martin for the idea and feedback. Thanks osdl for the hardware for 
> development, and others for code help.
> 
> Con Kolivas
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQFALFAdZUg7+tp6mRURAlP5AJ4mNCVYx9t8l6/gfbWDkUnwgCOFqACfYAv2
> j65YYRirO/9Y8OcEii/fO0U=
> =JPCD
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
