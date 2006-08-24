Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWHXVde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWHXVde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWHXVdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:33:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30982 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422683AbWHXVdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:33:03 -0400
Date: Thu, 24 Aug 2006 23:33:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Core support for --combine -fwhole-program
Message-ID: <20060824213302.GS19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433167.3012.119.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156433167.3012.119.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:26:07PM +0100, David Woodhouse wrote:
>...
> index 0dfb794..725e5df 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
>...
> @@ -470,11 +472,12 @@ void module_add_driver(struct module *, 
>  void module_remove_driver(struct device_driver *);
>  
>  #else /* !CONFIG_MODULES... */
> -#define EXPORT_SYMBOL(sym)
> -#define EXPORT_SYMBOL_GPL(sym)
> -#define EXPORT_SYMBOL_GPL_FUTURE(sym)
> -#define EXPORT_UNUSED_SYMBOL(sym)
> -#define EXPORT_UNUSED_SYMBOL_GPL(sym)
> +
> +#define EXPORT_SYMBOL(sym) extern typeof(sym) sym __global
> +#define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
> +#define EXPORT_SYMBOL_GPL_FUTURE(sym) EXPORT_SYMBOL(sym)
> +#define EXPORT_UNUSED_SYMBOL(sym) EXPORT_SYMBOL(sym)
> +#define EXPORT_UNUSED_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
>...

If a "build everything except for assembler files at once" approach is 
possible, it should be possible to revert this and get even further 
savings.

> dwmw2

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

