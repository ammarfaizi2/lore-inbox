Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUJIRNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUJIRNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUJIRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:13:36 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:38854 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S267250AbUJIRNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:13:34 -0400
Subject: Re: [KJ] [RFT 2.6] ebus.c replace pci_find_device with
	pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       wli@holomorphy.com
In-Reply-To: <83130000.1097274406@w-hlinder.beaverton.ibm.com>
References: <83130000.1097274406@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097342008.3903.12.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 10:13:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:26, Hanna Linder wrote:
> @@ -275,7 +275,7 @@ void __init ebus_init(void)
>  		}
>  	}
>  
> -	pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
> +	pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
>  	if (!pdev) {
>  		return;
>  	}
> @@ -342,7 +342,7 @@ void __init ebus_init(void)
>  		}
>  
>  	next_ebus:
> -		pdev = pci_find_device(PCI_VENDOR_ID_SUN,
> +		pdev = pci_get_device(PCI_VENDOR_ID_SUN,
>  				       PCI_DEVICE_ID_SUN_EBUS, pdev);
>  		if (!pdev)
>  			break;

If we can get out of the while() with pdev != NULL, then a
pci_dev_put(pdev) cleanup is required.  

-scott

