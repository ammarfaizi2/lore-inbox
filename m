Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSEPM2r>; Thu, 16 May 2002 08:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSEPM2q>; Thu, 16 May 2002 08:28:46 -0400
Received: from sol.mixi.net ([208.131.233.11]:50583 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S312498AbSEPM2p>;
	Thu, 16 May 2002 08:28:45 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15587.42492.25950.446607@rtfm.ofc.tekinteractive.com>
Date: Thu, 16 May 2002 07:28:44 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: "Mike Galbraith" <EFAULT@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <200205160528.g4G5S631019167@sol.mixi.net>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith writes:
>Methinks there's an easier way to get to the line in question.  Compile sched.c with -g via make kernel/sched.o EXTRA_CFLAGS=-g.. gbd can then be used to get you the line with list *__wake_up+0xb2.


Ooh, spiffy idea.  (Like I said, asm rookie.)  I just compiled gdb,
and here's what it says.  Interesting, to me, at least.


(gdb) list *__wake_up+0xb2
0x9d6 is in __wake_up
(/src/linux-2.4.19-pre8/include/asm/processor.h:488).
483     #ifdef  CONFIG_MPENTIUMIII
484
485     #define ARCH_HAS_PREFETCH
486     extern inline void prefetch(const void *x)
487     {
488             __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
489     }
490
491     #elif CONFIG_X86_USE_3DNOW
492

