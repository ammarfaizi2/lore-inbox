Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313730AbSDZJFd>; Fri, 26 Apr 2002 05:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313732AbSDZJFc>; Fri, 26 Apr 2002 05:05:32 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60936 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S313730AbSDZJFb>; Fri, 26 Apr 2002 05:05:31 -0400
Date: Fri, 26 Apr 2002 13:05:14 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jurriaan on Alpha <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
Message-ID: <20020426130514.A20345@jurassic.park.msu.ru>
In-Reply-To: <20020426073130.GB28217@alpha.of.nowhere> <20020426074416.GA8415@alpha.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 09:44:16AM +0200, Jurriaan on Alpha wrote:
> -#if defined(__i386__) || defined(__ppc__)
> +#if defined(__i386__) || defined(__ppc__) || defined(__alpha__)
>  /*
>   * Here a dirty hack for 2.4 kernels.. See kernel/memory.c.
>   */

No, alpha doesn't need any kind of "dirty hacks". :-)
We only need to get <linux/pci.h> included properly.

Ivan.

--- 2.5.10/include/sound/driver.h	Mon Mar 18 23:37:12 2002
+++ linux/include/sound/driver.h	Tue Mar 26 23:47:32 2002
@@ -50,12 +50,12 @@
  */
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
+#include <linux/pci.h>
 #if defined(__i386__) || defined(__ppc__)
 /*
  * Here a dirty hack for 2.4 kernels.. See kernel/memory.c.
  */
 #define HACK_PCI_ALLOC_CONSISTENT
-#include <linux/pci.h>
 void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
 				    dma_addr_t *dma_handle);
 #undef pci_alloc_consistent
