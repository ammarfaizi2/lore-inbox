Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbUDOQQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUDOQQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:16:06 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:30660 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264342AbUDOQP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:15:59 -0400
Date: Thu, 15 Apr 2004 12:16:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 4k irqstacks on x86 (and add voyager support)
In-Reply-To: <1082043207.1804.4.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0404151139190.10471@montezuma.fsmlabs.com>
References: <1082042268.2166.2.camel@mulgrave> 
 <Pine.LNX.4.58.0404151126090.10471@montezuma.fsmlabs.com>
 <1082043207.1804.4.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, James Bottomley wrote:

> On Thu, 2004-04-15 at 10:29, Zwane Mwaikambo wrote:
> > > There's a bug in the x86 code in that it sets the boot CPU to zero.
> > > This isn't correct since some subarch's use physically indexed CPUs.
> > > However, subarchs have either set the boot cpu before irq_INIT() (or
> > > just inherited the default zero from INIT_THREAD_INFO()), so it's safe
> > > to believe current_thread_info()->cpu about the boot cpu.
> >
> > There is also smp_boot_cpus() which sets it to zero yet again later on =)
>
> That's PC specific, not subarch generic, so it doesn't matter to me.

Sorry for being a bit slow here, doesn't this affect voyager at all?

init/main.c:init()
	smp_prepare_cpus()

arch/i386/kernel/smpboot.c:smp_prepare_cpus()
	smp_boot_cpus();

obj-$(CONFIG_X86_SMP)           += smp.o smpboot.o
