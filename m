Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVIJU5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVIJU5B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVIJU5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:57:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4501 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932300AbVIJU5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:57:00 -0400
Message-ID: <43234898.2040007@pobox.com>
Date: Sat, 10 Sep 2005 16:56:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 6/10] drivers/char: pci_find_device remove (drivers/char/stallion.c)
References: <200509101221.j8ACL9s5017250@localhost.localdomain>
In-Reply-To: <200509101221.j8ACL9s5017250@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>  	for (i = 0; (i < stl_nrpcibrds); i++)
> -		while ((dev = pci_find_device(stl_pcibrds[i].vendid,
> +		while ((dev = pci_get_device(stl_pcibrds[i].vendid,
>  		    stl_pcibrds[i].devid, dev))) {
>  
>  /*
> @@ -2737,8 +2737,10 @@ static inline int stl_findpcibrds(void)
>  				continue;
>  
>  			rc = stl_initpcibrd(stl_pcibrds[i].brdtype, dev);
> -			if (rc)
> +			if (rc) {
> +				pci_dev_put(dev);
>  				return(rc);
> +			}

convert to PCI probing

	Jeff



