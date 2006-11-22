Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755193AbWKVPqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbWKVPqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbWKVPq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:46:29 -0500
Received: from emulex.emulex.com ([138.239.112.1]:45799 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1755193AbWKVPq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:46:28 -0500
Message-ID: <4564706E.9060900@emulex.com>
Date: Wed, 22 Nov 2006 10:44:46 -0500
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 5/5] lpfc : Make Emulex lpfc driver legacy I/O port free
References: <4564051C.3080908@jp.fujitsu.com>
In-Reply-To: <4564051C.3080908@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 15:44:49.0663 (UTC) FILETIME=[24D618F0:01C70E4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK  :)

(I thought this had already gone in a while ago)

-- james s

Hidetoshi Seto wrote:
> This patch makes Emulex lpfc driver legacy I/O port free.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> 
> ---
>  drivers/scsi/lpfc/lpfc_init.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.19-rc6/drivers/scsi/lpfc/lpfc_init.c
> ===================================================================
> --- linux-2.6.19-rc6.orig/drivers/scsi/lpfc/lpfc_init.c
> +++ linux-2.6.19-rc6/drivers/scsi/lpfc/lpfc_init.c
> @@ -1453,10 +1453,11 @@
>  	int error = -ENODEV, retval;
>  	int i;
>  	uint16_t iotag;
> +	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
> 
> -	if (pci_enable_device(pdev))
> +	if (pci_enable_device_bars(pdev, bars))
>  		goto out;
> -	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
> +	if (pci_request_selected_regions(pdev, bars, LPFC_DRIVER_NAME))
>  		goto out_disable_device;
> 
>  	host = scsi_host_alloc(&lpfc_template, sizeof (struct lpfc_hba));
> @@ -1759,7 +1760,7 @@
>  	phba->host = NULL;
>  	scsi_host_put(host);
>  out_release_regions:
> -	pci_release_regions(pdev);
> +	pci_release_selected_regions(pdev, bars);
>  out_disable_device:
>  	pci_disable_device(pdev);
>  out:
> @@ -1773,6 +1774,7 @@
>  	struct Scsi_Host   *host = pci_get_drvdata(pdev);
>  	struct lpfc_hba    *phba = (struct lpfc_hba *)host->hostdata;
>  	unsigned long iflag;
> +	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
> 
>  	lpfc_free_sysfs_attr(phba);
> 
> @@ -1816,7 +1818,7 @@
>  	iounmap(phba->ctrl_regs_memmap_p);
>  	iounmap(phba->slim_memmap_p);
> 
> -	pci_release_regions(phba->pcidev);
> +	pci_release_selected_regions(phba->pcidev, bars);
>  	pci_disable_device(phba->pcidev);
> 
>  	idr_remove(&lpfc_hba_index, phba->brd_no);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
