Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUHTTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUHTTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUHTTID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:08:03 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36506 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268683AbUHTTFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:05:42 -0400
Date: Fri, 20 Aug 2004 11:53:51 -0600
From: martin rumori <lists@rumori.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problems with volunteer preempt patch WAS: little NPTL SCHED_FIFO test program
Message-ID: <20040820175351.GA2302@amadora.tejo>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	jackit-devel <jackit-devel@lists.sourceforge.net>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200408172102.00964.pnambic@unu.nu> <20040818004633.35eb6501@mango.fruits.de> <200408180100.04955.pnambic@unu.nu> <20040818023546.03e79fc4@mango.fruits.de> <1092794828.813.49.camel@krustophenia.net> <20040818050708.54a27a7e@mango.fruits.de> <pan.2004.08.19.23.33.47.308243@gmx.de> <1092987523.10063.62.camel@krustophenia.net> <20040820092042.GA2496@amadora.tejo> <1092994979.10063.80.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092994979.10063.80.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 05:42:59AM -0400, Lee Revell wrote:
> On Fri, 2004-08-20 at 05:20, martin rumori wrote:
> > tried to compile 2.6.8.1 with volunteer-preempt-P5 (latest), but
> > wasn't able to boot into the new kernel.  shows some lines of ACPI....

> I think you have an off-by-one error.  The latest version is -P4.

o.k., you're right.  this time it's really -P5 :-)

> Try the 'noacpi' boot option.  Also, try disabling all power
> management.  I know this is not realistic for a laptop, it's just for
> debugging purposes.

tried it with the options, no success.  built a kernel without
powermanagement and without cpu speedstep at all.  exactly the same
behavior, directly after unpacking the kernel at the beginning of
startup:

0 MB highmem
511 mb lowmem available

ACPI RSDP .....
.....
ACPI build 1 zone list
Detected Processor...
Memory ...
...
Checking if processor honors the WP bit even in supervisor mode... ok.

---
that's it.  freezes for 1-2 seconds after this last message, then
reboots.  tried to write down these contents of the screen, as far as
i could recognize them during the short period of time.

i am wondering especially about the ACPI messages, as ACPI is
completely switched off now.

second (minor) issue: when having enabled CONFIG_PREEMPT_VOLUNTARY(=y)
but not CONFIG_PREEMPT_TIMING(=n), i get the following when linking:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x2da1): In function `do_nmi':
: undefined reference to `__trace'
arch/i386/kernel/built-in.o(.text+0x342c): In function `do_IRQ':
: undefined reference to `__trace'
arch/i386/mm/built-in.o(.text+0x705): In function `do_page_fault':
: undefined reference to `__trace'
make: *** [.tmp_vmlinux1] Error 1

maybe latency.o is not included when linking without
CONFIG_PREEMPT_TIMING?

bests,

martin
