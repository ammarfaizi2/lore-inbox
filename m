Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbSJNR5y>; Mon, 14 Oct 2002 13:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSJNR5y>; Mon, 14 Oct 2002 13:57:54 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5638 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262055AbSJNR5U>;
	Mon, 14 Oct 2002 13:57:20 -0400
Date: Mon, 14 Oct 2002 11:03:25 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC] device_initialize()
Message-ID: <20021014180325.GC7462@kroah.com>
References: <20021014172422.GE6955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014172422.GE6955@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:24:22AM -0700, Greg KH wrote:
> +/**
>   * device_register - register a device
>   * @dev:	pointer to the device structure
>   *
> @@ -167,15 +188,10 @@
>  	if (!dev || !strlen(dev->bus_id))
>  		return -EINVAL;
>  
> -	INIT_LIST_HEAD(&dev->node);
> -	INIT_LIST_HEAD(&dev->children);
> -	INIT_LIST_HEAD(&dev->g_list);
> -	INIT_LIST_HEAD(&dev->driver_list);
> -	INIT_LIST_HEAD(&dev->bus_list);
> -	INIT_LIST_HEAD(&dev->intf_list);
> -	spin_lock_init(&dev->lock);
> -	atomic_set(&dev->refcount,2);
> -	dev->present = 1;
> +	if (dev->state != DEVICE_INITIALIZED)
> +		return -EINVAL;
> +
> +	get_device(dev);
>  	spin_lock(&device_lock);
>  	if (dev->parent) {
>  		get_device_locked(dev->parent);
> @@ -212,6 +228,7 @@
>  		if (dev->parent)
>  			put_device(dev->parent);
>  	}
> +	dev->state = DEVICE_INITIALIZED;


As someone just kindly pointed out to me, this should be
DEVICE_REGISTERED.  Sorry about that.

thanks,

greg k-h
