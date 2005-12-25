Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVLYVOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVLYVOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVLYVOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:14:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56719 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750933AbVLYVOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:14:38 -0500
Date: Sun, 25 Dec 2005 22:14:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ati-agp suspend/resume support
Message-ID: <20051225211414.GA1943@elf.ucw.cz>
References: <43AF0122.9030904@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AF0122.9030904@kroon.co.za>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Based on the patch at
> http://unixhead.org/docs/thinkpad/ati-agp/ati-agp.diff, add support for
> suspend/resume in the ati-agp module.
> 
> Signed-of-by: Jaco Kroon <jaco@kroon.co.za>
> 
> --- linux-2.6.15-rc6/drivers/char/agp/ati-agp.c.orig	2005-12-25
> 22:21:32.000000000 +0200
> +++ linux-2.6.15-rc6/drivers/char/agp/ati-agp.c	2005-12-25
> 22:23:33.000000000 +0200
> @@ -243,6 +243,15 @@
>  	return 0;
>  }
> 
> +static int ati_resume(struct pci_dev *dev)
> +{
> +	return ati_configure();
> +}
> +
> +static int ati_suspend(struct pci_dev *dev, pm_message_t state)
> +{
> +	return 0;
> +}

I think you can just leave out empty function; that should work,
too. Otherwise it looks good, thanks... ...

>  /*
>   *Since we don't need contigious memory we just try
> @@ -525,6 +534,8 @@
>  	.id_table	= agp_ati_pci_table,
>  	.probe		= agp_ati_probe,
>  	.remove		= agp_ati_remove,
> +	.resume		= ati_resume,
> +	.suspend	= ati_suspend,
>  };

...aha, plus you may want to keep naming convention. It should
probably be agp_ati_resume.
							Pavel
-- 
Thanks, Sharp!
