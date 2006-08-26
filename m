Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422961AbWHZENz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbWHZENz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422962AbWHZENz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 00:13:55 -0400
Received: from xenotime.net ([66.160.160.81]:49793 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422961AbWHZENy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 00:13:54 -0400
Date: Fri, 25 Aug 2006 21:17:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kmannth@gmail.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: another NUMA build error
Message-Id: <20060825211705.68e6a1dc.rdunlap@xenotime.net>
In-Reply-To: <20060826105639.5680429d.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
	<20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825103507.4f2d193e.rdunlap@xenotime.net>
	<a762e240608251544t2e15ec8dq5a8f95f02eecb0a4@mail.gmail.com>
	<20060825160115.7f768797.rdunlap@xenotime.net>
	<20060826105639.5680429d.kamezawa.hiroyu@jp.fujitsu.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> Hmm... is this the way to go ?
> Keith-san, please ack if Okay.

Works for me.  No build errors.  Thanks.
There are a couple of typos noted below that could be fixed up.

> --
> When we select NUMA with i386, the system is only X86_NUMAQ or using ACPI.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Index: linux-2.6.18-rc4/arch/i386/Kconfig
> ===================================================================
> --- linux-2.6.18-rc4.orig/arch/i386/Kconfig
> +++ linux-2.6.18-rc4/arch/i386/Kconfig
> @@ -142,6 +142,7 @@ config X86_SUMMIT
>  	  In particular, it is needed for the x440.
>  
>  	  If you don't have one of these computers, you should say N here.
> +	  If you want to build NUMA kernel, you have to select ACPI

		end with '.'

>  
>  config X86_BIGSMP
>  	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
> @@ -169,6 +170,7 @@ config X86_GENERICARCH
>         help
>            This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
>  	  It is intended for a generic binary kernel.
> +	  if you want NUMA kernel, select ACPI. we need SRAT for build NUMA

	  If you want a NUMA kernel, enable ACPI. We need SRAT to build NUMA.

>  
>  config X86_ES7000
>  	bool "Support for Unisys ES7000 IA32 series"
> @@ -542,7 +544,7 @@ config X86_PAE
>  # Common NUMA Features
>  config NUMA
>  	bool "Numa Memory Allocation and Scheduler Support"
> -	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
> +	depends on SMP && HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT || X86_GENERICARCH) && ACPI)
>  	default n if X86_PC
>  	default y if (X86_NUMAQ || X86_SUMMIT)


---
~Randy
