Return-Path: <linux-kernel-owner+w=401wt.eu-S964981AbXAJR1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbXAJR1d (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbXAJR1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:27:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44467 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981AbXAJR1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:27:32 -0500
Message-ID: <45A521FD.7060303@pobox.com>
Date: Wed, 10 Jan 2007 12:27:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: PIIX3 support
References: <20070110171338.5cd555b1@localhost.localdomain>
In-Reply-To: <20070110171338.5cd555b1@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> @@ -786,7 +797,8 @@
>  			    { 2, 3 }, };
>  
>  	pci_read_config_word(dev, master_port, &master_data);
> -	pci_read_config_byte(dev, 0x48, &udma_enable);
> +	if (ap->udma_mask)
> +		pci_read_config_byte(dev, 0x48, &udma_enable);
>  
>  	if (speed >= XFER_UDMA_0) {
>  		unsigned int udma = adev->dma_mode - XFER_UDMA_0;

This creates a situation where the code modifies an uninitialized 
variable.  Ultimately irrelevant, but please init udma_enable to zero so 
that at least it is valid C code.

Otherwise ACK.

	Jeff


