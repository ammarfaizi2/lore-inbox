Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUE2LCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUE2LCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUE2LCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:02:15 -0400
Received: from aun.it.uu.se ([130.238.12.36]:45769 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264251AbUE2LCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:02:12 -0400
Date: Sat, 29 May 2004 13:02:07 +0200 (MEST)
Message-Id: <200405291102.i4TB276N012365@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [RFC,PATCH] use nonatomic bitops for cpumask_t
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004 10:57:21 +0200, Manfred Spraul wrote:
>The default implementation for cpumasks in <asm-generic/cpumask*> uses 
>atomic bitops for the operations that affect a single cpu and nonatomic 
>operations for the rest.
>What about switching to nonatomic operations for all operations? I'm 
>checking for callers that rely on the atomicity of the bitops, but so 
>far everyone has it's own locks.

The perfctr kernel extension (not yet merged) calls
cpu_set() from a function invoked via smp_call_function(),
relying on cpu_set() being atomic.

I can take a spinlock there, but it seems ugly when an
atomic set_bit would suffice.

Also, may I request that when changing a fundamental aspect
of the semantics of an operation, you also change its name?
That way, unconverted code will get a compile or link error
rather than breaking at runtime.

/Mikael
