Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265103AbUFAQZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbUFAQZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUFAQYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:24:08 -0400
Received: from main.gmane.org ([80.91.224.249]:43407 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265103AbUFAQWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:22:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: 2.6.7-rc2-mm1
Date: Tue, 01 Jun 2004 12:22:19 -0400
Message-ID: <c9iafp$r6g$1@sea.gmane.org>
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011159.23532@zodiac.zodiac.dnsalias.org> <20040601202839.01c8a220.akiyama.nobuyuk@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
In-Reply-To: <20040601202839.01c8a220.akiyama.nobuyuk@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost. It looks like the #ifdefs should be changed to 
CONFIG_X86_LOCAL_APIC, since without it, nmi.c never gets built.

AKIYAMA Nobuyuki wrote:

>>config attached, plain 2.6.7-rc2-mm1, only with dsdt patch for my laptop.
> 
> 
> Please try the patch below.
> 
> diff -Nur linux-2.6.7-rc2-mm1.org/kernel/sysctl.c linux-2.6.7-rc2-mm1/kernel/sysctl.c
> --- linux-2.6.7-rc2-mm1.org/kernel/sysctl.c	2004-06-01 19:47:22.000000000 +0900
> +++ linux-2.6.7-rc2-mm1/kernel/sysctl.c	2004-06-01 20:21:13.000000000 +0900
> @@ -63,7 +63,7 @@
>  extern int printk_ratelimit_jiffies;
>  extern int printk_ratelimit_burst;
>  
> -#if defined(__i386__)
> +#ifdef CONFIG_X86
>  extern int unknown_nmi_panic;
>  extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
>  				  void __user *, size_t *);
> @@ -624,7 +624,7 @@
>  		.mode		= 0444,
>  		.proc_handler	= &proc_dointvec,
>  	},
> -#if defined(__i386__)
> +#ifdef CONFIG_X86
>  	{
>  		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
>  		.procname       = "unknown_nmi_panic",
> 
> 

