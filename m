Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265017AbUFAMuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265017AbUFAMuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbUFAMuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:50:22 -0400
Received: from gprs214-199.eurotel.cz ([160.218.214.199]:14464 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265019AbUFAMuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:50:16 -0400
Date: Tue, 1 Jun 2004 14:50:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Message-ID: <20040601125008.GE10233@elf.ucw.cz>
References: <200405281404.10538@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405281404.10538@zodiac.zodiac.dnsalias.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> suspending of the e1000 in my Thinkpad did not work, so I jst started some 
> hacking. The attached patch does the trick for me, it just disables/enables 
> the device. I used 2.6.7-rc1-mm1, but it should apply to rc1 also. If it's 
> correct (Hey, I'm just beginning..), it could perhaps be 
> applied to mainline / mm?

> --- linux-2.6.7-rc1-ag1/drivers/net/e1000/e1000_main.c	2004-05-26 23:25:40.000000000 +0200
> +++ linux-2.6.7-rc1-mm1/drivers/net/e1000/e1000_main.c	2004-05-27 23:53:54.000000000 +0200
> @@ -2864,6 +2864,8 @@
>  		}
>  	}
>  
> +	pci_disable_device(pdev);
> +	
>  	state = (state > 0) ? 3 : 0;
>  	pci_set_power_state(pdev, state);
>  
> @@ -2874,6 +2876,8 @@
>  static int
>  e1000_resume(struct pci_dev *pdev)
>  {
> +        pci_enable_device(pdev);
> +
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct e1000_adapter *adapter = netdev->priv;
>  	uint32_t manc;

Whitespace damage here (tabs vs. spaces) plus you really should not
call procedure before variable declarations. Otherwise looks good.

								Pavel


-- 
934a471f20d6580d5aad759bf0d97ddc
