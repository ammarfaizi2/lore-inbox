Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVDDTIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDDTIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVDDTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:08:42 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:7563 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261299AbVDDTIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:08:34 -0400
Date: Mon, 4 Apr 2005 13:10:25 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 1/6]SEP initialization rework
In-Reply-To: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0504041235001.30273@montezuma.fsmlabs.com>
References: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Li Shaohua wrote:

>  linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
>  linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ++++++----
>  linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    6 ++++++
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
> --- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-03-28 09:32:30.936304248 +0800
> +++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-03-28 09:58:20.703703792 +0800
> @@ -26,6 +26,11 @@ void enable_sep_cpu(void *info)
>  	int cpu = get_cpu();
>  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
>  
> +	if (!boot_cpu_has(X86_FEATURE_SEP)) {
> +		put_cpu();
> +		return;
> +	}
> +

Do you have systems like this? Is it really skipping SEP if the boot 
processor doesn't have SEP?
