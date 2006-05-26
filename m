Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbWEZAiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWEZAiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWEZAiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:38:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3259 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965218AbWEZAiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:38:01 -0400
Message-ID: <44764DE3.5090506@pobox.com>
Date: Thu, 25 May 2006 20:37:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       stevel@mvista.com, source@mvista.com
Subject: Re: [PATCH 3/3] pci: gt96100eth avoid pci_find_device
References: <20060526001155.4828DC7C5E@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060526001155.4828DC7C5E@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> gt96100eth avoid pci_find_device
> 
> Change pci_find_device to safer pci_get_device.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit f656671e9da9d33bd7a2fb3f5c0d0f7009925698
> tree b92c808b6a9eecce58b0f7b0ffe1237631dbd65a
> parent 1d3b6caf027fe53351c645523587aeac40bc3e47
> author Jiri Slaby <ku@bellona.localdomain> Fri, 26 May 2006 01:55:23 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Fri, 26 May 2006 01:55:23 +0159
> 
>  drivers/net/gt96100eth.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/gt96100eth.c b/drivers/net/gt96100eth.c
> index 2d24354..beac56d 100644
> --- a/drivers/net/gt96100eth.c
> +++ b/drivers/net/gt96100eth.c
> @@ -613,9 +613,9 @@ static int gt96100_init_module(void)
>  	/*
>  	 * Stupid probe because this really isn't a PCI device
>  	 */
> -	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> +	if (!(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
>  	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
> -	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> +	    !(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
>  		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
>  		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
>  		return -ENODEV;

Seems OK to me, though you may wish to use a pci_device_id list with 
pci_match_[one_]device() here too.

	Jeff



