Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbSJDV3j>; Fri, 4 Oct 2002 17:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSJDV3j>; Fri, 4 Oct 2002 17:29:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261818AbSJDV3i>;
	Fri, 4 Oct 2002 17:29:38 -0400
Message-ID: <3D9E0970.70903@pobox.com>
Date: Fri, 04 Oct 2002 17:34:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com> <20021004205305.GC8346@kroah.com> <20021004205410.GD8346@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> @@ -1563,13 +1562,11 @@
>  
>      if (pci_present()) {

an example of pci_present() that can be eliminated, as I described earlier


>  	for (i = 0; i < NPCI_CHIP_IDS; ++i) 
> -	    for (pci_index = 0;
> -		!pcibios_find_device (PCI_VENDOR_ID_NCR, 
> -		    pci_chip_ids[i].pci_device_id, pci_index, &pci_bus, 
> -		    &pci_device_fn); 
> -    		++pci_index)
> +	    while ((pdev = pci_find_device (PCI_VENDOR_ID_NCR,
> +					    pci_chip_ids[i].pci_device_id,
> +					    pdev)))
>  		if (!ncr_pci_init (tpnt, BOARD_GENERIC, pci_chip_ids[i].chip, 
> -		    pci_bus, pci_device_fn, /* no options */ 0))
> +		    pdev->bus->number, pdev->devfn, /* no options */ 0))


can you eliminate the need of ncr_pci_init to have number/devfn args?


