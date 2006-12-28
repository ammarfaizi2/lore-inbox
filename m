Return-Path: <linux-kernel-owner+w=401wt.eu-S1754893AbWL1RpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbWL1RpJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbWL1RpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:45:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:39299 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbWL1RpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:45:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding:sender;
        b=hXNi8sFspEvNwc01EhAQZUZfCfZ7IuU8/CZ5TpA5YQeOrhlcZZ2EUgT/Mf+JtgrNSFbHAh8PF8zYmXM+zfQgChntajEYSJsm3X42nQjnDBtI9N3faf6uCDEsRLYu6Lfbo1nEVc1hniNwZqcHTO8GIu3cbCWsaH5RirLZvF7zCzo=
Date: Thu, 28 Dec 2006 18:44:59 +0100
From: Jan Andersson <jan.andersson@ieee.org>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH] sparc32: add offset in pci_map_sg()
Message-ID: <20061228184459.1c51a33b@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Andersson jan.andersson@ieee.org

Add sg->offset to sg->dvma_address in pci_map_sg() on sparc32. Without
the offset, transfers to buffers that do not begin on a page boundary 
will not work as expected. 

Signed-off-by: Jan Andersson <jan.andersson@ieee.org>
---

diff -uprN a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
--- a/arch/sparc/kernel/ioport.c        2006-12-28 15:00:46.000000000 +0100
+++ b/arch/sparc/kernel/ioport.c        2006-12-28 16:22:40.000000000 +0100
@@ -728,7 +728,8 @@ int pci_map_sg(struct pci_dev *hwdev, st
        /* IIep is write-through, not flushing. */
        for (n = 0; n < nents; n++) {
                BUG_ON(page_address(sg->page) == NULL);
-               sg->dvma_address = virt_to_phys(page_address(sg->page));
+               sg->dvma_address = 
+                       virt_to_phys(page_address(sg->page)) + sg->offset;
                sg->dvma_length = sg->length;
                sg++;
        }
