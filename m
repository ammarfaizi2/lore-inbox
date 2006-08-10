Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWHJTsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWHJTsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWHJTsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:48:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38028 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932660AbWHJTro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:47:44 -0400
Subject: Re: [PATCH for review] [3/145] i386: Allow to use GENERICARCH for
	UP kernels
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Keith Mannthey <kmannth@us.ibm.com>
In-Reply-To: <20060810193515.0E65213B90@wotan.suse.de>
References: <20060810 935.775038000@suse.de>
	 <20060810193515.0E65213B90@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:47:31 -0700
Message-Id: <1155239251.19249.268.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 21:35 +0200, Andi Kleen wrote:
> --- linux.orig/include/asm-i386/mach-summit/mach_apic.h
> +++ linux/include/asm-i386/mach-summit/mach_apic.h
> @@ -46,10 +46,12 @@ extern u8 cpu_2_logical_apicid[];
>  static inline void init_apic_ldr(void)
>  {
>         unsigned long val, id;
> -       int i, count;
> -       u8 lid;
> +       int count = 0;
>         u8 my_id = (u8)hard_smp_processor_id();
>         u8 my_cluster = (u8)apicid_cluster(my_id);
> +#ifdef CONFIG_SMP
> +       u8 lid;
> +       int i;
>  
>         /* Create logical APIC IDs by counting CPUs already in cluster. */
>         for (count = 0, i = NR_CPUS; --i >= 0; ) {
> @@ -57,6 +59,7 @@ static inline void init_apic_ldr(void)
>                 if (lid != BAD_APICID && apicid_cluster(lid) == my_cluster)
>                         ++count;
>         }
> +#endif 

Why does this particular loop have to go?  I'm sure it's OK, but I also
wonder if there is a nice way to do it without the #ifdef.

-- Dave

