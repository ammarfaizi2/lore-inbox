Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSIJRnr>; Tue, 10 Sep 2002 13:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSIJRnr>; Tue, 10 Sep 2002 13:43:47 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:47771 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315870AbSIJRnq>; Tue, 10 Sep 2002 13:43:46 -0400
Date: Tue, 10 Sep 2002 20:11:49 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [patch] fix NMI watchdog, 2.5.34 
In-Reply-To: <20020910054147.CD7972C201@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209102008000.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Rusty Russell wrote:

> Well spotted.  You might want to test the following patch which
> catches calls to smp_call_function() before the cpus are actually
> online.  I ran a variant on my (crappy, old, SMP) box before I sent
> the patch to Linus, and all I saw was the (harmless) tlb_flush.

hmm...

> diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/arch/i386/kernel/smpboot.c working-2.5.34-smp_call_cpus/arch/i386/kernel/smpboot.c
> --- linux-2.5.34/arch/i386/kernel/smpboot.c	Sun Sep  1 12:22:57 2002
> +++ working-2.5.34-smp_call_cpus/arch/i386/kernel/smpboot.c	Tue Sep 10 14:35:07 2002
> @@ -1218,7 +1218,10 @@ int __devinit __cpu_up(unsigned int cpu)
>  	return 0;
>  }
>  
> +unsigned int smp_done = 0;
> +
>  void __init smp_cpus_done(unsigned int max_cpus)
>  {
>  	zap_low_mappings();
> +	smp_done = 1;

I've got an SMP box which dies reliably at zap_low_mappings, i wonder if 
this could be the same problem. My BSP sits spinning on the completion 
check.

	Zwane

-- 
function.linuxpower.ca


