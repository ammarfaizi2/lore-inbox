Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVCGBNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVCGBNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCGBMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:12:50 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:21011 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261619AbVCGBMd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:12:33 -0500
Message-ID: <422BAA75.9030109@snapgear.com>
Date: Mon, 07 Mar 2005 11:12:21 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>,
       dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-mm1] mtd: fix INFTL failure handling
References: <20050306175139.GA6192@mech.kuleuven.ac.be>
In-Reply-To: <20050306175139.GA6192@mech.kuleuven.ac.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Panagiotis,

Panagiotis Issaris wrote:
> The INFTL mount code contains a kmalloc() followed by a memset() without
> handling a possible memory allocation failure.
> 
> Signed-off-by: <panagiotis.issaris@mech.kuleuven.ac.be>

OK, that looks good.
Dave do you want to take this, or do you want me to submit it?

Regards
Greg



> diff -pruN linux-2.6.11-orig/drivers/mtd/inftlmount.c linux-2.6.11-pi/drivers/mtd/inftlmount.c
> --- linux-2.6.11-orig/drivers/mtd/inftlmount.c	2005-03-05 03:08:52.000000000 +0100
> +++ linux-2.6.11-pi/drivers/mtd/inftlmount.c	2005-03-06 18:17:15.000000000 +0100
> @@ -574,6 +574,12 @@ int INFTL_mount(struct INFTLrecord *s)
>  
>  	/* Temporary buffer to store ANAC numbers. */
>  	ANACtable = kmalloc(s->nb_blocks * sizeof(u8), GFP_KERNEL);
> +	if (!ANACtable) {
> +		printk(KERN_WARNING "INFTL: allocation of ANACtable "
> +				"failed (%zd bytes)\n",
> +				s->nb_blocks * sizeof(u8));
> +		return -ENOMEM;
> +	}
>  	memset(ANACtable, 0, s->nb_blocks);
>  
>  	/*
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
