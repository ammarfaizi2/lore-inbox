Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277536AbRJESLM>; Fri, 5 Oct 2001 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277535AbRJESKx>; Fri, 5 Oct 2001 14:10:53 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:32234 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S277534AbRJESKt>; Fri, 5 Oct 2001 14:10:49 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.11-pre4
Date: Fri, 5 Oct 2001 20:11:05 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1546529396.1002273909@mbligh.des.sequent.com>
In-Reply-To: <1546529396.1002273909@mbligh.des.sequent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011005181051Z277534-760+21202@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Oktober 2001 18:25 schrieb Martin J. Bligh:
> Odd. Compiles for me with and without SMP support turned on.

UP only. But with UP IOAPIC.

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_HAVE_DEC_LOCK=y

> Does "linux-2.4.11-pre4-preempt" mean you're running with other
> patches over the raw kernel? Which ones - just the preempt patch?

Yes.

First:
patch-rml-2.4.11-pre2-preempt-kernel-1
It works with pre2 and pre3 (after some clean ups by hand)
http://www.tech9.net/rml/linux/

Second:
Kupdated-patch for ReiserFS but that shouldn't matter.
No link handy. I can send it to you if you need it.

> Can you point me to them?

See above.

>
> Martin
>
> PS. If you had other patches, can you try compiling just raw 2.4.11-pre4,
> and tell me if that works?

Only the two above.
I'll try tomorrow if it's needed.

Ughh.
I have a "dbench 32" loop with 1000 (one thousend) cycles running on an IBM 
DDYS 18GB U160 test disk running. 'cause my own (same but younger, latest 
firmware Rev. S96H) spin down occasionally. I think it have to be replaced:-(
Then it is the third one. My first show "extremely shocked error" code with 
the DFT IBM tool.

System load stays at 29~32 (through put is between 40-45 MB/sec) for some 
hours, now and during I write this text...
Andrea's VM plus preempt-patch is GREAT.

Greetings,
	Dieter

> mpparse.c does this:
>
> #include <asm/smp.h>
>
> smp.h does this:
>
> #ifndef clustered_apic_mode
>  #ifdef CONFIG_MULTIQUAD
>   #define clustered_apic_mode (1)
>   #define esr_disable (1)
>  #else /* !CONFIG_MULTIQUAD */
>   #define clustered_apic_mode (0)
>   #define esr_disable (0)
>  #endif /* CONFIG_MULTIQUAD */
> #endif
>
> Or at least it should .....
>
> --On Friday, October 05, 2001 6:38 AM +0200 Dieter Nützel 
<Dieter.Nuetzel@hamburg.de> wrote:
> > Hello Linus,
> >
> > > the new and very cool Multiquad NUMA stuff break something...
> > > gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4-preempt/include -Wall >
> > > -Wstrict-prototypes -Wno-trigraphs -O -fomit-frame-pointer >
> > > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > > -mcpu=k6 > -mpreferred-stack-boundary=2 -malign-functions=4
> > > -fschedule-insns2 > -fexpensive-optimizations     -c -o mpparse.o
> > > mpparse.c
> >
> > mpparse.c: In function `MP_processor_info':
> > mpparse.c:195: `clustered_apic_mode' undeclared (first use in this
> > function) mpparse.c:195: (Each undeclared identifier is reported only
> > once mpparse.c:195: for each function it appears in.)
> > mpparse.c: In function `smp_read_mpc':
> > mpparse.c:386: `clustered_apic_mode' undeclared (first use in this
> > function) make[1]: *** [mpparse.o] Error 1
> > make[1]: Leaving directory >
> > `/usr/src/linux-2.4.11-pre4-preempt/arch/i386/kernel' make: ***
> > [_dir_arch/i386/kernel] Error 2
> > 269.520u 29.200s 5:45.26 86.5%  0+0k 0+0io 1007275pf+0w
> >
> > > -Dieter
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

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
