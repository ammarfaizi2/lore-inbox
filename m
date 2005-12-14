Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbVLNEXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbVLNEXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 23:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVLNEXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 23:23:16 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:61152 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030434AbVLNEXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 23:23:15 -0500
Message-ID: <439F9DC3.5020303@jp.fujitsu.com>
Date: Wed, 14 Dec 2005 13:21:23 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kristen Accardi <kristen.c.accardi@intel.com>
CC: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, greg@kroah.com
Subject: Re: [Pcihpd-discuss] [PATCH] acpiphp: only size new bus
References: <1134524986.6886.77.camel@whizzy>
In-Reply-To: <1134524986.6886.77.camel@whizzy>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristen,

> +				if (pass)
> +					if (dev->subordinate)
> +						pci_bus_size_bridges(dev->subordinate);

How about doing as follows. This also satisfies 80 columns rule.

	if (pass && dev->subordinate)
		pci_bus_size_bridges(dev->subordinate);

Thanks,
Kenji Kaneshige


Kristen Accardi wrote:
> Only size the bus that has been added.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com> 
> 
> drivers/pci/hotplug/acpiphp_glue.c |    4 +++-
>  drivers/pci/hotplug/acpiphp_glue.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.15-rc5.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp_glue.c
> @@ -794,12 +794,15 @@ static int enable_device(struct acpiphp_
>  			if (PCI_SLOT(dev->devfn) != slot->device)
>  				continue;
>  			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> -			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
> +			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
>  				max = pci_scan_bridge(bus, dev, max, pass);
> +				if (pass)
> +					if (dev->subordinate)
> +						pci_bus_size_bridges(dev->subordinate);
> +			}
>  		}
>  	}
>  
> -	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
>  	acpiphp_sanitize_bus(bus);
>  	pci_enable_bridges(bus);
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Pcihpd-discuss mailing list
> Pcihpd-discuss@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/pcihpd-discuss
> 

