Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVJQCsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVJQCsm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVJQCsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:48:42 -0400
Received: from sccrmhc13.comcast.net ([63.240.76.28]:4071 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932144AbVJQCsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:48:41 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Intel SATA combined mode quirk broken for SCSI_SATA=m
Date: Sun, 16 Oct 2005 19:48:27 -0700
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <200510161913.59622.jbarnes@virtuousgeek.org> <43530D67.6020209@pobox.com>
In-Reply-To: <43530D67.6020209@pobox.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8DxUDubCMc89rCd"
Message-Id: <200510161948.28154.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8DxUDubCMc89rCd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday, October 16, 2005 7:33 pm, Jeff Garzik wrote:
> Overall the quirk is a hack until ATAPI is supported -- but even after
> ATAPI is supported, we need to figure out some way to keep IDE driver
> from stealing the legacy IDE ports before libata can touch them :(
>
> However, when ATAPI is supported, that at least means that both PATA and
> SATA can run at full speed.

But then can't we remove the quirk and just declare them incompatible (i.e. 
who loads first, wins)?

> Your patch is correct, and should go into 2.6.14-rc post-haste.

Well, almost. :)  I diffed against a bad version.  This one should actually 
apply.

Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>


--Boundary-00=_8DxUDubCMc89rCd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="intel-combined-mode-quirk-hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="intel-combined-mode-quirk-hack.patch"

--- linux-2.6.14-rc4/drivers/pci/quirks.c.orig	2005-10-16 19:46:43.000000000 -0700
+++ linux-2.6.14-rc4/drivers/pci/quirks.c	2005-10-16 19:12:33.000000000 -0700
@@ -1233,7 +1233,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
-#ifdef CONFIG_SCSI_SATA
+#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;

--Boundary-00=_8DxUDubCMc89rCd--
