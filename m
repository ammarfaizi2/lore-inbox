Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWIGHat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWIGHat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 03:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWIGHat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 03:30:49 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:56307 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750984AbWIGHar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 03:30:47 -0400
Date: Thu, 7 Sep 2006 09:31:11 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       avr32@atmel.com
Subject: Re: [PATCH 05/26] Dynamic kernel command-line - avr32
Message-ID: <20060907093111.1bf57c61@cad-250-152.norway.atmel.com>
In-Reply-To: <200609040118.06291.alon.barlev@gmail.com>
References: <200609040115.22856.alon.barlev@gmail.com>
	<200609040118.06291.alon.barlev@gmail.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(trimming Cc list)

On Mon, 4 Sep 2006 01:18:04 +0300
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

> 
> 1. Rename saved_command_line into boot_command_line.
> 2. Set command_line as __initdata.

Thanks. Seems to work fine with my setup.

I should probably start using that parse_early_param() stuff, though.
I'll update this patch if I do.

Now, do I add a signed-off-by line here, or an acked-by?

Haavard

> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> 
> ---
> 
> diff -urNp linux-2.6.18-rc5-mm1.org/arch/avr32/kernel/setup.c
> linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c ---
> linux-2.6.18-rc5-mm1.org/arch/avr32/kernel/setup.c	2006-09-03
> 18:56:48.000000000 +0300 +++
> linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c	2006-09-03
> 20:58:45.000000000 +0300 @@ -44,7 +44,7 @@ struct avr32_cpuinfo
> boot_cpu_data = { }; EXPORT_SYMBOL(boot_cpu_data); 
> -static char command_line[COMMAND_LINE_SIZE];
> +static char __initdata command_line[COMMAND_LINE_SIZE];
>  
>  /*
>   * Should be more than enough, but if you have a _really_ complex
> @@ -94,7 +94,7 @@ static unsigned long __initdata fbmem_si
>  
>  static void __init parse_cmdline_early(char **cmdline_p)
>  {
> -	char *to = command_line, *from = saved_command_line;
> +	char *to = command_line, *from = boot_command_line;
>  	int len = 0;
>  	char c = ' ';
>  
> @@ -226,7 +226,7 @@ __tagtable(ATAG_MEM, parse_tag_mem);
>  
>  static int __init parse_tag_cmdline(struct tag *tag)
>  {
> -	strlcpy(saved_command_line, tag->u.cmdline.cmdline,
> COMMAND_LINE_SIZE);
> +	strlcpy(boot_command_line, tag->u.cmdline.cmdline,
> COMMAND_LINE_SIZE); return 0;
>  }
>  __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
