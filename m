Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291281AbSAaUil>; Thu, 31 Jan 2002 15:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291283AbSAaUig>; Thu, 31 Jan 2002 15:38:36 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:31750 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291281AbSAaUiT>;
	Thu, 31 Jan 2002 15:38:19 -0500
Date: Thu, 31 Jan 2002 12:49:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: mochel@osdl.org, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020131124942.A37@toy.ucw.cz>
In-Reply-To: <20020130002418.GB21784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020130002418.GB21784@kroah.com>; from greg@kroah.com on Tue, Jan 29, 2002 at 04:24:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  static int __init device_init_root(void)
>  {
> -	/* initialize parent bus lists */
> -	return iobus_register(&device_root);
> +	device_root = kmalloc(sizeof(*device_root),GFP_KERNEL);
> +	if (!device_root)
> +		return -ENOMEM;
> +	memset(device_root,0,sizeof(*device_root));
> +	strcpy(device_root->bus_id,"root");
> +	strcpy(device_root->name,"System Root");
> +	return device_register(device_root);
>  }

Why don't you leave device_root allocated statically?

> @@ -1430,9 +1419,11 @@
>  		return NULL;
>  	list_add_tail(&b->node, &pci_root_buses);
>  
> -	sprintf(b->iobus.bus_id,"pci%d",bus);
> -	strcpy(b->iobus.name,"Host/PCI Bridge");
> -	iobus_register(&b->iobus);
> +	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
Uff...				~~~~~~~~~ would not "struct device" (or
what should it be) look better?

> +	memset(b->dev,0,sizeof(*(b->dev)));

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

