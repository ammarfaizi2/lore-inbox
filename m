Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVA0BbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVA0BbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVA0B2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 20:28:38 -0500
Received: from fmr15.intel.com ([192.55.52.69]:64725 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262522AbVA0ACa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 19:02:30 -0500
Subject: Re: 2.6.11-rc2-mm1 strange messages
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
In-Reply-To: <20050125102834.7e549322.akpm@osdl.org>
References: <20050125102834.7e549322.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1106784100.11830.430.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Jan 2005 19:01:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 13:28, Andrew Morton wrote:
> Norbert Preining <preining@logic.at> wrote:
> >
> > ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @
> 0x00000000
> >  Built 1 zonelists
> >  __iounmap: bad address c00fffd9
> 
> Can you please add this?
> 
> --- 25/arch/i386/mm/ioremap.c~iounmap-debugging 2005-01-25
> 10:26:29.448809152 -0800
> +++ 25-akpm/arch/i386/mm/ioremap.c      2005-01-25 10:27:07.054092280
> -0800
> @@ -233,7 +233,8 @@ void iounmap(volatile void __iomem *addr
>                 return; 
>         p = remove_vm_area((void *) (PAGE_MASK & (unsigned long
> __force) addr));
>         if (!p) { 
> -               printk("__iounmap: bad address %p\n", addr);
> +               printk("iounmap: bad address %p\n", addr);
> +               dump_stack();
>                 return;
>         }
>  
> _
> 

Better yet, can you please add this?

http://lkml.org/lkml/2005/1/3/136


