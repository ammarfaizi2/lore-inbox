Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965338AbVKGUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338AbVKGUEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965324AbVKGUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:04:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28946 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965323AbVKGUDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:03:50 -0500
Date: Mon, 7 Nov 2005 21:03:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, kristen.c.accardi@intel.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.14-mm1: drivers/pci/hotplug/: namespace clashes
Message-ID: <20051107200349.GK3847@stusta.de>
References: <20051106182447.5f571a46.akpm@osdl.org> <20051107173732.GG3847@stusta.de> <20051107104150.A4388@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107104150.A4388@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:41:50AM -0800, Rajesh Shah wrote:
> On Mon, Nov 07, 2005 at 06:37:32PM +0100, Adrian Bunk wrote:
> > <--  snip  -->
> > 
> > ...
> >   LD      drivers/pci/hotplug/built-in.o
> > drivers/pci/hotplug/shpchp.o: In function `get_hp_hw_control_from_firmware':
> > : multiple definition of `get_hp_hw_control_from_firmware'
> > drivers/pci/hotplug/pciehp.o:: first defined here
> > ld: Warning: size of symbol `get_hp_hw_control_from_firmware' changed from 472 in drivers/pci/hotplug/pciehp.o to 25 in drivers/pci/hotplug/shpchp.o
> > drivers/pci/hotplug/shpchp.o: In function `get_hp_params_from_firmware':
> > : multiple definition of `get_hp_params_from_firmware'
> > drivers/pci/hotplug/pciehp.o:: first defined here
> > make[3]: *** [drivers/pci/hotplug/built-in.o] Error 1
> > 
> This patch should fix this:
>...


Nearly, the following is additionally required:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm1-full/drivers/pci/hotplug/pciehp_hpc.c.old	2005-11-07 20:06:01.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/pci/hotplug/pciehp_hpc.c	2005-11-07 20:06:47.000000000 +0100
@@ -1418,7 +1418,7 @@
 		dbg("Bypassing BIOS check for pciehp use on %s\n",
 				pci_name(ctrl->pci_dev));
 	} else {
-		rc = get_hp_hw_control_from_firmware(ctrl->pci_dev);
+		rc = pciehp_get_hp_hw_control_from_firmware(ctrl->pci_dev);
 		if (rc)
 			goto abort_free_ctlr;
 	}

