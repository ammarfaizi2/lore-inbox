Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUJYRNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUJYRNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUJYRMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:12:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13795 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261169AbUJYRLv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:11:51 -0400
Date: Mon, 25 Oct 2004 10:10:50 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Hanna Linder <hannal@us.ibm.com>,
       greg@kroah.com
Subject: Re: [KJ] Re: [PATCH 2.6] hw_random.c: replace pci_find_device
Message-ID: <20041025171050.GB2209@us.ibm.com>
References: <268450000.1098383924@w-hlinder.beaverton.ibm.com> <41783CDA.8010901@pobox.com> <9e473391041025094812aa9923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9e473391041025094812aa9923@mail.gmail.com>
X-Operating-System: Linux 2.6.9 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 12:48:43PM -0400, Jon Smirl wrote:
> On Thu, 21 Oct 2004 18:48:58 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > applied
> 
> I just pulled from Linus bk, for_each_pci_dev isn't defined anywhere.
> I get compile errors in hw_random.c.
> 
> [jonsmirl@smirl linux-2.5]$ grep -rI for_each_pci_dev *
> drivers/char/hw_random.c:       for_each_pci_dev(pdev) {
> SCCS/s.ChangeSet:c for_each_pci_dev is a macro wrapper around pci_get_device.
> [jonsmirl@smirl linux-2.5]$

I believe some people missed Hanna's first patch which defined
for_each_pci_dev so she sent it again a few days after. Here is her
message again...

-Nish

-------

I wrote this macro last week and was recently asked to resend it in case people
missed the original submission. I have been using it during my conversion to
pci_get_device and it seems to be fine.

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
