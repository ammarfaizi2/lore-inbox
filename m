Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUAGLSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUAGLSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:18:46 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:35968 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265504AbUAGLSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:18:40 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
References: <20040106010924.GA21747@sgi.com>
	<20040106102538.A14492@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 07 Jan 2004 06:18:30 -0500
In-Reply-To: <20040106102538.A14492@infradead.org>
Message-ID: <yq04qv8ypkp.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Mon, Jan 05, 2004 at 05:09:24PM -0800, Jesse Barnes
Christoph> wrote:
>> The 'depends' directive for SGI IOC4 support is too restrictive.
>> Just kill it altogether.

Christoph> Umm, it won't work for anything but a kernel with SN2
Christoph> support compile in due to the bridge-level dma byteswapping
Christoph> it needs (through a week symbol, that's why you don't see
Christoph> compile failures for other architectures, eek!).

Christoph> So at least make it depend on CONFIG_IA64

What about adding this?

Though shall not use weak symbols in though kernel ....

Jes

--- drivers/ide/pci/sgiioc4.c~	Tue Jan  6 01:43:41 2004
+++ drivers/ide/pci/sgiioc4.c	Wed Jan  7 03:13:13 2004
@@ -719,6 +719,7 @@
 	return 0;
 }
 
+#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
 /* This ensures that we can build this for generic kernels without
  * having all the SN2 code sync'd and merged.
  */
@@ -726,9 +727,10 @@
 	PCIDMA_ENDIAN_BIG,
 	PCIDMA_ENDIAN_LITTLE
 } pciio_endian_t;
-pciio_endian_t __attribute__ ((weak)) snia_pciio_endian_set(struct pci_dev
-					    *pci_dev, pciio_endian_t device_end,
-					    pciio_endian_t desired_end);
+pciio_endian_t snia_pciio_endian_set(struct pci_dev
+				     *pci_dev, pciio_endian_t device_end,
+				     pciio_endian_t desired_end);
+#endif
 
 static unsigned int __init
 pci_init_sgiioc4(struct pci_dev *dev, ide_pci_device_t * d)
@@ -754,6 +756,7 @@
 		return 1;
 	}
 
+#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
 	/* Enable Byte Swapping in the PIC... */
 	if (snia_pciio_endian_set) {
 		snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
@@ -764,7 +767,7 @@
 		       d->name, dev->slot_name);
 		return 1;
 	}
-
+#endif
 	return sgiioc4_ide_setup_pci_device(dev, d);
 }
 
