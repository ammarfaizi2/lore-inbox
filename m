Return-Path: <linux-kernel-owner+w=401wt.eu-S1761625AbWLJQAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761625AbWLJQAp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761701AbWLJQAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:00:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4366 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761625AbWLJQAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:00:44 -0500
Date: Sun, 10 Dec 2006 17:00:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Daniel Drake <dsd@gentoo.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061210160053.GD10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <1165723779.334.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1165723779.334.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 04:09:39AM +0000, Sergio Monteiro Basto wrote:
> On Thu, 2006-12-07 at 09:38 -0500, Daniel Drake wrote:
> > Adrian Bunk wrote:
> > > Daniel Drake (1):
> > >       PCI: VIA IRQ quirk behaviour change
> > 
> > Please drop this one, Alan isn't 100% on it and is working on getting a 
> > better fix into mainline
> > 
> > Daniel
> 
> Sorry Daniel, I don't agree with you, this patch is a improvement of the
> original patch and in my opinion should go in.
> As Alan explain to us, is not the prefect one, but still be an
> improvement.

Below is the patch for going back to the 2.6.16.16 status quo that is in 
2.6.16.36-rc1.

Does this cause any serious regression for anyone?

> Thanks,
> Sérgio M. B. 

cu
Adrian


commit dcb1715778026c4aec20d186dc794245d9a1f5de
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Dec 8 17:00:35 2006 +0100

    revert the quirk_via_irq changes
    
    This patch reverts the quirk_via_irq changes in 2.6.16.17 that
    caused regressions for several people.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a1cdf06..2a66e39 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -656,13 +656,7 @@ static void quirk_via_irq(struct pci_dev *dev)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes
