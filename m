Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131218AbRCGWSI>; Wed, 7 Mar 2001 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbRCGWR6>; Wed, 7 Mar 2001 17:17:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27023 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131222AbRCGWRq>;
	Wed, 7 Mar 2001 17:17:46 -0500
Message-ID: <3AA6B359.83DDB814@mandrakesoft.com>
Date: Wed, 07 Mar 2001 17:16:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: Re: [PATCH] RFC: fix ethernet device initialization
In-Reply-To: <3AA6A570.57FF2D36@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Our API already supports a solution -- setup the device, then call
> register_netdev.  The patch below adds a helper, alloc_etherdev, to
> eliminate duplicate code in drivers.  Ethernet device initialization,
> after the patch, should now look like
> 
>         dev = alloc_etherdev(sizeof(struct netdev_private));
>         ... initialize device ...
>         ... set up net_device struct members ...
>         rc = register_netdevice(dev);
>         if (rc) /* handle error */
>         netif_start_queue(dev);

Think-o in my example:  netif_start_queue occurs in dev->open(), not in
the probe phase.  Simply ignore that line in the example and you are ok.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
