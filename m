Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVAYUC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVAYUC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVAYUBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:01:14 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:61863 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261928AbVAYT7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:59:09 -0500
Message-ID: <41F6A4E7.6090105@ens-lyon.fr>
Date: Tue, 25 Jan 2005 20:58:31 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F4E28A.3090305@ens-lyon.fr> <20050124185258.GB27570@redhat.com> <20050124204458.GD27570@redhat.com> <41F56949.3010505@ens-lyon.fr> <20050125193822.GC9267@redhat.com>
In-Reply-To: <20050125193822.GC9267@redhat.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080300080106060102010109"
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080300080106060102010109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dave Jones a écrit :
> This is needed too on top of -mm1.
> 
> diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> --- a/drivers/char/agp/generic.c	2005-01-25 14:34:24 -05:00
> +++ b/drivers/char/agp/generic.c	2005-01-25 14:34:24 -05:00
> @@ -324,9 +324,9 @@
>  	info->chipset = agp_bridge->type;
>  	info->device = agp_bridge->dev;
>  	if (check_bridge_mode(agp_bridge->dev))
> -		info->mode = agp_bridge->mode & AGP3_RESERVED_MASK;
> +		info->mode = agp_bridge->mode & ~AGP3_RESERVED_MASK;
>  	else
> -		info->mode = agp_bridge->mode & AGP2_RESERVED_MASK;
> +		info->mode = agp_bridge->mode & ~AGP2_RESERVED_MASK;
>  	info->aper_base = agp_bridge->gart_bus_addr;
>  	info->aper_size = agp_return_size();
>  	info->max_memory = agp_bridge->max_memory_agp;
> 

Maybe that's not important, but on top of my -rc2-mm1, your patch looks like the
one I attached to this mail.

Regards,
Brice

--------------080300080106060102010109
Content-Type: text/x-patch;
 name="fix-agp-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-agp-mode.patch"

diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2005-01-25 14:34:24 -05:00
+++ b/drivers/char/agp/generic.c	2005-01-25 14:34:24 -05:00
@@ -328,9 +328,9 @@
 	info->chipset = SUPPORTED;
 	info->device = bridge->dev;
 	if (check_bridge_mode(bridge->dev))
-		info->mode = bridge->mode & AGP3_RESERVED_MASK;
+		info->mode = bridge->mode & ~AGP3_RESERVED_MASK;
 	else
-		info->mode = bridge->mode & AGP2_RESERVED_MASK;
+		info->mode = bridge->mode & ~AGP2_RESERVED_MASK;
 	info->mode = bridge->mode;
 	info->aper_base = bridge->gart_bus_addr;
 	info->aper_size = agp_return_size();

--------------080300080106060102010109--
