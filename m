Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRHWSNC>; Thu, 23 Aug 2001 14:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHWSMw>; Thu, 23 Aug 2001 14:12:52 -0400
Received: from mout1.freenet.de ([194.97.50.132]:45002 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S269517AbRHWSMm>;
	Thu, 23 Aug 2001 14:12:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Athlon/3DNow write prefetch?
Date: Thu, 23 Aug 2001 20:13:00 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01082320130001.21357@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

in looking at the prefetch code from include/asm-i386/processor.h on 
2.4.9-ac9, I have noticed that prefetchw seems not to be implemented right:

The Athlon/3DNow prefetchw() implementation uses the `prefetch' assembler 
instruction, which is in fact a read prefetch, while it should use the 
`prefetchw' instruction, which is for write prefetch.

Any comments on this?

Greetings,
Andreas

(Here the excerpt from the code...)

[...]

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
 
extern inline void prefetch(const void *x)
{
         __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
}
 
extern inline void prefetchw(const void *x)
{
         __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
                                ^^^^^^^^ <- Shouldn't this be prefetchw ???
} 
#define spin_lock_prefetch(x)   prefetchw(x)
 
#endif

