Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbVIBXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbVIBXLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbVIBXKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:10:48 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:52104 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161112AbVIBXKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:10:44 -0400
Date: Sat, 3 Sep 2005 00:57:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@vger.kernel.org
Cc: pascal.chapperon@wanadoo.fr, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>, apatard@mandriva.com,
       jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.13-git3 5/5] sis190: basic sis191 support
Message-ID: <20050902225751.GF25687@electric-eye.fr.zoreil.com>
References: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sis191 is the gigabit brother of the sis190. SiS's driver suggests
that the register set is backward compatible: this should hopefully
give a basic driver.

The device should allow the usual features from a modern ethernet
adapter (802.1q, SG, Jumbo frames, TSO, checksum offload). So far
the relevant register layout is not documented. SiS's driver does
not provide these features either (at least not for Linux).

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN a/drivers/net/sis190.c~sis190-210 b/drivers/net/sis190.c
--- a/drivers/net/sis190.c~sis190-210	2005-09-02 23:28:05.390587495 +0200
+++ b/drivers/net/sis190.c	2005-09-02 23:28:05.396586525 +0200
@@ -331,14 +331,14 @@ static struct mii_chip_info {
 
 const static struct {
 	const char *name;
-	u8 version;		/* depend on docs */
-	u32 RxConfigMask;	/* clear the bits supported by this chip */
 } sis_chip_info[] = {
-	{ DRV_NAME, 0x00, 0xff7e1880, },
+	{ "SiS 190 PCI Fast Ethernet adapter" },
+	{ "SiS 191 PCI Gigabit Ethernet adapter" },
 };
 
 static struct pci_device_id sis190_pci_tbl[] __devinitdata = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0190), 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0191), 0, 0, 1 },
 	{ 0, },
 };
 
diff -puN a/drivers/net/Kconfig~sis190-210 b/drivers/net/Kconfig
--- a/drivers/net/Kconfig~sis190-210	2005-09-02 23:28:05.393587010 +0200
+++ b/drivers/net/Kconfig	2005-09-02 23:28:05.398586202 +0200
@@ -1924,12 +1924,15 @@ config R8169_VLAN
 	  If in doubt, say Y.
 
 config SIS190
-	tristate "SiS190 gigabit ethernet support"
+	tristate "SiS190/SiS191 gigabit ethernet support"
 	depends on PCI
 	select CRC32
 	select MII
 	---help---
-	  Say Y here if you have a SiS 190 PCI Gigabit Ethernet adapter.
+	  Say Y here if you have a SiS 190 PCI Fast Ethernet adapter or
+	  a SiS 191 PCI Gigabit Ethernet adapter. Both are expected to
+	  appear in lan on motherboard designs which are based on SiS 965
+	  and SiS 966 south bridge.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called sis190.  This is recommended.

_
