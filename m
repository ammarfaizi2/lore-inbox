Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWJRPFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWJRPFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWJRPFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:05:55 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:55517 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161072AbWJRPFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:05:54 -0400
Message-ID: <4536435A.8010002@acm.org>
Date: Wed, 18 Oct 2006 10:08:10 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IPMI] Fix return codes in failure case.
References: <20061018042817.GA7475@redhat.com>
In-Reply-To: <20061018042817.GA7475@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, looks good.

-Corey

Dave Jones wrote:
> These returns should be negative, like the others in this function.
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 24825bd..e5cfb1f 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1789,7 +1789,7 @@ static int __devinit ipmi_pci_probe(stru
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
> -		return ENOMEM;
> +		return -ENOMEM;
>  
>  	info->addr_source = "PCI";
>  
> @@ -1810,7 +1810,7 @@ static int __devinit ipmi_pci_probe(stru
>  		kfree(info);
>  		printk(KERN_INFO "ipmi_si: %s: Unknown IPMI type: %d\n",
>  		       pci_name(pdev), class_type);
> -		return ENOMEM;
> +		return -ENOMEM;
>  	}
>  
>  	rv = pci_enable_device(pdev);
>
>   

