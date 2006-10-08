Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWJHNCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWJHNCM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWJHNCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:02:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47806 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751133AbWJHNCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:02:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] HT_IRQ must depend on PCI
References: <20061008040638.GF29474@stusta.de>
Date: Sun, 08 Oct 2006 07:00:31 -0600
In-Reply-To: <20061008040638.GF29474@stusta.de> (Adrian Bunk's message of
	"Sun, 8 Oct 2006 06:06:38 +0200")
Message-ID: <m1odsnufm8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

Looks good to me.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

> CONFIG_PCI=n, CONFIG_HT_IRQ=y results in the following compile error:
>
> <--  snip  -->
>
> ...
>   LD      vmlinux
> arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
> summit.c:(.text+0x53): undefined reference to `apicid_2_node'
> arch/i386/kernel/built-in.o: In function `arch_setup_ht_irq':
> (.text+0xcf79): undefined reference to `write_ht_irq_low'
> arch/i386/kernel/built-in.o: In function `arch_setup_ht_irq':
> (.text+0xcf85): undefined reference to `write_ht_irq_high'
> arch/i386/kernel/built-in.o: In function `k7nops':
> alternative.c:(.data+0x1358): undefined reference to `mask_ht_irq'
> alternative.c:(.data+0x1360): undefined reference to `unmask_ht_irq'
> make[1]: *** [vmlinux] Error 1
>
> <--  snip  -->
>
> Bug report by Jesper Juhl.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6/drivers/pci/Kconfig.old	2006-10-08 05:55:51.000000000 +0200
> +++ linux-2.6/drivers/pci/Kconfig	2006-10-08 05:56:14.000000000 +0200
> @@ -55,7 +55,7 @@
>  config HT_IRQ
>  	bool "Interrupts on hypertransport devices"
>  	default y
> -	depends on X86_LOCAL_APIC && X86_IO_APIC
> +	depends on PCI && X86_LOCAL_APIC && X86_IO_APIC
>  	help
>  	   This allows native hypertransport devices to use interrupts.
>  
