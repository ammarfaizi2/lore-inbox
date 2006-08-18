Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWHRQ5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWHRQ5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWHRQ5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:57:41 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:1796 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030501AbWHRQ5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:57:37 -0400
Date: Fri, 18 Aug 2006 18:57:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: [PATCH] PCI: fix ICH6 quirks
Message-Id: <20060818185743.d16d2a98.khali@linux-fr.org>
In-Reply-To: <200608181650.41869.daniel.ritz-ml@swissonline.ch>
References: <200608181650.41869.daniel.ritz-ml@swissonline.ch>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> [PATCH] PCI: fix ICH6 quirks
> 
> - add the ICH6(R) LPC to the ICH6 ACPI quirks. currently only the ICH6-M is
>   handled. [ PCI_DEVICE_ID_INTEL_ICH6_1 is the ICH6-M LPC, ICH6_0 is the ICH6(R) ]

No objection.

> - remove the wrong quirk calling asus_hides_smbus_lpc() for ICH6. the register
>   modified in asus_hides_smbus_lpc() has a different meaning in ICH6.

My mistake :( Thanks for fixing it. Do you know if executing the old
quirk on the ICH6 can cause trouble? In other words, should we backport
this fix to 2.6.17.y?

> Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
> Cc: Jean Delvare <khali@linux-fr.org>

Signed-off-by: Jean Delvare <khali@linux-fr.org>

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index fb08bc9..e4bd137 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -438,6 +438,7 @@ static void __devinit quirk_ich6_lpc_acp
>  	pci_read_config_dword(dev, 0x48, &region);
>  	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1, "ICH6 GPIO");
>  }
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc_acpi );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
>  
>  /*
> @@ -1091,7 +1092,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc );
>  
>  static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
>  {


-- 
Jean Delvare
