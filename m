Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVBNMCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVBNMCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVBNMCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:02:14 -0500
Received: from colin2.muc.de ([193.149.48.15]:37129 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261416AbVBNMCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:02:07 -0500
Date: 14 Feb 2005 13:02:05 +0100
Date: Mon, 14 Feb 2005 13:02:05 +0100
From: Andi Kleen <ak@muc.de>
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tom.l.nguyen@intel.com
Subject: Re: PCI access mode on x86_64
Message-ID: <20050214120205.GA33348@muc.de>
References: <20050213213117.GA18812@attika.ath.cx> <m1oeenh53g.fsf@muc.de> <20050214094701.GA323@attika.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214094701.GA323@attika.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 10:47:01AM +0100, Piotr Kaczuba wrote:
> On Mon, Feb 14, 2005 at 10:18:43AM +0100, Andi Kleen wrote:
> > Piotr Kaczuba <pepe@attika.ath.cx> writes:
> > > Is there a reason why "PCI access mode" config option isn't available for
> > > x86_64? Due to this, PCIE config options aren't available either.
> > 
> > There is no 64bit PCI BIOS, so access is always direct.
> > 
> > I assume you mean mmconfig access with "PCIE config options", that is
> > a separate config option and available.
> 
> I mean the PCIEPORTBUS option which depends on PCI_GOMMCONFIG or
> PCI_GOANY. I assume that due to PCI_MMCONFIG / PCI_GOMMCONFIG mismatch
> it's not available on x86_64.

Ok, that's a bug in PCIEPORTBUS.  Best is probably to 
completely remove the dependency, it doesn't make much sense
(the code has to handle the case of mmconfig not being available at 
runtime anyways) 

-Andi

Remove bogus dependency in PCI Express root driver.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.11rc3/drivers/pci/pcie/Kconfig-o linux-2.6.11rc3/drivers/pci/pcie/Kconfig
--- linux-2.6.11rc3/drivers/pci/pcie/Kconfig-o	2005-02-04 09:13:10.000000000 +0100
+++ linux-2.6.11rc3/drivers/pci/pcie/Kconfig	2005-02-14 12:59:46.000000000 +0100
@@ -3,7 +3,6 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express support"
-	depends on PCI_GOMMCONFIG || PCI_GOANY
 	default n
 
 	---help---

