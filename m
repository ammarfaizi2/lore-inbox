Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVFFXdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVFFXdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVFFXTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:19:18 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:56150 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261735AbVFFXBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:01:02 -0400
Date: Mon, 6 Jun 2005 16:00:51 -0700
From: Greg KH <gregkh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606230051.GC11184@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de> <20050604070537.GB8230@colo.lackof.org> <20050604071803.GA13684@suse.de> <1118008827.31082.245.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118008827.31082.245.camel@gaston>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 08:00:26AM +1000, Benjamin Herrenschmidt wrote:
> 
> > Hm, here's a possible function to do it (typed into my email client, not
> > compiled, no warranties, etc...):
> > 
> > /* returns 1 if device is in MSI mode, 0 otherwise */
> > int pci_in_msi_mode(struct pci_dev *dev)
> > {
> > 	int pos;
> > 	u16 control;
> > 
> > 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> > 	if (!pos)
> > 		return 0;
> > 	pci_read_config_word(dev, msi_control_reg(pos), &control);
> > 	if (control & PCI_MSI_FLAGS_ENABLE);
> > 		return 1;
> > 	return 0;
> > }
> 
> That would assume the architecture/slot/hw_setup always support MSI.
> What if you put an SMI capable card in a machine that doesn't do MSI ?

The ENABLE flag would not have been set by the current pci_enable_msi()
function.

> > If you use the above function, then you can tell the difference and
> > register different irq handlers if you wish.
> 
> No you can't because you lack the result code from pci_enable_msi()
> which can fail (because it's veto'd by the arch for example)

That's what the above function is for.  To call before setting up the
irq handlers.

> > The main point being is that the pci_enable_msi() function would not
> > have to be explicitly called by your driver, it would have already been
> > taken care of earlier by the PCI core.  That's what I want to do and am
> > wondering if there would be any bad side affects to it.
> 
> Disagreed.

Disagreed in what way?  What's the bad side affects?

thanks,

greg k-h
