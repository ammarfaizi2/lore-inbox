Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVBPDAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVBPDAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 22:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVBPDAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 22:00:53 -0500
Received: from [205.233.219.253] ([205.233.219.253]:21693 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261869AbVBPDAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 22:00:45 -0500
Date: Tue, 15 Feb 2005 17:12:42 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, bcollins@debian.org,
       ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: FIx u32 vs. pm_message_t confusion in firewire
Message-ID: <20050215221242.GO9231@conscoop.ottawa.on.ca>
References: <20050214134658.324076c9.akpm@osdl.org> <20050215004759.GE5415@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215004759.GE5415@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 01:47:59AM +0100, Pavel Machek wrote:
> Hi!
> 
> This should fix u32 vs. pm_message_t confusion in firewire. No code
> changes. Please apply,
> 							Pavel

Applied to 1394 SVN and development bitkeeper.  I will send this
upstream sometime after 2.6.11.

Thanks,
Jody

> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> --- clean-mm/drivers/ieee1394/nodemgr.c	2005-02-15 00:46:40.000000000 +0100
> +++ linux-mm/drivers/ieee1394/nodemgr.c	2005-02-15 01:04:10.000000000 +0100
> @@ -1284,7 +1284,7 @@
>  
>  		if (ud->device.driver &&
>  		    (!ud->device.driver->suspend ||
> -		      ud->device.driver->suspend(&ud->device, 0, 0)))
> +		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND, 0)))
>  			device_release_driver(&ud->device);
>  	}
>  	up_write(&ne->device.bus->subsys.rwsem);
> --- clean-mm/drivers/ieee1394/ohci1394.c	2005-02-15 00:46:40.000000000 +0100
> +++ linux-mm/drivers/ieee1394/ohci1394.c	2005-02-15 01:04:10.000000000 +0100
> @@ -3546,7 +3546,7 @@
>  }
>  
>  
> -static int ohci1394_pci_suspend (struct pci_dev *pdev, u32 state)
> +static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
>  {
>  #ifdef CONFIG_PMAC_PBOOK
>  	{
> 
> 
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

-- 
