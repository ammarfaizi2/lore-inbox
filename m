Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVJDS6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVJDS6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJDS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:58:47 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:846 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964915AbVJDS6q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:58:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZsXJ7ydQxKn3/PrS2IlUvkV3uidpjrGgWQEPpul2qEdtQsoc3ecCZbQUO84kAxWI2arPr4WDgnpZt6bWaQQJsRPwEAuCVhRx4LPkEN4YIVp+5QvrkBWDCt2p6Bz6ZzT+wkxyjCkr6iLHZyJrFnDnvjIvYYOFOFRLXgXTOvkLcJA=
Message-ID: <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
Date: Tue, 4 Oct 2005 11:58:46 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.14-rc3-rt2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128450029.13057.60.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2005-10-04 at 11:11 -0700, Mark Knecht wrote:
>
> > I have now had one burst of xruns. As best I can tell I was
> > downloading some video files for mplayer to look at, or possibly
> > running one of them. I see this in qjackctl:
> >
>
> I guess its related to the priority leak I'm tracking down right now.
> Can you please set following config options and check if you get a bug
> similar to this ?
>
> BUG: init/1: leaked RT prio 98 (116)?
>
> Steven, it goes away when deadlock detection is enabled. Any pointers ?
>
> tglx
>
>
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_LOG_BUF_SHIFT=17
> # CONFIG_DETECT_SOFTLOCKUP is not set
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_IRQ_FLAGS=y
> # CONFIG_WAKEUP_TIMING is not set
> CONFIG_PREEMPT_TRACE=y
> # CONFIG_CRITICAL_PREEMPT_TIMING is not set
> # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
> # CONFIG_RT_DEADLOCK_DETECT is not set
> # CONFIG_DEBUG_RT_LOCKING_MODE is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_FS is not set
> # CONFIG_USE_FRAME_POINTER is not set
> # CONFIG_EARLY_PRINTK is not set
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_KPROBES is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_4KSTACKS is not set
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y

Strange, but I don't have all the config options that you have, or I
cannot yet find the right things to turn them on. Specifically I'm
missing

> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_INFO=y
<SNIP>
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y

#
My current Kernel hacking section:

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_IRQ_FLAGS=y
# CONFIG_WAKEUP_TIMING is not set
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
# CONFIG_RT_DEADLOCK_DETECT is not set
# CONFIG_DEBUG_RT_LOCKING_MODE is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_USE_FRAME_POINTER is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_KPROBES is not set

I'll build this way for now. Send back some info on what you think I
need to turn on. I'm using make menuconfig. Maybe that's the problem?

Thanks,
Mark
