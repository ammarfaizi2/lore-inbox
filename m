Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWHUSwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWHUSwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWHUStF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:49:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:957 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750761AbWHUSsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:50 -0400
Date: Mon, 21 Aug 2006 11:47:16 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jean Delvare <khali@linux-fr.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: [patch 13/20] PCI: fix ICH6 quirks
Message-ID: <20060821184716.GN21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-fix-ich6-quirks.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>

[PATCH] PCI: fix ICH6 quirks

- add the ICH6(R) LPC to the ICH6 ACPI quirks. currently only the ICH6-M is
  handled. [ PCI_DEVICE_ID_INTEL_ICH6_1 is the ICH6-M LPC, ICH6_0 is the ICH6(R) ]
- remove the wrong quirk calling asus_hides_smbus_lpc() for ICH6. the register
  modified in asus_hides_smbus_lpc() has a different meaning in ICH6.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.9.orig/drivers/pci/quirks.c
+++ linux-2.6.17.9/drivers/pci/quirks.c
@@ -427,6 +427,7 @@ static void __devinit quirk_ich6_lpc_acp
 	pci_read_config_dword(dev, 0x48, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1, "ICH6 GPIO");
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
 
 /*
@@ -1043,7 +1044,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc );
 
 static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
 {

--
