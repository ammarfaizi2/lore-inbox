Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVEVKvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVEVKvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEVKvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 06:51:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43752 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261762AbVEVKvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 06:51:14 -0400
Date: Sun, 22 May 2005 12:50:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Henrik Brix Andersen <brix@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pm_message_t fix for radeon_pm.c
Message-ID: <20050522105050.GA3685@elf.ucw.cz>
References: <1116669744.14475.7.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116669744.14475.7.camel@sponge.fungus>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 21-05-05 12:02:24, Henrik Brix Andersen wrote:
> This patch adds a missing .event to pm_message_t handling in
> drivers/video/aty/radeon_pm.c for linux-2.6.12-rc4.
> 
> --- linux-2.6.12-rc4/drivers/video/aty/radeon_pm.c	2005-05-21 11:31:32.000000000 +0200
> +++ linux-2.6.12-rc4-radeon_pm/drivers/video/aty/radeon_pm.c	2005-05-21 11:34:51.000000000 +0200
> @@ -2526,11 +2526,11 @@ int radeonfb_pci_suspend(struct pci_dev 
>          struct radeonfb_info *rinfo = info->par;
>  	int i;
>  
> -	if (state == pdev->dev.power.power_state)
> +	if (state.event == pdev->dev.power.power_state.event)
>  		return 0;
>  
>  	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
> -	       pci_name(pdev), state);
> +	       pci_name(pdev), state.event);
>  
>  	/* For suspend-to-disk, we cheat here. We don't suspend anything and
>  	 * let fbcon continue drawing until we are all set. That shouldn't

Are you sure? I think you'll _break_ compilation by doing
this. pm_message_t becoming struct is not yet merged in rc4, IIRC.

								Pavel
