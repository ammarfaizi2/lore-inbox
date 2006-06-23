Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWFWB3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWFWB3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWFWB3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:29:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11139 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932524AbWFWB3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:29:50 -0400
Message-ID: <449B440B.7010407@garzik.org>
Date: Thu, 22 Jun 2006 21:29:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, bcasavan@sgi.com
Subject: Re: [PATCH] PCI: Move various PCI IDs to header file
References: <200606222300.k5MN0uPW000741@hera.kernel.org>
In-Reply-To: <200606222300.k5MN0uPW000741@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
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

WTF?  This is a REGRESSION from the repeatedly expressed desire -- clear 
throughout libata -- that single-use PCI device IDs should not ever 
receive PCI_DEVICE_ID_xxx constants.

I'm going to queue up a revert patch for this silliness.

Next time, please let the relevant maintainer(s) know when you are 
touching their driver, so they have a chance to filter out the crap.

This was -never- sent to me or linux-ide, or otherwise brought to the 
attention of the maintainers.

	Jeff


