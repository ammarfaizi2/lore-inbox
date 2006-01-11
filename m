Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWAKBSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWAKBSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWAKBSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:18:08 -0500
Received: from fmr18.intel.com ([134.134.136.17]:32490 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932744AbWAKBSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:18:07 -0500
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>,
       Rajesh Shah <rajesh.shah@intel.com>
In-Reply-To: <20060110202841.GZ19769@parisc-linux.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
	 <20060103231304.56e3228b.akpm@osdl.org>
	 <1136422680.30655.1.camel@sli10-desk.sh.intel.com>
	 <20060110202841.GZ19769@parisc-linux.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 09:17:19 +0800
Message-Id: <1136942240.5750.35.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 13:28 -0700, Matthew Wilcox wrote:
> On Thu, Jan 05, 2006 at 08:58:00AM +0800, Shaohua Li wrote:
> > +	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) <= 0 ||
> > +		dev->no_msi)
> 
> No assignments within conditionals, please.
Ok.

> 	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> 	if (pos <= 0 || dev->no_msi)
> 
> >  	u32		saved_config_space[16]; /* config space saved at suspend time */
> > +	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
> >  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
> ...
> >  #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
> > +#define PCI_CAP_ID_MAX		PCI_CAP_ID_MSIX
> >  #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
> 
> Rather than taking all this space in the pci_dev structure (even
> without CONFIG_PM), how about:
> 
> struct pci_cap_saved_state {
> 	struct pci_cap_saved_state *next;
> 	char cap_nr;
> 	char data[0];
> }
> 
> and then just add:
> 
> 	struct pci_cap_saved_state *saved_cap_space;
> 
> to the struct pci_dev?  One pointer, rather than (currently!) 12.
> That's an 88 byte saving per PCI device on 64-bit machines!
It's not that big, right? This will make things a little complex. How
about just define saved_cap_space[] with CONFIG_PM configured? Anyway,
if you insist on less space, I'm happy to change it.

Thanks,
Shaohua

