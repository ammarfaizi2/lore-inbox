Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWJDWFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWJDWFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWJDWFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:05:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53142 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751186AbWJDWFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:05:54 -0400
Date: Thu, 5 Oct 2006 00:05:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: matthieu castet <castet.matthieu@free.fr>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: Re: [PATCH 1/3] UEAGLE : be suspend friendly
Message-ID: <20061004220548.GC8667@elf.ucw.cz>
References: <4522BE19.1070103@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522BE19.1070103@free.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You marked all the patches as 1/3, btw.

> this patch avoid that the kernel thread block the suspend process.
> Some work is still need to recover after a resume.
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
> 

> this patch avoid that the kernel thread block the suspend process.
> Some work is still need to recover after a resume.
> 
> Signed-off-by: matthieu castet <castet.matthieu@free.fr>
> Index: linux/drivers/usb/atm/ueagle-atm.c
> ===================================================================
> --- linux.orig/drivers/usb/atm/ueagle-atm.c	2006-09-22 21:39:56.000000000 +0200
> +++ linux/drivers/usb/atm/ueagle-atm.c	2006-09-22 21:40:45.000000000 +0200
> @@ -1177,6 +1177,9 @@
>  			ret = uea_stat(sc);
>  		if (ret != -EAGAIN)
>  			msleep(1000);
> + 		if (try_to_freeze())
> +			uea_err(INS_TO_USBDEV(sc), "suspend/resume not supported, "
> +				"please unplug/replug your modem\n");

Plug/unplug should be easy enough to simulate from usb driver, no?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
