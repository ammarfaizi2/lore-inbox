Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWDNVIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWDNVIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWDNVIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:08:00 -0400
Received: from main.gmane.org ([80.91.229.2]:61830 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965164AbWDNVIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:08:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
Date: Fri, 14 Apr 2006 23:07:39 +0200
Message-ID: <pan.2006.04.14.21.07.29.813656@free.fr>
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: fastboot@lists.osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Thu, 23 Mar 2006 14:59:44 -0500, Vivek Goyal a écrit :
 
>  #include <linux/compiler.h>
> +#include <linux/types.h>
>  /*
>   * Resources are tree-like, allowing
>   * nesting etc..
>   */
>  struct resource {
> +	u64 start, end;
>  	const char *name;
> -	unsigned long start, end;
>  	unsigned long flags;
>  	struct resource *parent, *sibling, *child;
>  };

This patch break pnp resource printf in /sys/bus/pnp/*/resources .

Something like this should solve the problem

--- 1/drivers/pnp/interface.c	2006-01-03 04:21:10.000000000 +0100
+++ 2/drivers/pnp/interface.c	2006-04-14 22:54:45.000000000 +0200
@@ -264,7 +264,7 @@
 			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," 0x%lx-0x%lx\n",
+				pnp_printf(buffer," 0x%llx-0x%llx\n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
 		}
@@ -275,7 +275,7 @@
 			if (pnp_mem_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," 0x%lx-0x%lx\n",
+				pnp_printf(buffer," 0x%llx-0x%llx\n",
 						pnp_mem_start(dev, i),
 						pnp_mem_end(dev, i));
 		}
@@ -286,7 +286,7 @@
 			if (pnp_irq_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," %ld\n",
+				pnp_printf(buffer," %lld\n",
 						pnp_irq(dev, i));
 		}
 	}
@@ -296,7 +296,7 @@
 			if (pnp_dma_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," %ld\n",
+				pnp_printf(buffer," %lld\n",
 						pnp_dma(dev, i));
 		}
 	}

