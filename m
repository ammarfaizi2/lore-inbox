Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVBNPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVBNPqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVBNPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:46:55 -0500
Received: from dpt60.neoplus.adsl.tpnet.pl ([83.24.153.60]:44500 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S261452AbVBNPq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:46:26 -0500
Date: Mon, 14 Feb 2005 16:46:20 +0100
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI access mode on x86_64
Message-ID: <20050214154620.GA13631@attika.ath.cx>
References: <20050213213117.GA18812@attika.ath.cx> <m1oeenh53g.fsf@muc.de> <20050214094701.GA323@attika.ath.cx> <20050214120205.GA33348@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214120205.GA33348@muc.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 01:02:05PM +0100, Andi Kleen wrote:
> On Mon, Feb 14, 2005 at 10:47:01AM +0100, Piotr Kaczuba wrote:
> > On Mon, Feb 14, 2005 at 10:18:43AM +0100, Andi Kleen wrote:
> > > Piotr Kaczuba <pepe@attika.ath.cx> writes:
> > > > Is there a reason why "PCI access mode" config option isn't available for
> > > > x86_64? Due to this, PCIE config options aren't available either.
> > > 
> > > There is no 64bit PCI BIOS, so access is always direct.
> > > 
> > > I assume you mean mmconfig access with "PCIE config options", that is
> > > a separate config option and available.
> > 
> > I mean the PCIEPORTBUS option which depends on PCI_GOMMCONFIG or
> > PCI_GOANY. I assume that due to PCI_MMCONFIG / PCI_GOMMCONFIG mismatch
> > it's not available on x86_64.
> 
> Ok, that's a bug in PCIEPORTBUS.  Best is probably to 
> completely remove the dependency, it doesn't make much sense
> (the code has to handle the case of mmconfig not being available at 
> runtime anyways) 
> 
> -Andi
> 
> Remove bogus dependency in PCI Express root driver.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> diff -u linux-2.6.11rc3/drivers/pci/pcie/Kconfig-o linux-2.6.11rc3/drivers/pci/pcie/Kconfig
> --- linux-2.6.11rc3/drivers/pci/pcie/Kconfig-o	2005-02-04 09:13:10.000000000 +0100
> +++ linux-2.6.11rc3/drivers/pci/pcie/Kconfig	2005-02-14 12:59:46.000000000 +0100
> @@ -3,7 +3,6 @@
>  #
>  config PCIEPORTBUS
>  	bool "PCI Express support"
> -	depends on PCI_GOMMCONFIG || PCI_GOANY
>  	default n
>  
>  	---help---
> 

This one is needed, too.

Piotr Kaczuba



--- linux.old/arch/x86_64/Kconfig       2005-02-14 16:37:33.000000000 +0100
+++ linux/arch/x86_64/Kconfig   2005-02-14 16:37:18.000000000 +0100
@@ -399,6 +399,8 @@
         from i386. Requires that the driver writer used memory barriers
         properly.

+source "drivers/pci/pcie/Kconfig"
+
 source "drivers/pci/Kconfig"

 source "drivers/pcmcia/Kconfig"

