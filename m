Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUGIWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUGIWLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUGIWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:11:54 -0400
Received: from holomorphy.com ([207.189.100.168]:27520 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266003AbUGIWLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:11:44 -0400
Date: Fri, 9 Jul 2004 15:11:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-ID: <20040709221140.GC21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040708235025.5f8436b7.akpm@osdl.org> <20040709210423.GB21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709210423.GB21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:04:23PM -0700, William Lee Irwin III wrote:
> In file included from include/asm/sbus.h:10,
>                  from arch/sparc64/kernel/auxio.c:15:
> include/linux/dma-mapping.h: In function `dma_mark_declared_memory_occupied':
> include/linux/dma-mapping.h:47: warning: implicit declaration of function `ERR_PTR'
> include/linux/dma-mapping.h:47: error: `EBUSY' undeclared (first use in this function)
> include/linux/dma-mapping.h:47: error: (Each undeclared identifier is reported only once
> include/linux/dma-mapping.h:47: error: for each function it appears in.)
> include/linux/dma-mapping.h:47: warning: return makes pointer from integer without a cast

compilefix for sparc64 suggested by hch and jejb:


Index: mm7-2.6.7/include/linux/dma-mapping.h
===================================================================
--- mm7-2.6.7.orig/include/linux/dma-mapping.h	2004-07-09 13:54:32.444030032 -0700
+++ mm7-2.6.7/include/linux/dma-mapping.h	2004-07-09 14:54:05.996767440 -0700
@@ -1,6 +1,8 @@
 #ifndef _ASM_LINUX_DMA_MAPPING_H
 #define _ASM_LINUX_DMA_MAPPING_H
 
+#include <linux/err.h>
+
 /* These definitions mirror those in pci.h, so they can be used
  * interchangeably with their PCI_ counterparts */
 enum dma_data_direction {
