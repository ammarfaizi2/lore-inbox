Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWJFRXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWJFRXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWJFRXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:23:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:19928 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030181AbWJFRXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:23:45 -0400
Subject: Re: [PATCH] make mach-generic/summit.c compile on UP
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Jiri Kosina <jikos@jikos.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610061109360.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
	 <1160080292.5664.9.camel@keithlap>
	 <Pine.LNX.4.64.0610052308000.12556@twin.jikos.cz>
	 <1160087093.5664.14.camel@keithlap>
	 <Pine.LNX.4.64.0610061109360.12556@twin.jikos.cz>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Fri, 06 Oct 2006 10:23:41 -0700
Message-Id: <1160155421.5663.1.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:11 +0200, Jiri Kosina wrote:
> On Thu, 5 Oct 2006, keith mannthey wrote:
> 
> > Yea I am pretty sure CONFIG_X86_GENERIC is ment to boot UP and SMP 
> > kernels.
> >  Maybe just moving apicid_2_node to a UP safe location would be a good 
> > way to go as well.  I overlooked the fact that CONFIG_X86_GENERIC wasn't 
> > always SMP.
> 
> Below is the patch doing exactly this. Fixes compilation of Linus' git 
> tree, applicable also to -mm. Please apply.
> 
> [PATCH] make kernels with CONFIG_X86_GENERIC and !CONFIG_SMP compilable
> 
> CONFIG_X86_GENERIC is not exclusively CONFIG_SMP, as mach-default/ could
> be compiled also for UP archs. The patch fixes compilation error in 
> include/asm/mach-summit/mach_apic.h in case CONFIG_X86_GENERIC && !CONFIG_SMP
> 
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> 
>  include/asm-i386/smp.h                   |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/include/asm-i386/smp.h
> +++ b/include/asm-i386/smp.h
> @@ -46,8 +46,6 @@ extern u8 x86_cpu_to_apicid[];
>  
>  #define cpu_physical_id(cpu)	x86_cpu_to_apicid[cpu]
>  
> -extern u8 apicid_2_node[];
> -
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void cpu_exit_clear(void);
>  extern void cpu_uninit(void);
> @@ -101,6 +99,9 @@ #define NO_PROC_ID		0xFF		/* No processo
>  #endif
>  
>  #ifndef __ASSEMBLY__
> +
> +extern u8 apicid_2_node[];
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static __inline int logical_smp_processor_id(void)
>  {

Look good to me.  Thanks for fixing this. 

Acked-by: Keith Mannthey <kmannth@us.ibm.com>

