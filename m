Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWDNB6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWDNB6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWDNB6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:58:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63197 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965033AbWDNB6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:58:48 -0400
Message-ID: <443F01CC.3080609@garzik.org>
Date: Thu, 13 Apr 2006 21:58:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 04/22] isd200: limit to BLK_DEV_IDE
References: <20060413230141.330705000@quad.kroah.org> <20060413230714.GE5613@kroah.com>
In-Reply-To: <20060413230714.GE5613@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
> are set to (y, m) since isd200 calls ide_fix_driveid() in the
> BLK_DEV_IDE code.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/usb/storage/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.16.5.orig/drivers/usb/storage/Kconfig
> +++ linux-2.6.16.5/drivers/usb/storage/Kconfig
> @@ -48,7 +48,8 @@ config USB_STORAGE_FREECOM
>  
>  config USB_STORAGE_ISD200
>  	bool "ISD-200 USB/ATA Bridge support"
> -	depends on USB_STORAGE && BLK_DEV_IDE
> +	depends on USB_STORAGE
> +	depends on BLK_DEV_IDE=y || BLK_DEV_IDE=USB_STORAGE

Wouldn't 'select' be more appropriate for IDE?

	Jeff



