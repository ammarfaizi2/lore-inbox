Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbTCZOMM>; Wed, 26 Mar 2003 09:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbTCZOMM>; Wed, 26 Mar 2003 09:12:12 -0500
Received: from imspcml002.netvigator.com ([203.198.23.216]:37770 "EHLO
	imspcml002.netvigator.com") by vger.kernel.org with ESMTP
	id <S261700AbTCZOML>; Wed, 26 Mar 2003 09:12:11 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Subject: Resolved: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
Date: Wed, 26 Mar 2003 22:20:17 +0800
User-Agent: KMail/1.5
References: <3E7DE01B.2B6985DF@megsinet.net> <200303241203.01814.mflt1@micrologica.com.hk> <3E81A494.FF16EBCF@megsinet.net>
In-Reply-To: <3E81A494.FF16EBCF@megsinet.net>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303262220.17895.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

Thank you for getting the fix going and sending me this patch which I applid on 2.5.66.

The problem is resolved:

  .config: CONFIG_NE2000=m

  Tested:
    network start on boot: 		OK
    several network restart:		OK
    rmmod ne 8390; network start:	OK
    several network restart:		OK

I like also to thank Adam Belay for getting this fixed.


Best Regards
Michael

 

On Wednesday 26 March 2003 21:01, you wrote:
> Michael,
>
> Adam Belay has posted some PNP patches you may want to try for 2.5.66.
>
> One of them looks like it may help...I haven't tried.
>
> Martin
>
>
>
> diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
> --- a/drivers/pnp/manager.c Tue Mar 25 21:44:41 2003
> +++ b/drivers/pnp/manager.c Tue Mar 25 21:44:41 2003
> @@ -632,8 +632,7 @@
>          if (!dev)
>                  return -EINVAL;
>          if (dev->active) {
> - pnp_info("res: The PnP device '%s' is already active.", dev->dev.bus_id);
> - return -EBUSY;
> + return 0; /* the device is already active */
>          }
>          /* If this condition is true, advanced configuration failed, we
> need to get this device up and running * so we use the simple config engine
> which ignores cold conflicts, this of course may lead to new failures */ @@
> -698,8 +697,7 @@
>          if (!dev)
>                  return -EINVAL;
>          if (!dev->active) {
> - pnp_info("res: The PnP device '%s' is already disabled.",
> dev->dev.bus_id); - return -EINVAL;
> + return 0; /* the device is already disabled */
>          }
>          if (dev->status != PNP_READY){
>                  pnp_info("res: Disable failed becuase the PnP device '%s'
> is busy.", dev->dev.bus_id);

