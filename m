Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbTF3Dwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 23:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbTF3Dwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 23:52:55 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:23813 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265724AbTF3Dwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 23:52:53 -0400
Subject: [PATCH] move sg_dma_ macros out of asm-i386/pci.h
From: James Bottomley <James.Bottomley@steeleye.com>
To: torvalds@transmeta.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-cyow+OlVH8vzkSdbW7TU"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Jun 2003 23:07:11 -0500
Message-Id: <1056946032.2886.396.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cyow+OlVH8vzkSdbW7TU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These macros belong in asm-i386/scatterlist.h instead.

As the headers are disentangled this has shown up as a problem with my
MCA SCSI drivers since they no-longer include asm/pci.h in any form but
need to traverse the scatterlist.

James


--=-cyow+OlVH8vzkSdbW7TU
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D include/asm-i386/pci.h 1.22 vs edited =3D=3D=3D=3D=3D
--- 1.22/include/asm-i386/pci.h	Mon Jun  9 11:25:58 2003
+++ edited/include/asm-i386/pci.h	Sun Jun 29 21:18:53 2003
@@ -82,14 +82,6 @@
 	flush_write_buffers();
 }
=20
-/* These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns.
- */
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)		((sg)->length)
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
=3D=3D=3D=3D=3D include/asm-i386/scatterlist.h 1.3 vs edited =3D=3D=3D=3D=
=3D
--- 1.3/include/asm-i386/scatterlist.h	Wed Feb  6 07:32:52 2002
+++ edited/include/asm-i386/scatterlist.h	Sun Jun 29 21:18:54 2003
@@ -8,6 +8,14 @@
     unsigned int	length;
 };
=20
+/* These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns.
+ */
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)		((sg)->length)
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
=20
 #endif /* !(_I386_SCATTERLIST_H) */

--=-cyow+OlVH8vzkSdbW7TU--

