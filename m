Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUE3S3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUE3S3L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUE3S3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 14:29:11 -0400
Received: from gate.ebshome.net ([66.92.248.57]:54724 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S262080AbUE3S3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 14:29:07 -0400
Date: Sun, 30 May 2004 11:29:06 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, mporter@kernel.crashing.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] ppc32: reorg DMA API, add coherent alloc in irq
Message-ID: <20040530182906.GA29666@gate.ebshome.net>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>, akpm@osdl.org,
	torvalds@osdl.org, mporter@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
References: <200405291908.i4TJ8a5l011479@hera.kernel.org> <1085920115.6882.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085920115.6882.1.camel@laptop.fenrus.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 02:28:35PM +0200, Arjan van de Ven wrote:
> On Sat, 2004-05-29 at 19:56, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1770, 2004/05/29 10:56:14-07:00, akpm@osdl.org
> > 
> > 	[PATCH] ppc32: reorg DMA API, add coherent alloc in irq
> > 	
> > 	From: Matt Porter <mporter@kernel.crashing.org>
> 
> this breaks the acenic driver:
> 
> In file included from drivers/net/acenic.c:186:
> drivers/net/acenic.h:598: error: syntax error before
> "DECLARE_PCI_UNMAP_ADDR"

[snip]

This patch should help.

PPC32: Put back DECLARE_PCI_UNMAP_??? and friends accidentaly removed during DMA 
API reorganization.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

===== include/asm-ppc/pci.h 1.28 vs edited =====
--- 1.28/include/asm-ppc/pci.h	Sat May 29 00:26:35 2004
+++ edited/include/asm-ppc/pci.h	Sun May 30 11:03:59 2004
@@ -61,6 +61,14 @@
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
+/* pci_unmap_{page,single} is a nop so... */
+#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
+#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
+#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
+#define pci_unmap_len(PTR, LEN_NAME)		(0)
+#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+
 /*
  * At present there are very few 32-bit PPC machines that can have
  * memory above the 4GB point, and we don't support that.


