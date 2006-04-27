Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWD0SDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWD0SDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWD0SDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:03:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5266 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965047AbWD0SDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:03:12 -0400
Date: Thu, 27 Apr 2006 14:02:27 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-ID: <20060427180227.GA1404@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060427014141.06b88072.akpm@osdl.org> <pan.2006.04.27.15.47.20.688183@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pan.2006.04.27.15.47.20.688183@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 05:47:25PM +0200, Matthieu CASTET wrote:
> Hi Andrew,
> 
> Le Thu, 27 Apr 2006 01:41:41 -0700, Andrew Morton a écrit :
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/
> > 
> 
> 64 bit resources core changes in ioport.h break pnp sysfs interface.
> 
> A patch like this is needed.
> 
> Matthieu
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
> --- 1/drivers/pnp/interface.c	2006-01-03 04:21:10.000000000 +0100
> +++ 2/drivers/pnp/interface.c	2006-04-14 22:54:45.000000000 +0200
> @@ -264,7 +264,7 @@
>  			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
>  				pnp_printf(buffer," disabled\n");
>  			else
> -				pnp_printf(buffer," 0x%lx-0x%lx\n",
> +				pnp_printf(buffer," 0x%llx-0x%llx\n",
>  						pnp_port_start(dev, i),
>  						pnp_port_end(dev, i));

I think it would break on ppc64 as u64 is unsigned long. It should be
explicitly typecasted to unsigned long long. Same is true for all the
instances.

(unsigned long long) pnp_port_start(dev, i)

-vivek

>  		}
> @@ -275,7 +275,7 @@
>  			if (pnp_mem_flags(dev, i) & IORESOURCE_DISABLED)
>  				pnp_printf(buffer," disabled\n");
>  			else
> -				pnp_printf(buffer," 0x%lx-0x%lx\n",
> +				pnp_printf(buffer," 0x%llx-0x%llx\n",
>  						pnp_mem_start(dev, i),
>  						pnp_mem_end(dev, i));
>  		}
> @@ -286,7 +286,7 @@
>  			if (pnp_irq_flags(dev, i) & IORESOURCE_DISABLED)
>  				pnp_printf(buffer," disabled\n");
>  			else
> -				pnp_printf(buffer," %ld\n",
> +				pnp_printf(buffer," %lld\n",
>  						pnp_irq(dev, i));
>  		}
>  	}
> @@ -296,7 +296,7 @@
>  			if (pnp_dma_flags(dev, i) & IORESOURCE_DISABLED)
>  				pnp_printf(buffer," disabled\n");
>  			else
> -				pnp_printf(buffer," %ld\n",
> +				pnp_printf(buffer," %lld\n",
>  						pnp_dma(dev, i));
>  		}
>  	}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
