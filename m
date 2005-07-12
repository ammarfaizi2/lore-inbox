Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVGLJa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVGLJa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGLJa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:30:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261280AbVGLJa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:30:57 -0400
Date: Tue, 12 Jul 2005 02:30:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: [patch] Fix GDT loading during resume from suspend-to-RAM
Message-Id: <20050712023013.42b52651.akpm@osdl.org>
In-Reply-To: <20050712091400.GI1854@elf.ucw.cz>
References: <20050712091400.GI1854@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Fix GDT loading during resume from suspend-to-RAM.
> 

This change is already in Len's acpi tree.  Len, can you merge it for
2.6.13 please?


> 
> ---
> commit 523c9470749c558e002f3041f5af620acf7f3e0c
> tree 92b643196cbaa89fa54ff141bc94fee8664009b3
> parent 79b675b6cc9268d178b3c0a2af2e4f944c5fdf9b
> author <pavel@amd.(none)> Tue, 12 Jul 2005 11:13:30 +0200
> committer <pavel@amd.(none)> Tue, 12 Jul 2005 11:13:30 +0200
> 
>  arch/i386/kernel/acpi/wakeup.S |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/i386/kernel/acpi/wakeup.S b/arch/i386/kernel/acpi/wakeup.S
> --- a/arch/i386/kernel/acpi/wakeup.S
> +++ b/arch/i386/kernel/acpi/wakeup.S
> @@ -74,8 +74,9 @@ wakeup_code:
>  	movw	%ax,%fs
>  	movw	$0x0e00 + 'i', %fs:(0x12)
>  	
> -	# need a gdt
> -	lgdt	real_save_gdt - wakeup_code
> +	# need a gdt -- use lgdtl to force 32-bit operands, in case
> +	# the GDT is located past 16 megabytes
> +	lgdtl	real_save_gdt - wakeup_code
>  
>  	movl	real_save_cr0 - wakeup_code, %eax
>  	movl	%eax, %cr0
> 
> -- 
> teflon -- maybe it is a trademark, but it should not be.
