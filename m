Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUKPV1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUKPV1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUKPVZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:25:04 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:35597 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261821AbUKPVYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:24:42 -0500
Date: Tue, 16 Nov 2004 22:25:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Thomas Leibold" <thomas@plx.com>
Cc: greg@kroah.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] i2c-nforce2.c add support for nForce3 Pro 150 MCP
Message-Id: <20041116222506.7c64e122.khali@linux-fr.org>
In-Reply-To: <36881.192.168.0.19.1100639614.squirrel@192.168.0.12>
References: <36129.192.168.0.19.1100598647.squirrel@192.168.0.12>
	<hKBrMfMm.1100605629.3776330.khali@gcu.info>
	<36881.192.168.0.19.1100639614.squirrel@192.168.0.12>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(As a side note I applied your 2.4 patch to lm_sensors CVS.)

> This patch applies to linux 2.6.10-RC1. I tried to follow the
> procedures in Documentation/SubmittingPatches and I hope I got
> everything right.

Looks good to me except:

> @@ -53,6 +55,10 @@ MODULE_DESCRIPTION("nForce2 SMBus driver
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
>  #endif
>  
> +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS   0x00D4
> +#endif
> +
> (...)
> --- linux-2.6.10-rc1/include/linux/pci_ids.h	2004-11-16 10:22:15.000000000 -0800
> +++ patched/include/linux/pci_ids.h	2004-11-16 11:21:28.223690880 -0800
> @@ -1081,6 +1081,7 @@
>  #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
>  #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
>  #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
>  #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
>  #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
> @@ -1092,6 +1093,7 @@
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
>  #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
>  #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
>  #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da


You're correct that the IDs are better added to pci_ids.h, but then the
ifndef blocks in the driver become useless and can be discarded.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
