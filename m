Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWIYFei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWIYFei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 01:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWIYFei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 01:34:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751555AbWIYFeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 01:34:37 -0400
Date: Sun, 24 Sep 2006 22:34:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 pda patches
Message-Id: <20060924223427.6f42e77c.akpm@osdl.org>
In-Reply-To: <4517256E.10606@goop.org>
References: <20060924013521.13d574b1.akpm@osdl.org>
	<4517256E.10606@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 17:40:14 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > I am unable to correlate what's in Andi's tree with the PDA-related emails
> > on this list.  Why is this?
> >   
> 
> I'm not sure what's in Andi's tree.  He mentioned that he had trouble 
> merging a previous patch I had, but it wasn't a particularly big change.
> 
> Andi, where can I get your tree?
> 
> > Anyway, the PDA patches are causing my little old dual-pIII to reboot about
> > one second into the boot process.
> >   
> 
> Interesting.  Have there been any other complaints about -mm crashing?  
> There's nothing in here which is "new cpu"; it should work the same all 
> the way back to an i386.

It may be related to the .config, rather than the CPU type.

> > Bisection says:
> >
> > x86_64-mm-i386-pda-asm-offsets.patch
> > x86_64-mm-i386-pda-basics.patch                         OK
> > x86_64-mm-i386-pda-init-pda.patch                       oops
> > x86_64-mm-i386-pda-use-gs.patch				reboot
> > x86_64-mm-i386-pda-user-abi.patch                       BAD
> > x86_64-mm-i386-pda-vm86.patch
> > x86_64-mm-i386-pda-smp-processorid.patch
> > x86_64-mm-i386-pda-current.patch
> >
> >
> > So x86_64-mm-i386-pda-init-pda.patch causes the below oops and
> > x86_64-mm-i386-pda-use-gs.patch causes the instareboot.
> >
> >
> >
> > Compat vDSO mapped to ffffe000.
> > Checking 'hlt' instruction... OK.
> > SMP alternatives: switching to UP code
> > CPU0: Intel Pentium III (Coppermine) stepping 03
> > SMP alternatives: switching to SMP code
> > Booting processor 1/1 eip 2000
> > Initializing CPU#1
> > general protection fault: 0080 [#1]
> > SMP 
> > last sysfs file: 
> > Modules linked in:
> > CPU:    1
> > EIP:    0060:[<c010ad63>]    Not tainted VLI
> > EFLAGS: 00010086   (2.6.18 #8) 
> > EIP is at cpu_init+0x153/0x2b0
> >   
> What line does this EIP correspond to?
> 

(gdb) l *0xc010ad63
0xc010ad63 is in cpu_init (arch/i386/kernel/cpu/common.c:748).
743                     BUG();
744             enter_lazy_tlb(&init_mm, current);
745     
746             load_esp0(t, thread);
747             set_tss_desc(cpu,t);
748             load_TR_desc();
749             load_LDT(&init_mm.context);
750     
751     #ifdef CONFIG_DOUBLEFAULT
752             /* Set up doublefault TSS pointer in the GDT */


