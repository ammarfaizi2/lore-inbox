Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVCDXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVCDXVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbVCDXSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:18:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:42402 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263189AbVCDUy6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:58 -0500
Cc: ak@muc.de
Subject: [PATCH] PCI: allow x86_64 to do pci express
In-Reply-To: <11099696373308@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <11099696373155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.19, 2005/02/17 15:06:16-08:00, ak@muc.de

[PATCH] PCI: allow x86_64 to do pci express

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

Remove bogus dependency in PCI Express root driver.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/pcie/Kconfig |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
--- a/drivers/pci/pcie/Kconfig	2005-03-04 12:42:04 -08:00
+++ b/drivers/pci/pcie/Kconfig	2005-03-04 12:42:04 -08:00
@@ -3,7 +3,6 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express support"
-	depends on PCI_GOMMCONFIG || PCI_GOANY
 	default n
 
 	---help---

