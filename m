Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCaEET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 23:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCaEET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 23:04:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:62113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261604AbUCaEEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 23:04:16 -0500
Date: Tue, 30 Mar 2004 19:58:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, akpm@osdl.org, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
Message-Id: <20040330195804.40b6c7d4.rddunlap@osdl.org>
In-Reply-To: <20040331012615.GA12444@kroah.com>
References: <20040323052305.GA2287@havoc.gtf.org>
	<20040329223604.63d981d0.rddunlap@osdl.org>
	<20040331012615.GA12444@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 17:26:15 -0800 Greg KH <greg@kroah.com> wrote:

| On Mon, Mar 29, 2004 at 10:36:04PM -0800, Randy.Dunlap wrote:
| > On Tue, 23 Mar 2004 00:23:05 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
| > 
| > | 
| > | Been meaning to do this for ages...
| > | 
| > | Another one for the janitors.
| > 
| > >>>Nice, I've pulled this to my pci tree and will forward it on to Linus in
| > >>>the next round of pci patches after 2.6.5 is out.
| > >>
| > >>Yeah well...  in the intervening time, somebody on IRC commented
| > >>
| > >>"so what is so PCI-specific about those constants?"
| > >>
| > >>They probably ought to be DMA_{32,64}BIT_MASK or somesuch.
| > > 
| > > 
| > > Heh, ok, care to make up another patch for this?  :)
| > 
| > 
| > Here's an updated patch, applies to 2.6.5-rc2-bk9.
| > I left the DMA_xxBIT_MASK defines in linux/pci.h, although
| > they aren't necessarily PCI-specific.  Would we prefer to
| > have them in linux/dma-mapping.h ?
| 
| Ok, this looks good.  I've backed out Jeff's patch and applied this one
| instead to my tree.  If you want to move the defines, please send me a
| patch relative to this one.

Yes, let's move the defines like Jeff suggested.
Additional (relative) patch is below.

Thanks,
--
~Randy


// linux-2.6.5-rc3
// move DMA_nnBIT_MASK to linux/dma-mapping.h;


diffstat:=
 include/linux/dma-mapping.h |    3 +++
 include/linux/pci.h         |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)


diff -Naurp ./include/linux/pci.h~dma_bits ./include/linux/pci.h
--- ./include/linux/pci.h~dma_bits	2004-03-30 17:50:00.000000000 -0800
+++ ./include/linux/pci.h	2004-03-30 17:53:49.000000000 -0800
@@ -362,9 +362,6 @@ enum pci_mmap_state {
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
-#define DMA_64BIT_MASK	0xffffffffffffffffULL
-#define DMA_32BIT_MASK	0x00000000ffffffffULL
-
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
diff -Naurp ./include/linux/dma-mapping.h~dma_bits ./include/linux/dma-mapping.h
--- ./include/linux/dma-mapping.h~dma_bits	2004-03-30 17:41:41.000000000 -0800
+++ ./include/linux/dma-mapping.h	2004-03-30 17:53:54.000000000 -0800
@@ -10,6 +10,9 @@ enum dma_data_direction {
 	DMA_NONE = 3,
 };
 
+#define DMA_64BIT_MASK	0xffffffffffffffffULL
+#define DMA_32BIT_MASK	0x00000000ffffffffULL
+
 #include <asm/dma-mapping.h>
 
 /* Backwards compat, remove in 2.7.x */
