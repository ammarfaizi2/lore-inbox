Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSKZQyJ>; Tue, 26 Nov 2002 11:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbSKZQyI>; Tue, 26 Nov 2002 11:54:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8716 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266417AbSKZQyH>;
	Tue, 26 Nov 2002 11:54:07 -0500
Message-ID: <3DE3A8B4.8030205@pobox.com>
Date: Tue, 26 Nov 2002 12:00:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] memleak in myri_sbus
References: <200211260413.gAQ4DMX25528@hera.kernel.org>
In-Reply-To: <200211260413.gAQ4DMX25528@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:

> diff -Nru a/drivers/net/myri_sbus.c b/drivers/net/myri_sbus.c
> --- a/drivers/net/myri_sbus.c	Mon Nov 25 20:13:24 2002
> +++ b/drivers/net/myri_sbus.c	Mon Nov 25 20:13:24 2002
> @@ -1085,6 +1085,7 @@
>  #endif
>  	return 0;
>  err:	unregister_netdev(dev);
> +	kfree(dev->priv);
>  	kfree(dev);
>  	return -ENODEV;
>  }
> @@ -1142,6 +1143,7 @@


another bogus one, please revert.


>
>
>  		unregister_netdev(root_myri_dev->dev);
>  		kfree(root_myri_dev->dev);
> +		kfree(root_myri_dev);
>  		root_myri_dev = next;
>  	}



likewise.

	Jeff



