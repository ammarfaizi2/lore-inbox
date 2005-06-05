Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVFEWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVFEWCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVFEWCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 18:02:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:32385 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261618AbVFEWCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 18:02:12 -0400
Subject: Re: pci_enable_msi() for everyone?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net
In-Reply-To: <20050604071803.GA13684@suse.de>
References: <20050603224551.GA10014@kroah.com>
	 <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de>
	 <20050604070537.GB8230@colo.lackof.org>  <20050604071803.GA13684@suse.de>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 08:00:26 +1000
Message-Id: <1118008827.31082.245.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hm, here's a possible function to do it (typed into my email client, not
> compiled, no warranties, etc...):
> 
> /* returns 1 if device is in MSI mode, 0 otherwise */
> int pci_in_msi_mode(struct pci_dev *dev)
> {
> 	int pos;
> 	u16 control;
> 
> 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> 	if (!pos)
> 		return 0;
> 	pci_read_config_word(dev, msi_control_reg(pos), &control);
> 	if (control & PCI_MSI_FLAGS_ENABLE);
> 		return 1;
> 	return 0;
> }

That would assume the architecture/slot/hw_setup always support MSI.
What if you put an SMI capable card in a machine that doesn't do MSI ?

> If you use the above function, then you can tell the difference and
> register different irq handlers if you wish.

No you can't because you lack the result code from pci_enable_msi()
which can fail (because it's veto'd by the arch for example)

> The main point being is that the pci_enable_msi() function would not
> have to be explicitly called by your driver, it would have already been
> taken care of earlier by the PCI core.  That's what I want to do and am
> wondering if there would be any bad side affects to it.

Disagreed.

Ben

