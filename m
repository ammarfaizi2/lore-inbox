Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129772AbQLEO1g>; Tue, 5 Dec 2000 09:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131031AbQLEO10>; Tue, 5 Dec 2000 09:27:26 -0500
Received: from ausxc07.us.dell.com ([143.166.99.215]:48689 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S129772AbQLEO1Q>; Tue, 5 Dec 2000 09:27:16 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9A32@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci_read_bases trivial fixup
Date: Tue, 5 Dec 2000 07:55:58 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, below is a trivial patch to pci.c, and applies against test12-pre5.
In -test11, tmp was declared.  Somehow by 12-pre4, it got lost.  This puts
it back.  It's needed in the BITS_PER_LONG == 64 case.

Thanks,
Matt Domsch
Dell Enterprise Systems Group
Linux Development Team



diff -burN linux/drivers/pci/pci.c.orig linux/drivers/pci/pci.c
--- linux/drivers/pci/pci.c.orig        Tue Dec  5 07:49:28 2000
+++ linux/drivers/pci/pci.c     Tue Dec  5 07:49:36 2000
@@ -540,7 +540,7 @@
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int
rom)
 {
        unsigned int pos, reg, next;
-       u32 l, sz;
+       u32 l, sz, tmp;
        struct resource *res;

        for(pos=0; pos<howmany; pos = next) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
