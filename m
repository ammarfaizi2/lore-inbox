Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCKTka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCKTka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCKTfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:35:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44952 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261557AbVCKTdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:33:47 -0500
Message-ID: <4231F281.8060202@pobox.com>
Date: Fri, 11 Mar 2005 14:33:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
Subject: Re: Fix suspend/resume on via-velocity
References: <20050311141132.GA1539@elf.ucw.cz>
In-Reply-To: <20050311141132.GA1539@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> This fixes suspend-resume on via-velocity. It was confused
> w.r.t. pointers... Please apply,
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 							Pavel
> 
> --- clean-mm/drivers/net/via-velocity.c	2005-03-11 11:25:36.000000000 +0100
> +++ linux/drivers/net/via-velocity.c	2005-03-11 10:06:05.000000000 +0100
> @@ -3212,7 +3212,8 @@
>  
>  static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
>  {
> -	struct velocity_info *vptr = pci_get_drvdata(pdev);
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct velocity_info *vptr = dev->priv;
>  	unsigned long flags;
>  
>  	if(!netif_running(vptr->dev))
> @@ -3245,7 +3246,8 @@
>  
>  static int velocity_resume(struct pci_dev *pdev)
>  {
> -	struct velocity_info *vptr = pci_get_drvdata(pdev);
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct velocity_info *vptr = dev->priv;

Please use netdev_priv() rather than 'dev->priv', to eliminate a 
dereference.

	Jeff



