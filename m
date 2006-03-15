Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752083AbWCOGUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbWCOGUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWCOGUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:20:15 -0500
Received: from fmr17.intel.com ([134.134.136.16]:28372 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752083AbWCOGUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:20:14 -0500
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it
	on 2.6.16-rc6
From: Shaohua Li <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       olel@ans.pl, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, ak@muc.de
In-Reply-To: <20060315054416.GF3205@localhost.localdomain>
References: <20060315054416.GF3205@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 14:18:20 +0800
Message-Id: <1142403500.26706.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 13:44 +0800, Nathan Lynch wrote:
> Ashok Raj wrote: 
> > On Mon, Mar 13, 2006 at 02:22:23PM -0800, Andrew Morton wrote: 
> > >  
> > > And does it affect pretend-x86-hotplug, or is it only affecting
> real hotplug? 
> > >  
> > its no more pretend-x86, in the past we used to put the cpu in
> idle(),  
> > now we do put the cpu in halt and bring back by another startup ipi,
> just like  
> > boot sequence, both for x86 and x86_64.
> 
> That's actually broken since 2.6.14 (at least on my P3 box); please 
> see:
> 
> Subject: i386 cpu hotplug bug - instant reboot when onlining secondary
> 
> http://lkml.org/lkml/2006/2/19/186
Works for me. But I saw a warning.

---

 linux-2.6.15-root/arch/i386/kernel/cpu/common.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/common.c~cpuhp arch/i386/kernel/cpu/common.c
--- linux-2.6.15/arch/i386/kernel/cpu/common.c~cpuhp	2006-03-14 12:13:43.000000000 +0800
+++ linux-2.6.15-root/arch/i386/kernel/cpu/common.c	2006-03-14 12:14:12.000000000 +0800
@@ -605,7 +605,7 @@ void __devinit cpu_init(void)
 		/* alloc_bootmem_pages panics on failure, so no check */
 		memset(gdt, 0, PAGE_SIZE);
 	} else {
-		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
+		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);
 		if (unlikely(!gdt)) {
 			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
 			for (;;)
_


