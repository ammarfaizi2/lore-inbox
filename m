Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVHWKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVHWKdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVHWKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 06:33:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54710 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751309AbVHWKdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 06:33:05 -0400
Date: Tue, 23 Aug 2005 12:32:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] Add MCE resume under ia32
Message-ID: <20050823103256.GB2795@elf.ucw.cz>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124762500.3013.3.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It's widely seen a MCE non-fatal error reported after resume. It seems
> MCE resume is lacked under ia32. This patch tries to fix the gap.

Well, you patch seems like missing piece of puzzle, but:

a) we probably want to do it for x86-64, too, and 

b)

> diff -puN arch/i386/power/cpu.c~mcheck_resume arch/i386/power/cpu.c
> --- linux-2.6.13-rc6/arch/i386/power/cpu.c~mcheck_resume	2005-08-23 09:32:13.054008584 +0800
> +++ linux-2.6.13-rc6-root/arch/i386/power/cpu.c	2005-08-23 09:41:54.992540480 +0800
> @@ -104,6 +104,8 @@ static void fix_processor_context(void)
>  
>  }
>  
> +extern void mcheck_init(struct cpuinfo_x86 *c);
> +
>  void __restore_processor_state(struct saved_context *ctxt)
>  {
>  	/*


this should go to some header file and most importantly

> @@ -138,6 +140,9 @@ void __restore_processor_state(struct sa
>  	fix_processor_context();
>  	do_fpu_end();
>  	mtrr_ap_init();
> +#ifdef CONFIG_X86_MCE
> +	mcheck_init(&boot_cpu_data);
> +#endif
>  }

c) can't we register MCEs like some kind of system device so that this
kind of hooks is not neccessary?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
