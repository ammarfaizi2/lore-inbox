Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTJ0TOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTJ0TOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:14:09 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:22736 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263439AbTJ0TN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:13:59 -0500
Date: Mon, 27 Oct 2003 20:13:56 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cat /proc/bus/pnp/escd -> kernel segfault (2.6 BK)
Message-ID: <20031027191356.GA5966@merlin.emma.line.org>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031027044204.GA23976@merlin.emma.line.org> <3F9D5458.9010704@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9D5458.9010704@didntduck.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Brian Gerst wrote:

> Does this patch fix it?

Unfortunately not. I am not seeing SIGSEGV or something, the machine
freezes hard instead.

> diff -urN linux-2.6.0-test9-bk/arch/i386/mm/extable.c linux/arch/i386/mm/extable.c
> --- linux-2.6.0-test9-bk/arch/i386/mm/extable.c	2003-07-27 13:11:40.000000000 -0400
> +++ linux/arch/i386/mm/extable.c	2003-10-27 12:08:38.000000000 -0500
> @@ -34,7 +34,7 @@
>  	const struct exception_table_entry *fixup;
>  
>  #ifdef CONFIG_PNPBIOS
> -	if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
> +	if (unlikely((unsigned)(regs->xcs - (GDT_ENTRY_PNPBIOS_BASE * 8)) < 16))
>  	{
>  		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
>  		extern u32 pnp_bios_is_utter_crap;


-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
