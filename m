Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVBXOKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVBXOKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVBXOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:10:29 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:20376 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262350AbVBXOKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:10:21 -0500
Date: Thu, 24 Feb 2005 15:10:15 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-ID: <20050224141015.GA6756@gamma.logic.tuwien.ac.at>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at> <20050125102834.7e549322.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050125102834.7e549322.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Die, 25 Jan 2005, Andrew Morton wrote:
> Norbert Preining <preining@logic.at> wrote:
> >
> > ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
> >  Built 1 zonelists
> >  __iounmap: bad address c00fffd9

I still have this with 2.6.11-rc4-mm1 and the patch you proposed is
included in this kernel. Is this something I should be nervous about, or
is there a fix?

Best wishes

Norbert

> Can you please add this?
> 
> --- 25/arch/i386/mm/ioremap.c~iounmap-debugging	2005-01-25 10:26:29.448809152 -0800
> +++ 25-akpm/arch/i386/mm/ioremap.c	2005-01-25 10:27:07.054092280 -0800
> @@ -233,7 +233,8 @@ void iounmap(volatile void __iomem *addr
>  		return; 
>  	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
>  	if (!p) { 
> -		printk("__iounmap: bad address %p\n", addr);
> +		printk("iounmap: bad address %p\n", addr);
> +		dump_stack();
>  		return;
>  	}
>  
> _
> 

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SIDCUP (n.)
One of those hats made from tying knots in the corners of a
handkerchief.
			--- Douglas Adams, The Meaning of Liff
