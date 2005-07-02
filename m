Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVGBSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVGBSpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 14:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGBSpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 14:45:19 -0400
Received: from fmr20.intel.com ([134.134.136.19]:37818 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261257AbVGBSo5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 14:44:57 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] ich6m-pciid-piix.patch
Date: Sat, 2 Jul 2005 11:44:32 -0700
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F5043A573F@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ich6m-pciid-piix.patch
thread-index: AcV/NMuDgalcM1O3TxWmCgGOTxYYpQAALRcg
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: <linux-ide@vger.kernel.org>, <akpm@osdl.org>, <erik@slagter.name>,
       <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>
X-OriginalArrivalTime: 02 Jul 2005 18:44:41.0275 (UTC) FILETIME=[1B4A68B0:01C57F36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not apply this patch.  The ICH6M SATA DID is all ready being used in the SATA ata_piix.c and ahci.c drivers.  Adding the ICH6M SATA DID to the PATA piix.c driver will conflict.  This patch would add the ICH6M SATA controller DID 0x2653 to the PATA piix.c driver.

Thanks,

Jason Gaston


> Message: 224
> Date: Sat, 02 Jul 2005 12:57:54 +0200
> From: Erik Slagter <erik@slagter.name>
> Subject: [PATCH] ich6m-pciid-piix.patch
> To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,    Andrew
>         Morton <akpm@osdl.org>
> Message-ID: <1120301874.4300.35.camel@localhost.localdomain>
> Content-Type: text/plain; charset="us-ascii"
>
> Hi,
>
> I am not sure someone already did this one, but it doesn't seem to be in
> git nor mm at the moment.
>
> This adds ICH6M to the pci ids of the (standard) piix ide driver. This
> makes it possible to use the standard ide driver for this chipset and
> enable udma.
>
> The other way is to use the libata driver, but this has too many
> drawback for the moment (no hdparm/smart/atapi support, with
> patch/#define it does, but doesn't work for me and crashes). Also pata
> harddisks are assigned incorrectly sda device names.
>
> This look okay to me, having said this, I must admit I don't know ***
> from this source file ;-);-)
>
> Thx.
>
> diff -ur a/drivers/ide/pci/piix.c linux-2.6.12/drivers/ide/pci/piix.c
> --- a/drivers/ide/pci/piix.c    2005-06-17 21:48:29.000000000 +0200
> +++ b/drivers/ide/pci/piix.c    2005-07-02 12:37:43.000000000 +0200
> @@ -133,6 +133,7 @@
>                 case PCI_DEVICE_ID_INTEL_82801EB_11:
>                 case PCI_DEVICE_ID_INTEL_ESB_2:
>                 case PCI_DEVICE_ID_INTEL_ICH6_19:
> +               case PCI_DEVICE_ID_INTEL_ICH6_5:
>                 case PCI_DEVICE_ID_INTEL_ICH7_21:
>                 case PCI_DEVICE_ID_INTEL_ESB2_18:
>                         mode = 3;
> @@ -447,6 +448,7 @@
>                 case PCI_DEVICE_ID_INTEL_82801E_11:
>                 case PCI_DEVICE_ID_INTEL_ESB_2:
>                 case PCI_DEVICE_ID_INTEL_ICH6_19:
> +               case PCI_DEVICE_ID_INTEL_ICH6_5:
>                 case PCI_DEVICE_ID_INTEL_ICH7_21:
>                 case PCI_DEVICE_ID_INTEL_ESB2_18:
>                 {
> @@ -575,6 +577,7 @@
>         /* 21 */ DECLARE_PIIX_DEV("ICH7"),
>         /* 22 */ DECLARE_PIIX_DEV("ICH4"),
>         /* 23 */ DECLARE_PIIX_DEV("ESB2"),
> +       /* 24 */ DECLARE_PIIX_DEV("ICH6M"),
>  };
>
>  /**
> @@ -651,6 +654,7 @@
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 21},
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 22},
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 23},
> +       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_5, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 24},
>         { 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
