Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWF0PJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWF0PJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWF0PJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:09:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:62157 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161086AbWF0PJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=qesCe6ODE4bS49aMPy641izxL07vkpVNzxKYndqe7nRJdQYRitclUSh7/z0pyO/y/AjIBE4IahFA0Q1orrqKLusECJKHcFFrEFQPrhBenuDjgDmFrx0VxEiWV1zkbft3s5KOW5xy2ryKYqRe4/KEGb0/pDe0FqrsjZDuU+RTWok=
Message-ID: <44A14A5F.3090607@gmail.com>
Date: Tue, 27 Jun 2006 17:10:23 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use dev_printk() in some net drivers
References: <20060627145145.GA30053@havoc.gtf.org>
In-Reply-To: <20060627145145.GA30053@havoc.gtf.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik napsal(a):
> commit 25a0324ef1c1b181c9d00f09837e8757875ee2a4
> Author: Jeff Garzik <jeff@garzik.org>
> Date:   Tue Jun 27 10:47:51 2006 -0400
> 
>     [netdrvr] Use dev_printk() when ethernet interface isn't available
> 
>     For messages prior to register_netdev(), prefer dev_printk() because
>     that prints out both our driver name and our [PCI | whatever] bus id.
> 
>     Updates: 8139{cp,too}, b44, bnx2, cassini, {eepro,epic}100, fealnx,
>          hamachi, ne2k-pci, ns83820, pci-skeleton, r8169.
> 
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
>  drivers/net/8139cp.c       |   36 +++++++++++++++++++++---------------
>  drivers/net/8139too.c      |   41 +++++++++++++++++++++++++----------------
>  drivers/net/b44.c          |   28 +++++++++++++++-------------
>  drivers/net/bnx2.c         |   37 ++++++++++++++++++++++---------------
>  drivers/net/cassini.c      |   20 ++++++++++----------
>  drivers/net/eepro100.c     |    8 +++++---
>  drivers/net/epic100.c      |   23 ++++++++++++-----------
>  drivers/net/fealnx.c       |   17 +++++++++--------
>  drivers/net/hamachi.c      |    3 ++-
>  drivers/net/ne2k-pci.c     |   12 ++++++++----
>  drivers/net/ns83820.c      |   14 +++++++++-----
>  drivers/net/pci-skeleton.c |   24 +++++++++++++++---------
>  drivers/net/r8169.c        |   43 +++++++++++++++++++------------------------
>  13 files changed, 172 insertions(+), 134 deletions(-)
> 
> 25a0324ef1c1b181c9d00f09837e8757875ee2a4
> diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
> index 0cdc830..c38e352 100644
> --- a/drivers/net/8139cp.c
> +++ b/drivers/net/8139cp.c
> @@ -1837,9 +1837,11 @@ #endif
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_REALTEK &&
>  	    pdev->device == PCI_DEVICE_ID_REALTEK_8139 && pci_rev < 0x20) {
> -		printk(KERN_ERR PFX "pci dev %s (id %04x:%04x rev %02x) is not an 8139C+ compatible chip\n",
> -		       pci_name(pdev), pdev->vendor, pdev->device, pci_rev);
> -		printk(KERN_ERR PFX "Try the \"8139too\" driver instead.\n");
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "This (id %04x:%04x rev %02x) is not an 8139C+ compatible chip\n",
> +		           pdev->vendor, pdev->device, pci_rev);
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "Try the \"8139too\" driver instead.\n");
>  		return -ENODEV;
>  	}
>  

Don't you consider to use s#dev_printk(KERN_ERR, #dev_err(# macro?

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
