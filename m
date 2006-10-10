Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWJJRRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWJJRRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWJJRRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:17:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:38795 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964884AbWJJRR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:17:27 -0400
Date: Tue, 10 Oct 2006 10:15:43 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, torvalds@g5.osdl.org.kroah.org,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Asit Mallick <asit.k.mallick@intel.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/19] Add PIIX4 APCI quirk for the 440MX chipset too
Message-ID: <20061010171543.GQ6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-piix4-apci-quirk-for-the-440mx-chipset-too.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Linus Torvalds <torvalds@osdl.org>

This is confirmed to fix a hang due to PCI resource conflicts with
setting up the Cardbus bridge on old laptops with the 440MX chipsets.
Original report by Alessio Sangalli, lspci debugging help by Pekka
Enberg, and trial patch suggested by Daniel Ritz:

  "From the docs available i would _guess_ this thing is really similar
   to the 82443BX/82371AB combination.  at least the SMBus base address
   register is hidden at the very same place (32bit at 0x90 in function
   3 of the "south" brigde)"

The dang thing is largely undocumented, but the patch was corroborated
by Asit Mallick:

  "I am trying to find the register information. 440MX is an integration of
   440BX north-bridge without AGP and PIIX4E (82371EB).  PIIX4 quirk
   should cover the ACPI and SMBus related I/O registers."

and verified to fix the problem by Alessio.

Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Tested-by: Alessio Sangalli <alesan@manoweb.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.13.orig/drivers/pci/quirks.c
+++ linux-2.6.17.13/drivers/pci/quirks.c
@@ -390,6 +390,7 @@ static void __devinit quirk_piix4_acpi(s
 	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi );
 
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at

--
