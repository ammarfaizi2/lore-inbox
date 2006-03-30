Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWC3XE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWC3XE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWC3XE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:04:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750939AbWC3XE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:04:56 -0500
Date: Thu, 30 Mar 2006 15:03:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Beber <beber.lkml@gmail.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org, beber@gna.org,
       akpm@osdl.org
Subject: Re: [PATCH] isd200: limit to BLK_DEV_IDE
In-Reply-To: <Pine.LNX.4.58.0603301431560.26598@shark.he.net>
Message-ID: <Pine.LNX.4.64.0603301446340.27203@g5.osdl.org>
References: <20060328075629.GA8083@kroah.com>
 <4615f4910603301146x5496ccaai17bf5f4636c91c45@mail.gmail.com>
 <Pine.LNX.4.58.0603301431560.26598@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Mar 2006, Randy.Dunlap wrote:
> 
> Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
> are set to (y, m) since isd200 calls ide_fix_driveid() in the
> BLK_DEV_IDE code.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/usb/storage/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2616-z.orig/drivers/usb/storage/Kconfig
> +++ linux-2616-z/drivers/usb/storage/Kconfig
> @@ -48,7 +48,7 @@ config USB_STORAGE_FREECOM
> 
>  config USB_STORAGE_ISD200
>  	bool "ISD-200 USB/ATA Bridge support"
> -	depends on USB_STORAGE && BLK_DEV_IDE
> +	depends on USB_STORAGE && (BLK_DEV_IDE=y || BLK_DEV_IDE=m && USB_STORAGE=m)

Hmm. That expression is _really_ hard to figure out.

It would be more logical to make it

	depends on USB_STORAGE && (BLK_DEV_IDE=y || BLK_DEV_IDE=USB_STORAGE)

or, even more preferably, split up the rules as two separate dependencies:

	depends on USB_STORAGE
	depends on BLK_DEV_IDE=y || BLK_DEV_IDE=USB_STORAGE

(where that second thing really _should_ be expressible as

	depends on BLK_DEV_IDE >= USB_STORAGE

but the kconfig language doesn't support that syntax..)

			Linus
