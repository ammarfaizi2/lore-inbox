Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUJTXEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUJTXEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270474AbUJTXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:00:50 -0400
Received: from baikonur.stro.at ([213.239.196.228]:6347 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S269043AbUJTW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:57:47 -0400
Date: Thu, 21 Oct 2004 00:57:48 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 ibmphp_core.c][6/8] replace pci_get_device with pci_dev_present
Message-ID: <20041020225747.GA1953@stro.at>
References: <25390000.1096500931@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25390000.1096500931@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Hanna Linder wrote:

> 
> This can be converted to pci_dev_present as the dev returned is never used.
> Compile tested.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>
> 
> diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/pci/hotplug/ibmphp_core.c linux-2.6.9-rc2-mm4patch2/drivers/pci/hotplug/ibmphp_core.c
> --- linux-2.6.9-rc2-mm4cln/drivers/pci/hotplug/ibmphp_core.c	2004-09-28 14:58:50.000000000 -0700
> +++ linux-2.6.9-rc2-mm4patch2/drivers/pci/hotplug/ibmphp_core.c	2004-09-29 15:39:39.385406240 -0700
> @@ -838,8 +838,11 @@ static int set_bus (struct slot * slot_c
>  	int rc;
>  	u8 speed;
>  	u8 cmd = 0x0;
> -	struct pci_dev *dev = NULL;
>  	int retval;
> +	static struct pci_device_id ciobx[] = {
> +		{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, 0x0101) },
> +	        { },
> +	};	
            ^^^^
white space damaged

>  
>  	debug ("%s - entry slot # %d\n", __FUNCTION__, slot_cur->number);
>  	if (SET_BUS_STATUS (slot_cur->ctrl) && is_bus_empty (slot_cur)) {
> @@ -886,8 +889,7 @@ static int set_bus (struct slot * slot_c
>  				break;
>  			case BUS_SPEED_133:
>  				/* This is to take care of the bug in CIOBX chip */
> -				while ((dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
> -							      0x0101, dev)) != NULL)
> +				if(pci_dev_present(ciobx))
>  					ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
>  				cmd = HPC_BUS_133PCIXMODE;
>  				break;
> 

first timer for your patches.
corrected for next kjt.


--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

