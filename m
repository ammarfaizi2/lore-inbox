Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWIYCvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWIYCvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWIYCvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:51:20 -0400
Received: from ozlabs.org ([203.10.76.45]:44453 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030195AbWIYCvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:51:20 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <45173287.8070204@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <4514663E.5050707@goop.org>
	 <1158985882.26261.60.camel@localhost.localdomain>
	 <45172AC8.2070701@goop.org>
	 <1159146974.26986.30.camel@localhost.localdomain>
	 <45173287.8070204@goop.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 12:51:16 +1000
Message-Id: <1159152678.26986.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 18:36 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > 	You're thinking of it in a convoluted way, by converting to offsets
> > from the per-cpu section, then converting it back.  How about this
> > explanation: the local cpu's versions are offset from where the compiler
> > thinks they are by __per_cpu_offset[cpu].  We set the segment base to
> > __per_cpu_offset[cpu], so "%gs:per_cpu__foo" gets us straight to the
> > local cpu version.  __per_cpu_offset[cpu] is always positive (kernel
> > image sits at bottom of kernel address space).
> >   
> 
> We're talking kernel virtual addresses, so the physical load address 
> doesn't matter, of course.
> 
> So, take this kernel I have here as an explicit example:
> 
> $ nm -n vmlinux
> [...]
> c0431100 A __per_cpu_start
> [...]
> c0433800 D per_cpu__cpu_gdt_descr
> c0433880 D per_cpu__cpu_tlbstate
> 
> 
> And say that this CPU has its percpu data allocated at 0xc100000.

That can't happen, since 0xc100000 is not in the kernel address space.
0xc1000000 is though, perhaps that's what you meant?

> So, in this case the %gs base will be loaded with 0xc100000-0xc0431100 = 
> 0x4bccef00

A negative offset, exactly, which can't happen, as I said.

Hope that clarifies?

Confused,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

