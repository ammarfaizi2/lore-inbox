Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFDHYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFDHYP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 03:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFDHYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 03:24:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261279AbVFDHYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 03:24:10 -0400
Date: Sat, 4 Jun 2005 03:23:48 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050604072348.GA28293@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	roland@topspin.com, davem@davemloft.net
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de> <20050604070537.GB8230@colo.lackof.org> <20050604071803.GA13684@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604071803.GA13684@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 12:18:03AM -0700, Greg KH wrote:
 > On Sat, Jun 04, 2005 at 01:05:37AM -0600, Grant Grundler wrote:
 > > On Fri, Jun 03, 2005 at 11:48:21PM -0700, Greg KH wrote:
 > > > > One complication is some drivers will want to register a different
 > > > > IRQ handler depending on if MSI is enabled or not.
 > > > 
 > > > That's fine, they can always check the device capabilities and do that.
 > > 
 > > Can you be more specific?
 > > Maybe a short chunk of psuedo code?
 > 
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

What if MSI support has been disabled in the bridge due to some quirk
(like the recent AMD 8111 quirk) ?   Maybe the above function
should check pci_msi_enable as well ?

		Dave

