Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268925AbTBZVG3>; Wed, 26 Feb 2003 16:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBZVG3>; Wed, 26 Feb 2003 16:06:29 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:28621
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S268925AbTBZVG1>; Wed, 26 Feb 2003 16:06:27 -0500
Date: Wed, 26 Feb 2003 16:16:21 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <5740000.1046293404@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302261615330.8828-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Martin J. Bligh wrote:

> The boot cpu *is* always CPU#0. It may not be physical apicid 0, but that
> matters not. as long as the mpstables are correct. And we should bug out if
> it's not (which is pretty stupid anyway ... we know what the boot cpu ID
> is, we should just warn). This is how I fixed it for kexec:
> 
> diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/smpboot.c
> nonzero_apicid/arch/i386/kernel/smpboot.c
> --- virgin/arch/i386/kernel/smpboot.c	Sat Feb 15 16:11:40 2003
> +++ nonzero_apicid/arch/i386/kernel/smpboot.c	Wed Feb 26 13:02:10 2003
> @@ -951,6 +951,7 @@ static void __init smp_boot_cpus(unsigne
>  	print_cpu_info(&cpu_data[0]);
>  
>  	boot_cpu_logical_apicid = logical_smp_processor_id();
> +	boot_cpu_physical_apicid = hard_smp_processor_id();
>  
>  	current_thread_info()->cpu = 0;
>  	smp_tune_scheduling();

But this patch is for smpboot.c, which is not even compiled in for a UP 
kernel...

Both Rusty and I had problems with a UP+APIC kernel running on an SMP box.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

