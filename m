Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWIGUGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWIGUGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWIGUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:06:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33412 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751962AbWIGUGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:06:30 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45007B8C.5090002@s5r6.in-berlin.de>
Date: Thu, 07 Sep 2006 22:05:32 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: bcollins@debian.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: set power state of firewire host during suspend
References: <20060905081426.GA4105@elf.ucw.cz>
In-Reply-To: <20060905081426.GA4105@elf.ucw.cz>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Put firewire host controller in PCI Dx state for system suspend.
> (I was not able to measure any power savings, but it sounds like right
> thing to do, anyway.)
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
[...]
> --- a/drivers/ieee1394/ohci1394.c
> +++ b/drivers/ieee1394/ohci1394.c
> @@ -3565,6 +3565,7 @@ static int ohci1394_pci_suspend (struct 
>  	}
>  #endif
>  
> +	pci_set_power_state(pdev, pci_choose_state(pdev, state));
>  	return 0;
>  }

The order with existing PPC_PMAC code needs to be swapped. And the
resume hook should set the power state too, right? I will post an update
patch soon.
-- 
Stefan Richter
-=====-=-==- =--= --===
http://arcgraph.de/sr/
