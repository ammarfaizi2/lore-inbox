Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUJ1OZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUJ1OZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUJ1OXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:23:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8323 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261609AbUJ1OVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:21:41 -0400
Message-ID: <41810066.5000705@pobox.com>
Date: Thu, 28 Oct 2004 10:21:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due
 to pci_save_state change)
References: <20041028025536.5d9b1067.akpm@osdl.org>
In-Reply-To: <20041028025536.5d9b1067.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Begin forwarded message:
> 
> Date: Thu, 28 Oct 2004 17:34:19 +0800 (CST)
> From: "Zhu, Yi" <yi.zhu@intel.com>
> To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due to pci_save_state change)
> 
> 
> 
> Hi,
> 
> Recent 2.6.10-rc1 merged the pci_save_state change. This prevents some
> drivers from working with suspend/resume. The reason is the
> pci_save_state() called in driver's ->suspend doesn't take effect any more,
> since pci bus ->suspend will override it. And the two states might be
> different in some drivers, i.e. e100. I don't know if there are other
> drivers also suffer from it.
> 
> Thanks,
> -yi
> 
> 
> Signed-off-by: Zhu Yi <yi.zhu@intel.com>
> 
> --- /tmp/e100.c	2004-10-28 16:31:41.000000000 +0800
> +++ drivers/net/e100.c	2004-10-28 16:33:14.000000000 +0800
> @@ -2309,9 +2309,7 @@ static int e100_suspend(struct pci_dev *
>  
> -	pci_save_state(pdev);
>  	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
> -	pci_disable_device(pdev);
>  	pci_set_power_state(pdev, state);


I'm waiting for Greg to respond to the serious concerns raised by 
BenH[1] and me[2].

AFAICS, Greg has broken the standard Linux "driver knows it, driver does 
it" model.

	Jeff


[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=109867742404637&w=2
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=109868495426108&w=2
