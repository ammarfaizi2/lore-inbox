Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUGIWLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUGIWLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGIWLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:11:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:34455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265999AbUGIWLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:11:43 -0400
Date: Fri, 9 Jul 2004 15:14:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.7-mm7
Message-Id: <20040709151448.28f1dbf7.akpm@osdl.org>
In-Reply-To: <20040709210423.GB21066@holomorphy.com>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<20040709210423.GB21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
> In file included from include/asm/sbus.h:10,
>                  from arch/sparc64/kernel/auxio.c:15:

It needs err.h.

btw, James, I'm unable to convince myself that
dma_mark_declared_memory_occupied() reserves enough pages if device_addr is
not page-aligned.  Could you double-check that?  If all callers are
expected to use a page-aligned address then a BUG_ON might be appropriate. 
Or a comment.

diff -puN include/linux/dma-mapping.h~bk-dma-declare-coherent-memory-fix include/linux/dma-mapping.h
--- 25-sparc64/include/linux/dma-mapping.h~bk-dma-declare-coherent-memory-fix	2004-07-09 15:07:00.253229480 -0700
+++ 25-sparc64-akpm/include/linux/dma-mapping.h	2004-07-09 15:07:13.039285704 -0700
@@ -1,6 +1,8 @@
 #ifndef _ASM_LINUX_DMA_MAPPING_H
 #define _ASM_LINUX_DMA_MAPPING_H
 
+#include <linux/err.h>
+
 /* These definitions mirror those in pci.h, so they can be used
  * interchangeably with their PCI_ counterparts */
 enum dma_data_direction {
_

