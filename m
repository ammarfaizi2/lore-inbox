Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVAOHlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVAOHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVAOHlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:41:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:59845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbVAOHlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:41:07 -0500
Date: Fri, 14 Jan 2005 23:40:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ak@suse.de, manpreet@fabric7.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-Id: <20050114234026.02feff01.akpm@osdl.org>
In-Reply-To: <1105774495.12263.21.camel@localhost.localdomain>
References: <20050115040951.GC13525@wotan.suse.de>
	<1105765760.12263.12.camel@localhost.localdomain>
	<20050115052311.GC22863@wotan.suse.de>
	<1105774495.12263.21.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>   static inline void do_timer_interrupt_hook(struct pt_regs *regs)
>   {
>  -	do_timer(regs);
>  +	/* i386 brings up CPU before core is setup. */
>  +	if (unlikely(!cpu_online(smp_processor_id())))
>  +		jiffies64++;
>  +	else
>  +		do_timer(regs);

I thik I preferred Andi's approach - it adds code which is largely dropped
from the memory.  This patch adds a test-n-branch to every timer interrupt..
