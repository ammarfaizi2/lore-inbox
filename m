Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVKYVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVKYVCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 16:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbVKYVCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 16:02:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13704 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751481AbVKYVCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 16:02:05 -0500
Date: Fri, 25 Nov 2005 22:01:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add basic PM support for Nvidia and ATI AGP bridges
Message-ID: <20051125210156.GA2272@elf.ucw.cz>
References: <20051124060030.GF28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124060030.GF28070@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I retrieved these from the swsusp2 patchset, but they seem to be 
> independently useful. As a result, I'm not sure who the original author 
> is - however, they seem to be pretty obvious.
> 
> ## All lines beginning with `## DP:' are a description of the patch.
> ## DP: Description: Add suspend/resume support to ATI and Nvidia AGP bridges
> ## DP: Patch author: Unknown
> ## DP: Upstream status: Not submitted
> 
> . $(dirname $0)/DPATCH

> @@ -507,6 +507,33 @@ static void __devexit agp_ati_remove(str
>  	agp_put_bridge(bridge);
>  }
>  
> +#ifdef CONFIG_PM
> +
> +static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	pci_save_state (pdev);
> +	pci_set_power_state (pdev, 3);

PCI_D3hot, please.

> +static int agp_ati_resume(struct pci_dev *pdev)
> +{
> +	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
> +
> +	/* set power state 0 and restore PCI space */
> +	pci_set_power_state (pdev, 0);

PCI_D0... ....and same in other two functions. Otherwise it looks ok.

								Pavel
-- 
Thanks, Sharp!
