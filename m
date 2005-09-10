Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVIJU4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVIJU4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVIJU4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:56:06 -0400
Received: from mail.dvmed.net ([216.237.124.58]:405 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932294AbVIJU4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:56:04 -0400
Message-ID: <43234860.7050206@pobox.com>
Date: Sat, 10 Sep 2005 16:56:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
References: <200509101221.j8ACL9XI017246@localhost.localdomain>
In-Reply-To: <200509101221.j8ACL9XI017246@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> 
>  specialix.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
> --- a/drivers/char/specialix.c
> +++ b/drivers/char/specialix.c
> @@ -2502,9 +2502,9 @@ static int __init specialix_init(void)
>  				i++;
>  				continue;
>  			}
> -			pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
> -			                        PCI_DEVICE_ID_SPECIALIX_IO8, 
> -			                        pdev);
> +			pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
> +					PCI_DEVICE_ID_SPECIALIX_IO8,
> +					pdev);
>  			if (!pdev) break;
>  
>  			if (pci_enable_device(pdev))
> @@ -2517,7 +2517,10 @@ static int __init specialix_init(void)
>  			sx_board[i].flags |= SX_BOARD_IS_PCI;
>  			if (!sx_probe(&sx_board[i]))
>  				found ++;
> +
>  		}
> +		if (i >= SX_NBOARD)
> +			pci_dev_put(pdev);

should be converted to PCI probing, rather than this.

	Jeff



