Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWFMQZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWFMQZA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWFMQY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:24:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:11381 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932171AbWFMQY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:24:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fk7Qc9cS5YR2hBb6+D6uocVVVFFfdKtWu5lV3vSm/9/KxUUScZ6/XYWTcUPa3DxqatmdN/j7edHE54oVJa7WIS63HxE55o/zXAasdCRhraifRTTtZpWOgLv+ZpmPOYv2u98doB0IC/TZRHY6ji24TN18TcZQNH5o6uDLKFldq6A=
Message-ID: <4807377b0606130924i4b5ea36aq83b8db050831bea4@mail.gmail.com>
Date: Tue, 13 Jun 2006 09:24:55 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 03/16] 64bit resource: fix up printks for resources in networks drivers
Cc: linux-kernel@vger.kernel.org, "Greg Kroah-Hartman" <gregkh@suse.de>,
       "NetDEV list" <netdev@vger.kernel.org>
In-Reply-To: <11501586871870-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060613003033.GA10717@kroah.com>
	 <11501586781628-git-send-email-greg@kroah.com>
	 <1150158683636-git-send-email-greg@kroah.com>
	 <11501586871870-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, added netdev,

On 6/12/06, Greg KH <greg@kroah.com> wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
>
> This is needed if we wish to change the size of the resource structures.
>
> Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>
>
> Cc: Vivek Goyal <vgoyal@in.ibm.com>
> Cc: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/net/3c59x.c            |    6 ++++--
>  drivers/net/8139cp.c           |    9 +++++----
>  drivers/net/8139too.c          |    6 +++---
>  drivers/net/e100.c             |    4 ++--
>  drivers/net/skge.c             |    4 ++--
>  drivers/net/sky2.c             |    6 +++---
>  drivers/net/tulip/de2104x.c    |    9 +++++----
>  drivers/net/tulip/tulip_core.c |    6 +++---
>  drivers/net/typhoon.c          |    5 +++--
>  drivers/net/wan/dscc4.c        |   12 ++++++------
>  drivers/net/wan/pc300_drv.c    |    4 ++--
>  11 files changed, 38 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/e100.c b/drivers/net/e100.c
> index 31ac001..0c0bd67 100644
> --- a/drivers/net/e100.c
> +++ b/drivers/net/e100.c
> @@ -2678,9 +2678,9 @@ #endif
>                 goto err_out_free;
>         }
>
> -       DPRINTK(PROBE, INFO, "addr 0x%lx, irq %d, "
> +       DPRINTK(PROBE, INFO, "addr 0x%llx, irq %d, "
>                 "MAC addr %02X:%02X:%02X:%02X:%02X:%02X\n",
> -               pci_resource_start(pdev, 0), pdev->irq,
> +               (unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
>                 netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
>                 netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);

color me confused, but why is this change necessary for e100?  e100
can not support 64 bit BARs, so it seems to me to make little sense to
cast to unsigned long long.  e100 is 32 bit the whole way through.

Jesse
