Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWEEAe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWEEAe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWEEAe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:34:59 -0400
Received: from xenotime.net ([66.160.160.81]:7093 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030290AbWEEAe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:34:58 -0400
Date: Thu, 4 May 2006 17:37:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org,
       jes@sgi.com, jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
Message-Id: <20060504173722.028c2b24.rdunlap@xenotime.net>
In-Reply-To: <20060504180614.X88573@chenjesu.americas.sgi.com>
References: <20060504180614.X88573@chenjesu.americas.sgi.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006 18:09:45 -0500 (CDT) Brent Casavant wrote:

> Move various QLogic, Vitesse, and Intel storage
> controller PCI IDs to the main header file.
> 
> Signed-off-by: Brent Casavant <bcasavan@sgi.com>
> 
> ---
> 
> As suggested by Andrew Morton and Jes Sorenson.

as compared to:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b860b8c4bde5949b272968597d1426d53080532


>  drivers/scsi/qla1280.c  |   24 ------------------------
>  drivers/scsi/sata_vsc.c |   11 ++++++-----
>  include/linux/pci_ids.h |    9 +++++++++
>  3 files changed, 15 insertions(+), 29 deletions(-)
> 
> ---
> diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
> index 5a48e55..00662a5 100644
> --- a/drivers/scsi/qla1280.c
> +++ b/drivers/scsi/qla1280.c
> @@ -397,30 +397,6 @@
>  #include "ql1280_fw.h"
>  #include "ql1040_fw.h"
>  
> -
> -/*
> - * Missing PCI ID's
> - */
> -#ifndef PCI_DEVICE_ID_QLOGIC_ISP1080
> -#define PCI_DEVICE_ID_QLOGIC_ISP1080	0x1080
> -#endif
> -#ifndef PCI_DEVICE_ID_QLOGIC_ISP1240
> -#define PCI_DEVICE_ID_QLOGIC_ISP1240	0x1240
> -#endif
> -#ifndef PCI_DEVICE_ID_QLOGIC_ISP1280
> -#define PCI_DEVICE_ID_QLOGIC_ISP1280	0x1280
> -#endif
> -#ifndef PCI_DEVICE_ID_QLOGIC_ISP10160
> -#define PCI_DEVICE_ID_QLOGIC_ISP10160	0x1016
> -#endif
> -#ifndef PCI_DEVICE_ID_QLOGIC_ISP12160
> -#define PCI_DEVICE_ID_QLOGIC_ISP12160	0x1216
> -#endif
> -
> -#ifndef PCI_VENDOR_ID_AMI
> -#define PCI_VENDOR_ID_AMI               0x101e
> -#endif
> -
>  #ifndef BITS_PER_LONG
>  #error "BITS_PER_LONG not defined!"
>  #endif
> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> index 8a29ce3..27d6587 100644
> --- a/drivers/scsi/sata_vsc.c
> +++ b/drivers/scsi/sata_vsc.c
> @@ -433,13 +433,14 @@ err_out:
>  
>  
>  /*
> - * 0x1725/0x7174 is the Vitesse VSC-7174
> - * 0x8086/0x3200 is the Intel 31244, which is supposed to be identical
> - * compatibility is untested as of yet
> + * Intel 31244 is supposed to be identical.
> + * Compatibility is untested as of yet.
>   */
>  static const struct pci_device_id vsc_sata_pci_tbl[] = {
> -	{ 0x1725, 0x7174, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> -	{ 0x8086, 0x3200, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> +	{ PCI_VENDOR_ID_VITESSE, PCI_DEVICE_ID_VITESSE_VSC7174,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GD31244,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
>  	{ }
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d6fe048..c380faf 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -848,7 +848,12 @@
>  
>  
>  #define PCI_VENDOR_ID_QLOGIC		0x1077
> +#define PCI_DEVICE_ID_QLOGIC_ISP10160	0x1016
>  #define PCI_DEVICE_ID_QLOGIC_ISP1020	0x1020
> +#define PCI_DEVICE_ID_QLOGIC_ISP1080	0x1080
> +#define PCI_DEVICE_ID_QLOGIC_ISP12160	0x1216
> +#define PCI_DEVICE_ID_QLOGIC_ISP1240	0x1240
> +#define PCI_DEVICE_ID_QLOGIC_ISP1280	0x1280
>  #define PCI_DEVICE_ID_QLOGIC_ISP2100	0x2100
>  #define PCI_DEVICE_ID_QLOGIC_ISP2200	0x2200
>  #define PCI_DEVICE_ID_QLOGIC_ISP2300	0x2300
> @@ -1957,6 +1962,9 @@
>  #define PCI_VENDOR_ID_NETCELL		0x169c
>  #define PCI_DEVICE_ID_REVOLUTION	0x0044
>  
> +#define PCI_VENDOR_ID_VITESSE		0x1725
> +#define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
> +
>  #define PCI_VENDOR_ID_LINKSYS		0x1737
>  #define PCI_DEVICE_ID_LINKSYS_EG1064	0x1064
>  
> @@ -2135,6 +2143,7 @@
>  #define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
>  #define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
>  #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
> +#define PCI_DEVICE_ID_INTEL_GD31244	0x3200
>  #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
>  #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
>  #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


---
~Randy
