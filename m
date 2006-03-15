Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWCOHea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCOHea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 02:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWCOHea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 02:34:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750954AbWCOHe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 02:34:29 -0500
Date: Tue, 14 Mar 2006 23:31:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: ntl@pobox.com, ashok.raj@intel.com, olel@ans.pl,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com, rajesh.shah@intel.com, ak@muc.de
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-Id: <20060314233138.009414b4.akpm@osdl.org>
In-Reply-To: <1142403500.26706.2.camel@sli10-desk.sh.intel.com>
References: <20060315054416.GF3205@localhost.localdomain>
	<1142403500.26706.2.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> On Wed, 2006-03-15 at 13:44 +0800, Nathan Lynch wrote:
>  > Ashok Raj wrote: 
>  > > On Mon, Mar 13, 2006 at 02:22:23PM -0800, Andrew Morton wrote: 
>  > > >  
>  > > > And does it affect pretend-x86-hotplug, or is it only affecting
>  > real hotplug? 
>  > > >  
>  > > its no more pretend-x86, in the past we used to put the cpu in
>  > idle(),  
>  > > now we do put the cpu in halt and bring back by another startup ipi,
>  > just like  
>  > > boot sequence, both for x86 and x86_64.
>  > 
>  > That's actually broken since 2.6.14 (at least on my P3 box); please 
>  > see:
>  > 
>  > Subject: i386 cpu hotplug bug - instant reboot when onlining secondary
>  > 
>  > http://lkml.org/lkml/2006/2/19/186
>  Works for me. But I saw a warning.

Guys, will you please stop being so cryptic?  What worked for you?  What
warning?  wtf is going on?  Who owns this problem, whatever it is?
<head spins>

>   linux-2.6.15-root/arch/i386/kernel/cpu/common.c |    2 +-
>   1 files changed, 1 insertion(+), 1 deletion(-)
> 
>  diff -puN arch/i386/kernel/cpu/common.c~cpuhp arch/i386/kernel/cpu/common.c
>  --- linux-2.6.15/arch/i386/kernel/cpu/common.c~cpuhp	2006-03-14 12:13:43.000000000 +0800
>  +++ linux-2.6.15-root/arch/i386/kernel/cpu/common.c	2006-03-14 12:14:12.000000000 +0800
>  @@ -605,7 +605,7 @@ void __devinit cpu_init(void)
>   		/* alloc_bootmem_pages panics on failure, so no check */
>   		memset(gdt, 0, PAGE_SIZE);
>   	} else {
>  -		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
>  +		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);

That would be rather a sad thing to have to do.  OK if it's during initial
bootup, less OK if it's during CPU hot-add.
