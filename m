Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbTAQFo0>; Fri, 17 Jan 2003 00:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTAQFo0>; Fri, 17 Jan 2003 00:44:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:25572 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267390AbTAQFoZ>;
	Fri, 17 Jan 2003 00:44:25 -0500
Date: Thu, 16 Jan 2003 21:54:30 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH][2.5] fix for_each_cpu compilation on UP
Message-Id: <20030116215430.6c0ac6a0.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301162358060.24250-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301162358060.24250-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 05:53:17.0110 (UTC) FILETIME=[BB3D8D60:01C2BDEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@holomorphy.com> wrote:
>
> This adds a definition for for_each_cpu when !CONFIG_SMP
> 
> Please apply
> 
> Index: linux-2.5.58-cpu_hotplug/include/linux/smp.h
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.58/include/linux/smp.h,v
> retrieving revision 1.1.1.1.2.3
> diff -u -r1.1.1.1.2.3 smp.h
> --- linux-2.5.58-cpu_hotplug/include/linux/smp.h	17 Jan 2003 03:13:12 -0000	1.1.1.1.2.3
> +++ linux-2.5.58-cpu_hotplug/include/linux/smp.h	17 Jan 2003 03:14:40 -0000
> @@ -109,6 +109,7 @@
>  #define num_booting_cpus()			1
>  #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
>  #define smp_prepare_boot_cpu()			do {} while (0)
> +#define for_each_cpu(cpu, mask)			for (cpu = 0; cpu == 0; cpu++)
>  

This will cause nasty warnings (and posibly break) x86_64 builds, which
define their own for_each_cpu() in the !CONFIG_SMP case.

wimpy fix: move this into include/asm-i386/smp.h

nice fix: do a generic for_each_cpu() in include/linux/wherever.h, and rip
out the arch-private definitions.


