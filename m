Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUBVJvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUBVJvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:51:32 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:1554 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261213AbUBVJv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:51:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Sun, 22 Feb 2004 12:36:44 +0300
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.3-mm2] /proc/ide/HWIF for modular IDE
Message-ID: <20040222093644.GB4873@localhost.localdomain>
References: <20040203194840.GD3249@localhost.localdomain> <200402032139.24487.bzolnier@elka.pw.edu.pl> <20040204194449.GB3968@localhost.localdomain> <200402042255.33476.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <200402042255.33476.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2004 at 10:55:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> > > ide_setup_pci_device()+ide_setup_pci_devices() are correct places
> > > to add registering of /proc/ide/<chipset> and /proc/ide/<hwif>.
> >
> > this patch does it for <hwif>
> >

2.6.3-mm2 now makes /proc/ide/CHIPSET appear but /proc/ide/HWIF are
still missing.

Updated patch attached.

-andrey 

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.3-mm2-modular_proc_ide.patch"

--- linux-2.6.2-mm1/drivers/ide/setup-pci.c.modular	2004-02-05 22:59:48.000000000 +0300
+++ linux-2.6.2-mm1/drivers/ide/setup-pci.c	2004-02-05 22:59:54.000000000 +0300
@@ -746,6 +746,10 @@ void ide_setup_pci_device (struct pci_de
 		probe_hwif_init(&ide_hwifs[index_list.b.low]);
 	if ((index_list.b.high & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index_list.b.high]);
+
+#ifdef CONFIG_PROC_FS
+	create_proc_ide_interfaces();
+#endif
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_device);
@@ -763,6 +767,10 @@ void ide_setup_pci_devices (struct pci_d
 		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
 	if ((index_list2.b.high & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
+
+#ifdef CONFIG_PROC_FS
+	create_proc_ide_interfaces();
+#endif
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);

--G4iJoqBmSsgzjUCe--
