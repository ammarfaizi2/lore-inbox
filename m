Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSE2XHa>; Wed, 29 May 2002 19:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315693AbSE2XH3>; Wed, 29 May 2002 19:07:29 -0400
Received: from jalon.able.es ([212.97.163.2]:22232 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315631AbSE2XH2>;
	Wed, 29 May 2002 19:07:28 -0400
Date: Thu, 30 May 2002 01:06:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de
Subject: Re: [PATCH] intel-x86 model config cleanup
Message-ID: <20020529230644.GC3174@werewolf.able.es>
In-Reply-To: <20020529143544.GA2224@werewolf.able.es> <3CF53C03.5040301@mandrakesoft.com> <3CF53C34.2080300@mandrakesoft.com> <20020529224423.GA3174@werewolf.able.es> <3CF55C3D.6030008@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.30 Jeff Garzik wrote:
>
>The basic thing to remember is that "generic_foo" or "cpu_intel_foo" 
>options should very rarely, if ever, appear in the config.in or sources. 
> We simply want to use the generic or cpu-specific user selection to 
>determine (a) compiler flags, (b) CONFIG_xxx symbols for specific CPU 
>features and optimizations, [like CONFIG_X86_F00F_BUG] and maybe (c) 
>enable and disable CPU-specific drivers.  (c) will be a special case, 
>since very few drivers should require a specific CPU type... but some 
>drivers simply don't work on 386.
>

Grep on the tree showed this:

drivers/char/serial.c:

#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
#define SERIAL_INLINE
#endif

include/asm-i386/processor.h:

/* Prefetch instructions for Pentium III and AMD Athlon */
#ifdef  CONFIG_MPENTIUMIII

#define ARCH_HAS_PREFETCH
extern inline void prefetch(const void *x)
{
    __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
}

#elif CONFIG_X86_USE_3DNOW

#define ARCH_HAS_PREFETCH
#define ARCH_HAS_PREFETCHW
#define ARCH_HAS_SPINLOCK_PREFETCH

More candidates for CONFIG_X86_xxxxx.
But these spawn over other architextures:
include/asm-alpha/processor.h:#define ARCH_HAS_PREFETCH
include/asm-ppc/processor.h:#define ARCH_HAS_PREFETCH
...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
