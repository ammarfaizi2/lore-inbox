Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756336AbWK1WbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbWK1WbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756325AbWK1WbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:31:15 -0500
Received: from ns2.suse.de ([195.135.220.15]:17040 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755492AbWK1WbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:31:15 -0500
Date: Tue, 28 Nov 2006 14:30:58 -0800
From: Greg KH <greg@kroah.com>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
Message-ID: <20061128223058.GC16152@kroah.com>
References: <20061128020246.47e481eb.akpm@osdl.org> <200611281235.45087.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611281235.45087.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 12:35:43PM +0100, Mariusz Kozlowski wrote:
> Hello,
> 
> 	When CONFIG_MODULE_UNLOAD is not set then this happens:
> 
>   CC      kernel/module.o
> kernel/module.c:852: error: `initstate' undeclared here (not in a function)
> kernel/module.c:852: error: initializer element is not constant
> kernel/module.c:852: error: (near initialization for `modinfo_attrs[2]')
> make[1]: *** [kernel/module.o] Error 1
> make: *** [kernel] Error 2
> 
> Reference to 'initstate' should stay under #ifdef CONFIG_MODULE_UNLOAD
> as its definition I guess.
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
> --- linux-2.6.19-rc6-mm2-a/kernel/module.c      2006-11-28 12:17:09.000000000 +0100
> +++ linux-2.6.19-rc6-mm2-b/kernel/module.c      2006-11-28 12:05:01.000000000 +0100
> @@ -849,8 +849,8 @@ static inline void module_unload_init(st
>  static struct module_attribute *modinfo_attrs[] = {
>         &modinfo_version,
>         &modinfo_srcversion,
> -       &initstate,
>  #ifdef CONFIG_MODULE_UNLOAD
> +       &initstate,
>         &refcnt,
>  #endif

Kay, is this correct?  I think we still need this information exported
to userspace, even if we can't unload modules, right?

thanks,

greg k-h
