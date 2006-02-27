Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWB0B6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWB0B6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWB0B6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:58:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750826AbWB0B6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:58:52 -0500
Date: Sun, 26 Feb 2006 17:57:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: largret@gmail.com
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       ak@muc.de
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060226175745.42416125.akpm@osdl.org>
In-Reply-To: <1141002112.17427.4.camel@shogun.daga.dyndns.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	<20060226102152.69728696.akpm@osdl.org>
	<1140988015.5178.15.camel@shogun.daga.dyndns.org>
	<20060226133140.4cf05ea5.akpm@osdl.org>
	<1140994821.5522.9.camel@shogun.daga.dyndns.org>
	<20060226162040.cb72bc31.akpm@osdl.org>
	<1141002112.17427.4.camel@shogun.daga.dyndns.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Largret <largret@gmail.com> wrote:
>
>  drivers/block/floppy.c:3245: error: too few arguments to function
>  `__alloc_pages'

doh.

--- devel/include/asm-x86_64/floppy.h~b	2006-02-26 16:15:44.000000000 -0800
+++ devel-akpm/include/asm-x86_64/floppy.h	2006-02-26 17:57:02.000000000 -0800
@@ -40,7 +40,7 @@
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_free_irq()		free_irq(FLOPPY_IRQ, NULL)
 #define fd_get_dma_residue()    SW._get_dma_residue(FLOPPY_DMA)
-#define fd_dma_mem_alloc(size)	SW._dma_mem_alloc(size)
+#define fd_dma_mem_alloc(size)	alloc_pages(GFP_KERNEL|__GFP_DMA32, get_order(size))
 #define fd_dma_setup(addr, size, mode, io) SW._dma_setup(addr, size, mode, io)
 
 #define FLOPPY_CAN_FALLBACK_ON_NODMA
_

