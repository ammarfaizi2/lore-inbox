Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWARKfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWARKfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWARKfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:35:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964782AbWARKfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:35:52 -0500
Date: Wed, 18 Jan 2006 02:35:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ntl@pobox.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com, torvalds@osdl.org
Subject: Re: [patch] turn on might_sleep() in early bootup code too
Message-Id: <20060118023509.50fe2701.akpm@osdl.org>
In-Reply-To: <20060118091834.GA21366@elte.hu>
References: <200601180032.46867.michael@ellerman.id.au>
	<20060117140050.GA13188@elte.hu>
	<200601181119.39872.michael@ellerman.id.au>
	<20060118033239.GA621@cs.umn.edu>
	<20060118063732.GA21003@elte.hu>
	<20060117225304.4b6dd045.akpm@osdl.org>
	<20060118072815.GR2846@localhost.localdomain>
	<20060117233734.506c2f2e.akpm@osdl.org>
	<20060118080828.GA2324@elte.hu>
	<20060118002459.3bc8f75a.akpm@osdl.org>
	<20060118091834.GA21366@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>  enable might_sleep() checks even in early bootup code (when system_state 
>  != SYSTEM_RUNNING). There's also a new config option to turn this off:
>  CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
>  while most other architectures.

I get just the one on ppc64:


Debug: sleeping function called from invalid context at include/asm/semaphore.h:62
in_atomic():1, irqs_disabled():1
Call Trace:
[C0000000004EFD20] [C00000000000F660] .show_stack+0x5c/0x1cc (unreliable)
[C0000000004EFDD0] [C000000000053214] .__might_sleep+0xbc/0xe0
[C0000000004EFE60] [C000000000413D1C] .lock_kernel+0x50/0xb0
[C0000000004EFEF0] [C0000000004AC574] .start_kernel+0x1c/0x278
[C0000000004EFF90] [C0000000000085D4] .hmt_init+0x0/0x2c


Your fault ;)
