Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJESQM>; Fri, 5 Oct 2001 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJESQD>; Fri, 5 Oct 2001 14:16:03 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:58872 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S277539AbRJESPx>; Fri, 5 Oct 2001 14:15:53 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Olaf Zaplinski <o.zaplinski@mediascape.de>
Subject: Re: Linux 2.4.11-pre4
Date: Fri, 5 Oct 2001 20:15:22 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1551862685.1002279242@mbligh.des.sequent.com>
In-Reply-To: <1551862685.1002279242@mbligh.des.sequent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011005181559Z277539-760+21205@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Oktober 2001 19:54 schrieb Martin J. Bligh:
> > Odd. Compiles for me with and without SMP support turned on.
>
> My fault. I'd tested this on SMP and Uniproc, but not uniproc with
> IO apic support. Try this patch:

Yes, I have UP with UP_IOAPIC enabled.
Shall I test it or run my disk test over night?

Thanks for your fast fix.
I have some short hiccup during this "test site".
So I can't type that fast...

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

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
