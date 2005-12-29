Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVL2UFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVL2UFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVL2UFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:05:23 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14552 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750919AbVL2UFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:05:22 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051229101736.GA2560@elte.hu>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com>  <20051229101736.GA2560@elte.hu>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 15:11:12 -0500
Message-Id: <1135887072.6804.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 11:17 +0100, Ingo Molnar wrote:
> * Dave Jones <davej@redhat.com> wrote:
> 
> >  > could test it by e.g. trying to reproduce the same VM latency as in the 
> >  > -rt tree. [the two zlib patches are needed if you are using 4K stacks, 
> >  > mcount increases stack footprint.]
> > 
> > kernel/latency.c: In function 'add_preempt_count_ti':
> > kernel/latency.c:1703: warning: implicit declaration of function 'preempt_count_ti'
> > kernel/latency.c:1703: error: invalid lvalue in assignment
> > kernel/latency.c: In function 'sub_preempt_count_ti':
> > kernel/latency.c:1764: error: invalid lvalue in assignment
> 
> indeed - i have fixed this and have uploaded a new version to:
> 
>    http://redhat.com/~mingo/latency-tracing-patches/

Still does not quite work for me on i386.  I applied all the patches as
I'm using 4K stacks.

LD      .tmp_vmlinux1
init/built-in.o: In function `start_kernel':
: undefined reference to `preempt_max_latency'
make: *** [.tmp_vmlinux1] Error 1

.config excerpts:

# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_WAKEUP_TIMING=y
# CONFIG_WAKEUP_LATENCY_HIST is not set
CONFIG_PREEMPT_TRACE=y
CONFIG_CRITICAL_PREEMPT_TIMING=y
# CONFIG_PREEMPT_OFF_HIST is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
CONFIG_CRITICAL_TIMING=y
CONFIG_LATENCY_TIMING=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

Lee

