Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289834AbSAWMfN>; Wed, 23 Jan 2002 07:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289833AbSAWMfD>; Wed, 23 Jan 2002 07:35:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11674 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289825AbSAWMev>;
	Wed, 23 Jan 2002 07:34:51 -0500
Date: Wed, 23 Jan 2002 07:34:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre2-3 SMP broken on UP boxen
In-Reply-To: <Pine.LNX.4.33.0201231516390.1396-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0201230733070.17439-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Jan 2002, Ingo Molnar wrote:

> 
> On Wed, 23 Jan 2002, Zwane Mwaikambo wrote:
> 
> > 	My test box is a single proc machine running an SMP kernel. As
> > of 2.5.2-pre2 it panics on boot. [...]
> 
> the same on 2.5.3-pre3 as well?
> 
> > [...] The reason is kinda obvious, smp_processor_id() will always
> > return the same as global_irq_holder. How come we do this check now?
> 
> it should only be set when the current CPU has disabled global IRQs.

in arch/i386/kernel/smpboot.c:

@@ -1017,7 +1017,7 @@
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
 
-	global_irq_holder = 0;
+	global_irq_holder = NO_PROC_ID;
 	current->cpu = 0;
 	smp_tune_scheduling();
 

