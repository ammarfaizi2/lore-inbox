Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWHRGHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWHRGHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWHRGHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:07:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:18845 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964857AbWHRGHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:07:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44E55887.2050309@s5r6.in-berlin.de>
Date: Fri, 18 Aug 2006 08:04:55 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: stable@kernel.org, Adrian Bunk <bunk@stusta.de>
CC: danny@mailmij.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix for recently added firewire patch that breaks things
 on	ppc
References: <20060805151050.B24484@luna.ellen.dexterslabs.com>	<1155118273.4040.81.camel@localhost.localdomain>	<20060809151226.A31391@luna.ellen.dexterslabs.com>	<1155201211.17187.128.camel@localhost.localdomain> <20060818072143.A32418@luna.ellen.dexterslabs.com>
In-Reply-To: <20060818072143.A32418@luna.ellen.dexterslabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Tholen wrote:
>     Recently a patch was added for preliminary suspend/resume 
>     handling on !PPC_PMAC. However, this broke both suspend and firewire
>     on powerpc because it saves the pci state after the device has already
>     been disabled.
>  
>     This moves the save state to before the pmac specific code.
>     Please apply before 2.6.18.
> 
>     Signed-off-by: Danny Tholen <obiwan at mailmij.org>

This fix should go into 2.6.17.x and 2.6.16.yy too. (I sent the patch 
with the regression also to Adrian recently.)

> --- linux-2.6.17.7/drivers/ieee1394/ohci1394.c~ 2006-08-09 09:00:32.556422070 -0400
> +++ linux-2.6.17.7/drivers/ieee1394/ohci1394.c  2006-08-09 09:02:53.546090923 -0400
> @@ -3548,6 +3548,8 @@
>  
>  static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
>  {
> +	pci_save_state(pdev);
> +
>  #ifdef CONFIG_PPC_PMAC
>  	if (machine_is(powermac)) {
>  		struct device_node *of_node;
> @@ -3559,8 +3561,6 @@
>  	}
>  #endif
>  
> -	pci_save_state(pdev);
> -
>  	return 0;
>  } 
> 

-- 
Stefan Richter
-=====-=-==- =--- =--=-
http://arcgraph.de/sr/
