Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWFWDEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFWDEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWFWDEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:04:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21126 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751073AbWFWDEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:04:21 -0400
Message-ID: <449B5A33.2070701@garzik.org>
Date: Thu, 22 Jun 2006 23:04:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] Add MCP65 support for ahci driver
References: <1150962004.5109.9.camel@achew-linux>
In-Reply-To: <1150962004.5109.9.camel@achew-linux>
Content-Type: multipart/mixed;
 boundary="------------010104040908040504090805"
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010104040908040504090805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Chew wrote:
> diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/drivers/scsi/ahci.c linux-2.6.16.19/drivers/scsi/ahci.c
> --- linux-2.6.16.19.original/drivers/scsi/ahci.c	2006-05-30 17:31:44.000000000 -0700
> +++ linux-2.6.16.19/drivers/scsi/ahci.c	2006-06-05 17:17:57.000000000 -0700
> @@ -290,6 +290,18 @@ static const struct pci_device_id ahci_p
>  	  board_ahci }, /* JMicron JMB360 */
>  	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* JMicron JMB363 */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* MCP65 */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI2,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* MCP65 */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI3,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* MCP65 */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI4,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* MCP65 */
>  	{ }	/* terminate list */
>  };
>  
> diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/include/linux/pci_ids.h linux-2.6.16.19/include/linux/pci_ids.h
> --- linux-2.6.16.19.original/include/linux/pci_ids.h	2006-05-30 17:31:44.000000000 -0700
> +++ linux-2.6.16.19/include/linux/pci_ids.h	2006-06-05 17:14:47.000000000 -0700
> @@ -1171,6 +1171,15 @@
>  #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
>  #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
>  #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI      0x044C
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI2     0x044D
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI3     0x044E
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI4     0x044F

Thanks.  I wound up committing the attached patch rather than yours...

	Jeff



--------------010104040908040504090805
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e261b37..82ecdef 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -285,6 +285,7 @@ static const struct ata_port_info ahci_p
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
+	/* Intel */
 	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH6 */
 	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -315,16 +316,33 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ICH8M */
 	{ PCI_VENDOR_ID_INTEL, 0x282a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH8M */
+
+	/* JMicron */
 	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB360 */
 	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB363 */
+
+	/* ATI */
 	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+
+	/* VIA */
 	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci_vt8251 }, /* VIA VT8251 */
+
+	/* NVIDIA */
+	{ PCI_VENDOR_ID_NVIDIA, 0x044c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x044d, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x044e, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x044f, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP65 */
+
 	{ }	/* terminate list */
 };
 

--------------010104040908040504090805--
