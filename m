Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318820AbSHESkN>; Mon, 5 Aug 2002 14:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318825AbSHESkN>; Mon, 5 Aug 2002 14:40:13 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:49668 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318820AbSHESkM>; Mon, 5 Aug 2002 14:40:12 -0400
Date: Mon, 5 Aug 2002 20:43:33 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac4
Message-ID: <20020805184333.GA27961@louise.pinerecords.com>
References: <200208051147.g75Blh720012@devserv.devel.redhat.com> <20020805181047.GE25892@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020805181047.GE25892@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 62 days, 10:19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The IDE debugging continues. -ac4 should fix the breakages in ac2/ac3. It
> > hopefully also fixes the ALi hangs with non ALi north bridges (mostly 
> > Transmeta boxes).
> 
> It is a nice shrubbery, but there is one small problem!!
> 
> # depmod -ae -F /boot/System.map-2.4.19-ac4 2.4.19-ac4
> depmod: *** Unresolved symbols in /lib/modules/2.4.19-ac4/kernel/drivers/ide/ide-mod.o
> depmod:         pci_enable_device_bars

Why not ask Roger the Shrubber?


diff -urN linux-2.4.19-ac4/drivers/ide/ide-pci.c linux-2.4.19-ac4.n/drivers/ide/ide-pci.c
--- linux-2.4.19-ac4/drivers/ide/ide-pci.c	2002-08-05 20:41:59.000000000 +0200
+++ linux-2.4.19-ac4.n/drivers/ide/ide-pci.c	2002-08-05 20:28:31.000000000 +0200
@@ -693,7 +693,7 @@
 	}
 
 	if (pci_enable_device(dev)) {
-		if(pci_enable_device_bars(dev, 1<<4))
+		if (pci_enable_device_bars(dev, 1 << 4))
 		{
 			printk(KERN_WARNING "%s: (ide_setup_pci_device:) "
 				"Could not enable device.\n", d->name);
diff -urN linux-2.4.19-ac4/drivers/pci/pci.c linux-2.4.19-ac4.n/drivers/pci/pci.c
--- linux-2.4.19-ac4/drivers/pci/pci.c	2002-08-05 20:42:00.000000000 +0200
+++ linux-2.4.19-ac4.n/drivers/pci/pci.c	2002-08-05 20:28:21.000000000 +0200
@@ -2082,6 +2082,7 @@
 EXPORT_SYMBOL(pci_write_config_dword);
 EXPORT_SYMBOL(pci_devices);
 EXPORT_SYMBOL(pci_root_buses);
+EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_find_capability);
