Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUKNTsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUKNTsb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKNTsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 14:48:30 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:41688 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261343AbUKNTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 14:48:25 -0500
Date: Sun, 14 Nov 2004 23:06:17 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] matrox w1: fix integer to pointer conversion warnings
Message-ID: <20041114230617.5ce14ce9@zanzibar.2ka.mipt.ru>
In-Reply-To: <41974A6C.20302@ppp0.net>
References: <41974A6C.20302@ppp0.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004 13:07:08 +0100
Jan Dittmer <jdittmer@ppp0.net> wrote:

> Get rid of some pointer to integer conversion warnings
> in the matrox w1 bus driver.

I believe it should be done using __iomem * conversation.
I will create a patch later.

Thank you.

> Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>
> 
> diff -Nru a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
> --- a/drivers/w1/matrox_w1.c	2004-11-14 13:03:45 +01:00
> +++ b/drivers/w1/matrox_w1.c	2004-11-14 13:03:45 +01:00
> @@ -78,11 +78,12 @@
> 
>  struct matrox_device
>  {
> -	unsigned long base_addr;
> -	unsigned long port_index, port_data;
> +	char *base_addr;
> +	char *port_index, *port_data;
>  	u8 data_mask;
> 
> -	unsigned long phys_addr, virt_addr;
> +	unsigned long phys_addr;
> +	char *virt_addr;
>  	unsigned long found;
> 
>  	struct w1_bus_master *bus_master;
> @@ -181,8 +182,7 @@
> 
>  	dev->phys_addr = pci_resource_start(pdev, 1);
> 
> -	dev->virt_addr =
> -		(unsigned long) ioremap_nocache(dev->phys_addr, 16384);
> +	dev->virt_addr = ioremap_nocache(dev->phys_addr, 16384);
>  	if (!dev->virt_addr) {
>  		dev_err(&pdev->dev, "%s: failed to ioremap(0x%lx, %d).\n",
>  			__func__, dev->phys_addr, 16384);


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
