Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVCaCMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVCaCMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVCaCMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:12:23 -0500
Received: from quark.didntduck.org ([69.55.226.66]:51916 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262479AbVCaCME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:12:04 -0500
Message-ID: <424B5CFE.6010907@didntduck.org>
Date: Wed, 30 Mar 2005 21:14:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question about do_IRQ + 4k stacks
References: <20050330221042.GZ2104@hygelac>
In-Reply-To: <20050330221042.GZ2104@hygelac>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> I'm investigating some 4k stack issues with our driver, and I noticed
> this ordering in do_IRQ:
> 
> asmlinkage unsigned int do_IRQ(struct pt_regs regs)
> {
> 	...
> 
> #ifdef CONFIG_DEBUG_STACKOVERFLOW
>         /* Debugging check for stack overflow: is there less than 1KB free? */
>         {
> 	...
>         }
> #endif
> 
> 	...
> 
> #ifdef CONFIG_4KSTACKS
> 
>         for (;;) {
> 	... switch to interrupt stack
>         }
> #endif
> 
> 
> Is the intention of this stack overflow check to catch a currently
> running kernel thread that's getting low on stack space, or is the
> intent to make sure there's enough stack space to handle the incoming
> interrupt? if the later, wouldn't you want to potentially switch to
> your interrupt stack to be more accurate? (I recognize that often you
> will have switched to an empty stack, unless you have nested
> interrupts)
> 

It checks for both process context (system call or kernel thread) or 
interrupt context (nested irqs) stack overflows.

--
				Brian Gerst
