Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWIPMs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWIPMs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIPMs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:48:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:6124 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964800AbWIPMs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:48:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VSws575/ZD5eeIYS0Cy71H5wJITBX/cK0YMfh3ErVNZAEQL7xUpfGI8CrRt1WGd8OOg+du0Mkebadq5zKCaFYQTK4VQmYO7DUUyyQklGgVT1xJGTvPQAjpILhrp6D9eraTK9YNh305H1uohWSiF63KHfpKjpj7ybV/Q0ZDVaZvQ=
Message-ID: <450BF28D.7010807@gmail.com>
Date: Sat, 16 Sep 2006 14:47:50 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, source@mvista.com
Subject: Re: [PATCH] gt96100: move to pci_get_device API
References: <1158330426.29932.53.camel@localhost.localdomain>
In-Reply-To: <1158330426.29932.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/net/gt96100eth.c linux-2.6.18-rc6-mm1/drivers/net/gt96100eth.c
> --- linux.vanilla-2.6.18-rc6-mm1/drivers/net/gt96100eth.c	2006-09-11 11:02:17.000000000 +0100
> +++ linux-2.6.18-rc6-mm1/drivers/net/gt96100eth.c	2006-09-14 16:45:30.000000000 +0100
> @@ -613,9 +613,9 @@
>  	/*
>  	 * Stupid probe because this really isn't a PCI device
>  	 */
> -	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> +	if (!(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
>  	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
> -	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> +	    !(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
>  		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {

They wanted pci_device_table with for_each_pci_dev+pci_match_id here...

>  		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
>  		return -ENODEV;
> @@ -630,6 +630,8 @@
>  
>  	for (i=0; i < NUM_INTERFACES; i++)
>  		retval |= gt96100_probe1(pci, i);
> +		
> +	pci_dev_put(pci);
>  
>  	return retval;
>  }

BTW. I posted something similar a while ago, but it wasn't applied (however, I 
had problems with mail-posting)
See this:
http://lkml.org/lkml/2006/5/25/304
http://lkml.org/lkml/2006/6/5/268

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
