Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJEUdt>; Fri, 5 Oct 2001 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273135AbRJEUd3>; Fri, 5 Oct 2001 16:33:29 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:1685 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S272074AbRJEUd0>; Fri, 5 Oct 2001 16:33:26 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Olaf Zaplinski <o.zaplinski@mediascape.de>
Subject: Re: Linux 2.4.11-pre4
Date: Fri, 5 Oct 2001 22:33:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1551862685.1002279242@mbligh.des.sequent.com>
In-Reply-To: <1551862685.1002279242@mbligh.des.sequent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011005203328Z272074-760+21278@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Oktober 2001 19:54 schrieb Martin J. Bligh:
> > Odd. Compiles for me with and without SMP support turned on.
>
> My fault. I'd tested this on SMP and Uniproc, but not uniproc with
> IO apic support. Try this patch:

1. OK, it fixes the UP UP_IOAPIC compilation problem.
System (with preempt-patch) up and runnig.

2. Woohu. I have 8 CPUs, now...;-)
--- /proc is somewhat broken

[-]
processor       : 7
vendor_id       : 9—U0D'À
cpu family      : 1
model           : 0
model name      : 0D'À
stepping        : unknown
cache size      : 0 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : -1071168528
wp              : yes
flags           : fpu syscall mmxext lm 3dnowext 3dnow cxmmx
bogomips        : 0.00
[-]

3. OOmem deak look.

4. Back in disk stress mode...again.

-Dieter

> --- smp.h.old	Fri Oct  5 10:46:40 2001
> +++ smp.h	Fri Oct  5 10:48:37 2001
> @@ -31,9 +31,20 @@
>  #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all
> procs */ # endif
>  #else
> +# define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
>  # define TARGET_CPUS 0x01
>  #endif
>
> +#ifndef clustered_apic_mode
> + #ifdef CONFIG_MULTIQUAD
> +  #define clustered_apic_mode (1)
> +  #define esr_disable (1)
> + #else /* !CONFIG_MULTIQUAD */
> +  #define clustered_apic_mode (0)
> +  #define esr_disable (0)
> + #endif /* CONFIG_MULTIQUAD */
> +#endif
> +
>  #ifdef CONFIG_SMP
>  #ifndef ASSEMBLY
>
> @@ -76,16 +87,6 @@
>  extern volatile int physical_apicid_to_cpu[MAX_APICID];
>  extern volatile int cpu_to_logical_apicid[NR_CPUS];
>  extern volatile int logical_apicid_to_cpu[MAX_APICID];
> -
> -#ifndef clustered_apic_mode
> - #ifdef CONFIG_MULTIQUAD
> -  #define clustered_apic_mode (1)
> -  #define esr_disable (1)
> - #else /* !CONFIG_MULTIQUAD */
> -  #define clustered_apic_mode (0)
> -  #define esr_disable (0)
> - #endif /* CONFIG_MULTIQUAD */
> -#endif
>
>  /*
>   * General functions that each host system must provide.
