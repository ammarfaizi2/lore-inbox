Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWIWINk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWIWINk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWIWINk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:13:40 -0400
Received: from colin.muc.de ([193.149.48.1]:37392 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751050AbWIWINj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:13:39 -0400
Date: 23 Sep 2006 10:13:37 +0200
Date: Sat, 23 Sep 2006 10:13:37 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Message-ID: <20060923081337.GA10534@muc.de>
References: <1158925861.26261.3.camel@localhost.localdomain> <1158925997.26261.6.camel@localhost.localdomain> <1158926106.26261.8.camel@localhost.localdomain> <1158926215.26261.11.camel@localhost.localdomain> <1158926308.26261.14.camel@localhost.localdomain> <1158926386.26261.17.camel@localhost.localdomain> <4514663E.5050707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4514663E.5050707@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >+
> >+	/* Set up GDT entry for 16bit stack */
> >+	stk16_off = (u32)&per_cpu(cpu_16bit_stack, cpu);
> >+	gdt = per_cpu(cpu_gdt_table, cpu);
> >+	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
> >+		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
> >+		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
> >+		(CPU_16BIT_STACK_SIZE - 1);
> >  
> 
> This should use pack_descriptor().  I'd never got around to changing it, 
> but it really should.

I fixed it now in the original patch

> >+	/* Complete percpu area setup early, before calling printk(),
> >+	   since it may end up using it indirectly. */
> >+	setup_percpu_for_this_cpu(cpu);
> >+
> >  
> 
> I managed to get all this done in head.S before going into C code; is 
> that not still possible?  Or is there a later patch to do this.

Why write in assembler what you can write in C?

-Andi
