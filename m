Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWC3Iv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWC3Iv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWC3Iv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:51:56 -0500
Received: from ns2.suse.de ([195.135.220.15]:19120 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751182AbWC3Ivz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:51:55 -0500
Date: Thu, 30 Mar 2006 10:51:53 +0200
From: Karsten Keil <kkeil@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH] ISDN: fix a few resource leaks in sc_ioctl()
Message-ID: <20060330085153.GA1033@pingi.kke.suse.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel@vger.kernel.org, Karsten Keil <kkeil@suse.de>,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	isdn4linux@listserv.isdn4linux.de
References: <200603261616.25741.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603261616.25741.jesper.juhl@gmail.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 04:16:25PM +0200, Jesper Juhl wrote:
> 
> Fix a few resource leaks in drivers/isdn/sc/ioctl.c::sc_ioctl()
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Acked-by: Karsten Keil <kkeil@suse.de>

> ---
> 
>  drivers/isdn/sc/ioctl.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.16-mm1-orig/drivers/isdn/sc/ioctl.c	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.16-mm1/drivers/isdn/sc/ioctl.c	2006-03-26 16:11:49.000000000 +0200
> @@ -46,7 +46,8 @@ int sc_ioctl(int card, scs_ioctl *data)
>  		pr_debug("%s: SCIOCRESET: ioctl received\n",
>  			sc_adapter[card]->devicename);
>  		sc_adapter[card]->StartOnReset = 0;
> -		return (reset(card));
> +		kfree(rcvmsg);
> +		return reset(card);
>  	}
>  
>  	case SCIOCLOAD:
> @@ -183,7 +184,7 @@ int sc_ioctl(int card, scs_ioctl *data)
>  				sc_adapter[card]->devicename);
>  
>  		spid = kmalloc(SCIOC_SPIDSIZE, GFP_KERNEL);
> -		if(!spid) {
> +		if (!spid) {
>  			kfree(rcvmsg);
>  			return -ENOMEM;
>  		}
> @@ -195,10 +196,10 @@ int sc_ioctl(int card, scs_ioctl *data)
>  		if (!status) {
>  			pr_debug("%s: SCIOCGETSPID: command successful\n",
>  					sc_adapter[card]->devicename);
> -		}
> -		else {
> +		} else {
>  			pr_debug("%s: SCIOCGETSPID: command failed (status = %d)\n",
>  				sc_adapter[card]->devicename, status);
> +			kfree(spid);
>  			kfree(rcvmsg);
>  			return status;
>  		}
> 
> 

-- 
Karsten Keil
SuSE Labs
ISDN development
