Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUJFV2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUJFV2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbUJFU2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26856 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269470AbUJFUXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:23:01 -0400
Date: Wed, 06 Oct 2004 13:23:21 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, benh@kernel.crashing.org,
       paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][1/12] arch/ppc/kernel/pci.c replace pci_find_device with pci_get_device
Message-ID: <3550000.1097094201@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20041005104443.A16871@infradead.org>
References: <298570000.1096930681@w-hlinder.beaverton.ibm.com> <20041005104443.A16871@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, October 05, 2004 10:44:43 AM +0100 Christoph Hellwig <hch@infradead.org> wrote:

> what about adding a for_each_pci_dev macro that nicely hides these AND_ID
> iterations?
> 

OK. How about this? Following are two patches that I used to test this
new macro on my T23. I found roughly 54 other places this macro can
be used.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc3-mm2cln/include/linux/pci.h linux-2.6.9-rc3-mm2patch/include/linux/pci.h
--- linux-2.6.9-rc3-mm2cln/include/linux/pci.h	2004-10-04 11:38:51.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/include/linux/pci.h	2004-10-05 15:56:26.000000000 -0700
@@ -548,6 +548,7 @@ struct pci_dev {
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
 #define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
+#define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
 /*
  *  For PCI devices, the region numbers are assigned this way:

