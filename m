Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSFCE3R>; Mon, 3 Jun 2002 00:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317268AbSFCE3Q>; Mon, 3 Jun 2002 00:29:16 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:42979 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317267AbSFCE3P>;
	Mon, 3 Jun 2002 00:29:15 -0400
Date: Mon, 3 Jun 2002 14:27:27 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020603042727.GE2355@krispykreme>
In-Reply-To: <20020602200646.GB20788@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Trace; fffffc00003c9f04 <device_register+144/1c0>
> Trace; fffffc00003c4e18 <pci_scan_device+118/160>
> Trace; fffffc00003c4f0c <pci_scan_slot+ac/180>
> Trace; fffffc00003c5060 <pci_do_scan_bus+80/140>
> Trace; fffffc00003c53a0 <pci_scan_bus+40/80>
> Trace; fffffc00003100f8 <init+18/200>
> Trace; fffffc0000310748 <kernel_thread+28/90>
> Trace; fffffc0000324448 <printk+228/280>
> Trace; fffffc00003100a8 <rest_init+28/60>
> Trace; fffffc00003100e0 <init+0/200>
> Trace; fffffc0000310730 <kernel_thread+10/90>

On ppc64 I found that pcibios_init was being called before
pci_driver_init, maybe its happening on alpha too. I am using the
following hack for the moment, I'll leave it to Patrick to fix it properly.

Anton

===== drivers/pci/pci-driver.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-driver.c	Fri May 31 06:10:44 2002
+++ edited/drivers/pci/pci-driver.c	Sat Jun  1 09:46:37 2002
@@ -192,7 +192,7 @@
 	return bus_register(&pci_bus_type);
 }
 
-subsys_initcall(pci_driver_init);
+arch_initcall(pci_driver_init);
 
 EXPORT_SYMBOL(pci_match_device);
 EXPORT_SYMBOL(pci_register_driver);
