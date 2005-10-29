Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVJ2Usg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVJ2Usg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJ2Usf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:48:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58120 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932148AbVJ2Usf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:48:35 -0400
Date: Sat, 29 Oct 2005 22:48:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] EDAC drivers: missing PCI dependencies
Message-ID: <20051029204824.GN4180@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile errors with CONFIG_PCI=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `amd76x_probe1':
amd76x_edac.c:(.text+0x56dc56): undefined reference to `pci_dev_get'
drivers/built-in.o: In function `e752x_probe1':
e752x_edac.c:(.text+0x56f152): undefined reference to `pci_scan_single_device'
e752x_edac.c:(.text+0x56f330): undefined reference to `pci_dev_get'
drivers/built-in.o: In function `i82875p_probe1':
i82875p_edac.c:(.text+0x56f6b4): undefined reference to `pci_scan_single_device'
i82875p_edac.c:(.text+0x56f6dd): undefined reference to `pci_release_regions'
i82875p_edac.c:(.text+0x56f6ef): undefined reference to `pci_proc_attach_device'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1/drivers/edac/Kconfig.old	2005-10-29 22:42:51.000000000 +0200
+++ linux-2.6.14-rc5-mm1/drivers/edac/Kconfig	2005-10-29 22:44:22.000000000 +0200
@@ -43,7 +43,7 @@
 
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
-	depends on EDAC
+	depends on EDAC && PCI
 
 config EDAC_E7XXX
 	tristate "Intel e7xxx (e7205, e7500, e7501, e7505)"
@@ -51,11 +51,11 @@
 
 config EDAC_E752X
 	tristate "Intel e752x (e7520, e7525, e7320)"
-	depends on EDAC
+	depends on EDAC && PCI
 
 config EDAC_I82875P
 	tristate "Intel 82875p (D82875P, E7210)"
-	depends on EDAC
+	depends on EDAC && PCI
 
 config EDAC_I82860
 	tristate "Intel 82860"

