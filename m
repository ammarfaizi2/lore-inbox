Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVC0WCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVC0WCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVC0WCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:02:47 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:53255 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261600AbVC0WCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:02:31 -0500
Date: Mon, 28 Mar 2005 00:02:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/media/usbvideo.c: fix a check after use
Message-Id: <20050328000229.15860997.khali@linux-fr.org>
In-Reply-To: <20050327204852.GC4285@stusta.de>
References: <20050327204852.GC4285@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch fixes a check after use found by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm1-full/drivers/usb/media/usbvideo.c.old	2005-03-23 04:59:11.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/usb/media/usbvideo.c	2005-03-23 04:59:46.000000000 +0100
> @@ -1814,12 +1814,12 @@
>  {
>  	int i, j;
>  
> -	if (uvd->debug > 1)
> -		info("%s($%p)", __FUNCTION__, uvd);
> -
>  	if ((uvd == NULL) || (!uvd->streaming) || (uvd->dev == NULL))
>  		return;
>  
> +	if (uvd->debug > 1)
> +		info("%s($%p)", __FUNCTION__, uvd);
> +

Note that you slightly change the debug trace when doing this. For
example, the case where udv != NULL and !udv->streaming would display
the debug line before your patch, and no more after.

Now I don't know whether that change is a problem or not in this
particular case, as I am not the one who would debug this driver if
there were a problem with it, but this is something to pay attention to
in such cases.

Thanks,
-- 
Jean Delvare
