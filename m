Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWIOOMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWIOOMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWIOOMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:12:32 -0400
Received: from h155.mvista.com ([63.81.120.155]:35536 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1751496AbWIOOMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:12:31 -0400
Message-ID: <450AB54F.5000905@ru.mvista.com>
Date: Fri, 15 Sep 2006 18:14:39 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] piix: Use refcounted interface when searching for a 450NX
References: <1158329678.29932.41.camel@localhost.localdomain>
In-Reply-To: <1158329678.29932.41.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> Simple conversion
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c
> --- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-11 17:00:09.000000000 +0100
> +++ linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-14 17:19:12.000000000 +0100
> @@ -602,7 +602,7 @@
>  	struct pci_dev *pdev = NULL;
>  	u16 cfg;
>  	u8 rev;
> -	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> +	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
>  	{
>  		/* Look for 450NX PXB. Check for problem configurations
>  		   A PCI quirk checks bit 6 already */

    Shouldn't pci_put_dev() be called after the bridge device no longer needed?
I assume it's not needed anymore after this function is finished...

WBR, Sergei
