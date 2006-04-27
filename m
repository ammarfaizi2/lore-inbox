Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWD0Psg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWD0Psg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWD0Psg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:48:36 -0400
Received: from main.gmane.org ([80.91.229.2]:4005 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965040AbWD0Psf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:48:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: 2.6.17-rc2-mm1
Date: Thu, 27 Apr 2006 17:47:25 +0200
Message-ID: <pan.2006.04.27.15.47.20.688183@free.fr>
References: <20060427014141.06b88072.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Le Thu, 27 Apr 2006 01:41:41 -0700, Andrew Morton a écrit :

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/
> 

64 bit resources core changes in ioport.h break pnp sysfs interface.

A patch like this is needed.

Matthieu

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

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

