Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWGJJEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWGJJEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWGJJEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:04:04 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:22227 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751370AbWGJJED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:04:03 -0400
Date: Mon, 10 Jul 2006 11:03:25 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
In-Reply-To: <20060706031416.33415696.akpm@osdl.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<20060706031416.33415696.akpm@osdl.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 03:14:16 -0700
Andrew Morton <akpm@osdl.org> wrote:

> OK, thanks.  Send me the whole lot when you think it's ready and
> we'll get it into the pipeline.  Not for 2.6.18 though - we need to
> give people time to look through it and send you nastygrams ;)

I've put up an updated patch at
http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-3.patch

which fixes most of the issues people have pointed out. Thanks a lot
to everyone for taking the time to look through this.

I've appended the changelog below, but first I'll mention the things I
didn't fix and why:

There are three libgcc functions left, which handle the three possible
variants of 64-bit shift. There's no easy way to eliminate these, but
maybe our gcc maintainer can get gcc to emit the instructions inline
instead. However, these functions are actually specified by the AVR32
ABI, so they should be the same no matter which compiler you use.

The clk API is still exported as non-GPL. I don't feel very strongly
one way or another, but since Russell is keeping them non-GPL on ARM,
it makes most sense to keep them non-GPL on AVR32 as well.

I've kept the volatiles in the arguments to the bitops functions as
they are. I'm not sure if they're really needed, but as I understood
from reading the recent thread about spinlocks, this doesn't fall in
the category of "obviously bad" usage of volatile.

Here's the shortlog:
      Add MAINTAINERS entries for AVR32 and AT32AP
      Remove EARLY_PRINTK support
      Remove CONFIG_DW_DMAC symbol
      Remove DMA controller framework
      Add Kbuild file for 'make headers_install' on AVR32
      Remove #ifdef __KERNEL__ from asm/atomic.h
      Remove #ifdef __KERNEL__ from asm/bitops.h
      Remove #ifdef __KERNEL__ from asm/dma-mapping.h
      Remove #ifdef __KERNEL__ from asm/mmu_context.h
      Remove #ifdef __KERNEL__ from asm/semaphore.h
      Remove #ifdef __KERNEL__ from asm/thread_info.h
      Move PAGE_SIZE and friends inside #ifdef __KERNEL__
      Wrap __FD_SET and friends inside __KERNEL__
      Kill _syscall[0123456]() and hand-code execve() instead
      Remove obsolete #include <linux/config.h>
      Replace MB -> MiB and KB -> KiB
      Wire up 39 new syscalls
      Use do_div() instead of open-coded div64 in time_init()
      Use for_each_online_cpu in show_interrupts()
      Add asm/futex.h
      Ensure kprobes compiles again
      Switch to genirq framework
      Fix cpu_idle preempt bug
      Process softirqs the usual way
      Handle preempt in the interrupt- and exception handlers

Håvard
