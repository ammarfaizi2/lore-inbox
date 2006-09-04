Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWIDAu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWIDAu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 20:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWIDAu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 20:50:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751218AbWIDAu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 20:50:57 -0400
Date: Sun, 3 Sep 2006 17:50:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Matthias Hentges" <oe@hentges.net>,
       "Jeremy Fitzhardinge" <jeremy@goop.org>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
Subject: Re: 2.6.18-rc5-mm1
Message-Id: <20060903175048.6fed40ab.akpm@osdl.org>
In-Reply-To: <EB12A50964762B4D8111D55B764A84548839C0@scsmsx413.amr.corp.intel.com>
References: <EB12A50964762B4D8111D55B764A84548839C0@scsmsx413.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2006 17:22:17 -0700
"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

>  
> 
> >-----Original Message-----
> >From: Andrew Morton [mailto:akpm@osdl.org] 
> >Sent: Friday, September 01, 2006 6:30 PM
> >To: Matthias Hentges
> >Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; 
> >Pallipadi, Venkatesh
> >Subject: Re: 2.6.18-rc5-mm1
> >
> >On Sat, 02 Sep 2006 03:00:47 +0200
> >Matthias Hentges <oe@hentges.net> wrote:
> >
> >> 2.6.18-rc5-mm1 oopses on an Asus P5W DH Deluxe board, full dmesg
> >> attached.
> >> This did not happen in 2.6.18-rc4-mm3.
> >> 
> >> 
> >> BUG: unable to handle kernel NULL pointer dereference at 
> >virtual address
> >> 00000000
> >>  printing eip:
> >> 00000000
> >> *pde = 00000000
> >> Oops: 0000 [#1]
> >> 4K_STACKS SMP 
> >> last sysfs file: 
> >> Modules linked in:
> >> CPU:    0
> >> EIP:    0060:[<00000000>]    Not tainted VLI
> >> EFLAGS: 00010087   (2.6.18-rc5-mm1 #1) 
> >> EIP is at rest_init+0x3feffd78/0x20
> >> eax: 000000da   ebx: c04d5f78   ecx: c04d5f94   edx: c04d2f00
> >> esi: 000000da   edi: 00000000   ebp: c04d2f00   esp: c0516ffc
> >> ds: 007b   es: 007b   ss: 0068
> >> Process swapper (pid: 0, ti=c0516000 task=c045c200 task.ti=c04d5000)
> >> Stack: c0105027 
> >> Call Trace:
> >>  [<c0105027>] do_IRQ+0x8a/0xac
> >>  [<c01035a6>] common_interrupt+0x1a/0x20
> >>  [<c0101a72>] mwait_idle_with_hints+0x36/0x3b
> >>  [<c0101a83>] mwait_idle+0xc/0x1b
> >>  [<c0101a26>] cpu_idle+0x5e/0x74
> >>  [<c04db6fa>] start_kernel+0x363/0x36a
> >>  =======================
> >> Code:  Bad EIP value.
> >> EIP: [<00000000>] rest_init+0x3feffd78/0x20 SS:ESP 0068:c0516ffc
> >>  <0>Kernel panic - not syncing: Fatal exception in interrupt
> >>  BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
> >>  [<c010ca45>] smp_call_function+0x54/0xff
> >>  [<c011a270>] printk+0x12/0x16
> >>  [<c010cb03>] smp_send_stop+0x13/0x1c
> >>  [<c0119480>] panic+0x49/0xd3
> >>  [<c010410c>] die+0x273/0x28a
> >>  [<c01126d4>] do_page_fault+0x40d/0x4db
> >>  [<c01122c7>] do_page_fault+0x0/0x4db
> >>  [<c03d1231>] error_code+0x39/0x40
> >>  [<c013007b>] free_module+0x89/0xc3
> >>  [<c0105027>] do_IRQ+0x8a/0xac
> >>  [<c01035a6>] common_interrupt+0x1a/0x20
> >>  [<c0101a72>] mwait_idle_with_hints+0x36/0x3b
> >>  [<c0101a83>] mwait_idle+0xc/0x1b
> >>  [<c0101a26>] cpu_idle+0x5e/0x74
> >>  [<c04db6fa>] start_kernel+0x363/0x36a
> >>  =======================
> >
> >OK, thanks.  That'll be acpi-mwait-c-state-fixes.patch.  I've 
> >uploaded the
> >below revert patch to
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
> >.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/
> >
> 
> Andrew,
> 
> As this patch doesn't seem to be the issue here, can you un-revert the
> patch in mm...
> 

Spose so.

But what _did_ cause it?  Looks like we took an IRQ and then leapt into
outer space, when do_IRQ() called desc->handle_irq().

Matthias, could you please test with CONFIG_4KSTACKS=n?

Also, one cause of this might be a module which fails to clean up when it's
removed.  And the trace indicates that some module has previously
been unloaded.  Can you work out which module(s) that might be?


-- 
VGER BF report: H 0
