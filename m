Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUBVQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUBVQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:38:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:16100 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261686AbUBVQiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:38:10 -0500
To: =?iso-8859-1?Q?Herbert_Poetzl?= <herbert@13thfloor.at>
Subject: Re: Kernel Cross Compiling [update]
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: <linux-kernel@vger.kernel.org>
Message-Id: <26879984$10774662434038d483c8d470.47738239@config21.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Sun, 22 Feb 2004 17:36:01 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.148
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Herbert Poetzl wrote:

>    			   linux-2.6.3-rc3     linux-2.6.3
>    			   config  build       config  build

>    s390/s390:		   OK	   FAILED      OK      FAILED

This trivial patch (or something similar) is missing from 2.6.3
to make it build for s390.

You might also want to test building in 64 bit mode 
(CONFIG_ARCH_S390X on 2.6, ARCH=s390x on 2.4).

     Arnd <><

===== include/asm-s390/dma-mapping.h 1.2 vs edited =====
--- 1.2/include/asm-s390/dma-mapping.h	Thu Jul 17 19:27:29 2003
+++ edited/include/asm-s390/dma-mapping.h	Sun Feb 22 17:15:43 2004
@@ -8,4 +8,20 @@
 
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
+
+static inline void *
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t
*dma_handle,
+		   int flag)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_handle)
+{
+	BUG();
+}
+
 #endif /* _ASM_DMA_MAPPING_H */
