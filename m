Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWIKGCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWIKGCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 02:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWIKGCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 02:02:52 -0400
Received: from rex.snapgear.com ([203.143.235.140]:2233 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S964899AbWIKGCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 02:02:52 -0400
Message-ID: <4504FC01.5000805@snapgear.com>
Date: Mon, 11 Sep 2006 16:02:41 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: m68knommu: dma_{alloc,free}_coherent compile error
References: <20060905181716.GG9173@stusta.de>
In-Reply-To: <20060905181716.GG9173@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Adrian Bunk wrote:
> I'm getting the following compile error trying to compile 2.6.18-rc5-mm1 
> (but it doesn't seem to be specific to -mm) for m68knommu with 
> CONFIG_PCI=n (with -Werror-implicit-function-declaration):
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/base/dmapool.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c: In function 'pool_alloc_page':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c:170: error: implicit declaration of function 'dma_alloc_coherent'
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c:173: warning: assignment makes pointer from integer without a cast
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c: In function 'pool_free_page':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c:208: error: implicit declaration of function 'dma_free_coherent'
> make[3]: *** [drivers/base/dmapool.o] Error 1
> 
> <--  snip  -->

This should fix it?

--- linux-2.6.17/include/asm-m68knommu/dma-mapping.h    2006-06-18 
11:49:35.000000000 +1000
+++ linux-2.6.17-uc1/include/asm-m68knommu/dma-mapping.h 
2006-09-11 15:51:04.000000000 +1000
@@ -1,10 +1,10 @@
  #ifndef _M68KNOMMU_DMA_MAPPING_H
  #define _M68KNOMMU_DMA_MAPPING_H

-#include <linux/config.h>
-
  #ifdef CONFIG_PCI
  #include <asm-generic/dma-mapping.h>
+#else
+#include <asm-generic/dma-mapping-broken.h>
  #endif

  #endif  /* _M68KNOMMU_DMA_MAPPING_H */


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a Secure Computing Company      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
