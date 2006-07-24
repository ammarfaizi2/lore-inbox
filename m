Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWGXARw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWGXARw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 20:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWGXARw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 20:17:52 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:51544 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751123AbWGXARv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 20:17:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GiBFLAjonr2oMsLcF7r+s9HaEMqR9HvB3AAjK68s90jdD1lQNh9ces6aOplEmEFD4voIvV+AvW5bGrXqDQ7gHR0PrXy+slSjudyjk3iTitIeNYXMJJY4CZeMJKJ35lt7aQvhrivuYUwm23fDj4sZOieyEe+akacHbMxPZWluyOA=
Message-ID: <44C411A2.4030904@gmail.com>
Date: Mon, 24 Jul 2006 08:17:38 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] rivafb/nvidiafb: race between register_framebuffer and
 *_bl_init
References: <20060722162821.GA4791@bogon.ms20.nix> <20060722163657.GA5699@bogon.ms20.nix>
In-Reply-To: <20060722163657.GA5699@bogon.ms20.nix>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Guenther wrote:

Please add your Signed-off-by:

Tony

> Hi,
> On Sat, Jul 22, 2006 at 06:28:21PM +0200, Guido Guenther wrote:
>> This fixes booting current git on a PB 6,1, please apply if it looks
>> correct - in this case radeonfb/atyfb would be affected too - I can fix
>> that too but don't have any hardware to test this on.
> ...no it doesn't because the patch doesn't apply. This one does, sorry
> for the noise.
>  -- Guido
> 
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
> index 9f2066f..eae291e 100644
> --- a/drivers/video/nvidia/nvidia.c
> +++ b/drivers/video/nvidia/nvidia.c
> @@ -1303,20 +1303,19 @@ #endif				/* CONFIG_MTRR */
>  
>  	nvidia_save_vga(par, &par->SavedReg);
>  
> +	pci_set_drvdata(pd, info);
> +	nvidia_bl_init(par);
>  	if (register_framebuffer(info) < 0) {
>  		printk(KERN_ERR PFX "error registering nVidia framebuffer\n");
>  		goto err_out_iounmap_fb;
>  	}
>  
> -	pci_set_drvdata(pd, info);
>  
>  	printk(KERN_INFO PFX
>  	       "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
>  	       info->fix.id,
>  	       par->FbMapSize / (1024 * 1024), info->fix.smem_start);
>  
> -	nvidia_bl_init(par);
> -
>  	NVTRACE_LEAVE();
>  	return 0;
>  
> diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
> index 33dddba..43aa8be 100644
> --- a/drivers/video/riva/fbdev.c
> +++ b/drivers/video/riva/fbdev.c
> @@ -2132,6 +2132,9 @@ #endif /* CONFIG_MTRR */
>  
>  	fb_destroy_modedb(info->monspecs.modedb);
>  	info->monspecs.modedb = NULL;
> +
> +	pci_set_drvdata(pd, info);
> +	riva_bl_init(info->par);
>  	ret = register_framebuffer(info);
>  	if (ret < 0) {
>  		printk(KERN_ERR PFX
> @@ -2139,8 +2142,6 @@ #endif /* CONFIG_MTRR */
>  		goto err_iounmap_screen_base;
>  	}
>  
> -	pci_set_drvdata(pd, info);
> -
>  	printk(KERN_INFO PFX
>  		"PCI nVidia %s framebuffer ver %s (%dMB @ 0x%lX)\n",
>  		info->fix.id,
> @@ -2148,8 +2149,6 @@ #endif /* CONFIG_MTRR */
>  		info->fix.smem_len / (1024 * 1024),
>  		info->fix.smem_start);
>  
> -	riva_bl_init(info->par);
> -
>  	NVTRACE_LEAVE();
>  	return 0;
>  
> 
> 
> Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
> 

