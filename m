Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317195AbSFFVtx>; Thu, 6 Jun 2002 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317201AbSFFVtx>; Thu, 6 Jun 2002 17:49:53 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:39042 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317195AbSFFVtw>; Thu, 6 Jun 2002 17:49:52 -0400
Date: Thu, 6 Jun 2002 23:49:46 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Dave Jones <davej@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
In-Reply-To: <20020606233655.E16262@suse.de>
Message-ID: <Pine.GSO.4.05.10206062338220.19900-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Dave Jones wrote:

> On Thu, Jun 06, 2002 at 11:23:11PM +0200, Thomas 'Dent' Mirlacher wrote:
>  > > and then go edit every SMP-capable arch's config.in/Config.help
>  > > files.  But the arch maintainers should test one case please - x86
>  > > was locking up at boot on quad CPU with NR_CPUS=2.  Others may do
>  > > the same.
>  > 
>  > well, what you need to do is make sure smp_num_cpu <= NR_CPUS,
>  > otherwise the kernel will go ballistic on several places within
>  > the code.
> 
> *nod*, relying on the user to get it right may not be as simple
> as it seems. Quite a few people were pleasantly surprised when
> their 2-way P4 Xeon become a 4-way HT P4 box.

:)

you could allocate all the cpu-nr dependend structures during startup,
but then you're limited to the nr of cpus present at startup time
(and use smp_num_cpus instead of NR_CPUS)

- which means:

	1) no recompilation when you upgrade your (already smp) box
	2) no chance for cpu hotplugging

or the other choice, as it seems to be vafoured right now:

let the user pick, and blame the user if he/she did something wrong. 

and a question: is current_thread_info()->cpu a logical cpu#, or 
	a harwired one.

if it's a logical one, the easiest solution for not crashing the
kernel (on bootup - not talking about adding a cpu during runtime),
would be to restrict mac_cpus to NR_CPUS.
if it's a harwired one, well, the user has to live with the consequences
of a compilation time error.

just my $0.02

	tm

-- 
in some way i do, and in some way i don't.

