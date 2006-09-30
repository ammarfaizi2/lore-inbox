Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWI3Kmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWI3Kmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWI3Kmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:42:52 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38342 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750804AbWI3Kmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:42:51 -0400
Date: Sat, 30 Sep 2006 13:42:48 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060930104248.GR22787@rhun.haifa.ibm.com>
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com> <20060930093421.GP22787@rhun.haifa.ibm.com> <451E40DF.30406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451E40DF.30406@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 06:03:11AM -0400, Jeff Garzik wrote:

> Would you also make sure that Andrew has the necessary bits to keep 
> Calgary going under PCI domains?  If it's a patch that sits on top of 
> linux-2.6.git + my patch, I can merge it into misc-2.6.git#pciseg (which 
> automatically goes into -mm).  Otherwise, make sure -mm has the stack of 
> patches necessary.

The patch I posted earlier is all that's needed, if you could merge it
into #pciseg that would be fine. I'm pondering making one small
change though: in your pci domains patch, you have this snippet:

+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	return sd->domain;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+#endif /* CONFIG_PCI_DOMAINS */

So pci_domain_nr and pci_proc_domain are only available if
CONFIG_PCI_DOMAINS is defined. I followed suit and make pci_iommu only
available if CONFIG_CALGARY_IOMMU is defined, but perhaps it would be
better to make it unconditional, since ->sysdata will always be
available anyway. Was there a specific reason why pci_domain_nr is
only available if CONFIG_PCI_DOMAINS?

Cheers,
Muli
