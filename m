Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263371AbUDZTHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUDZTHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUDZTHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:07:11 -0400
Received: from chiapa.terra.com.br ([200.154.55.224]:9916 "EHLO
	chiapa.terra.com.br") by vger.kernel.org with ESMTP id S263371AbUDZTGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:06:21 -0400
Message-ID: <408D5E59.1090009@terra.com.br>
Date: Mon, 26 Apr 2004 16:09:13 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Yee <brewt-linux-kernel@brewt.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too not running s3 suspend/resume pci fix
References: <GMail.1082958599.119234554.04321010111@brewt.org>
In-Reply-To: <GMail.1082958599.119234554.04321010111@brewt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Adrian,

Adrian Yee wrote:
> +	pci_set_power_state (pdev, 3);
> +	pci_save_state (pdev, tp->pci_state);
> +
>  	if (!netif_running (dev))
>  		return 0;
>  
> @@ -2571,9 +2574,6 @@ static int rtl8139_suspend (struct pci_d
>  
>  	spin_unlock_irqrestore (&tp->lock, flags);
>  
> -	pci_set_power_state (pdev, 3);
> -	pci_save_state (pdev, tp->pci_state);
> -
>  	return 0;
>  }

	IMHO, there's no problem in doing "pci_save_state (pdev, 
tp->pci_state)" before the suspend code..but I'm more confortable with 
leaving the set_power_state at the end of that path, since if the 
interface is down, we don't want to leave it in cold state.

> @@ -2583,10 +2583,10 @@ static int rtl8139_resume (struct pci_de
>  	struct net_device *dev = pci_get_drvdata (pdev);
>  	struct rtl8139_private *tp = dev->priv;
>  
> -	if (!netif_running (dev))
> -		return 0;
>  	pci_restore_state (pdev, tp->pci_state);
>  	pci_set_power_state (pdev, 0);
> +	if (!netif_running (dev))
> +		return 0;
>  	rtl8139_init_ring (dev);
>  	rtl8139_hw_start (dev);
>  	netif_device_attach (dev);

	Same thing here.

	Cheers,

Felipe
