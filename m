Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVHLUQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVHLUQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVHLUQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:16:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:28879 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750788AbVHLUQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:16:18 -0400
To: Greg KH <greg@kroah.com>
Cc: ohnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org
Subject: Re: w1: more debug level decrease.
References: <20050812184622.GA19999@kroah.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Aug 2005 22:16:12 +0200
In-Reply-To: <20050812184622.GA19999@kroah.com.suse.lists.linux.kernel>
Message-ID: <p737jeq3o8j.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> Here's a patch for 2.6.13-rc6 to keep people's syslogs a bit nicer.

But why is this thing running every 10 seconds at all in the first place?
Looks to me like you're just hiding the symptoms, not fixing the bug
that makes this code run on unsuspecting systems.

e.g. one way would be to only probe once and then never again. 

-Andi

> 
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> Do not spam syslog each 10 seconds when there is nothing on the wire.
> 
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/w1/w1.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- gregkh-2.6.orig/drivers/w1/w1.c	2005-08-02 13:41:30.000000000 -0700
> +++ gregkh-2.6/drivers/w1/w1.c	2005-08-12 11:42:04.000000000 -0700
> @@ -593,7 +593,7 @@
>  		 * Return 0 - device(s) present, 1 - no devices present.
>  		 */
>  		if (w1_reset_bus(dev)) {
> -			dev_info(&dev->dev, "No devices present on the wire.\n");
> +			dev_dbg(&dev->dev, "No devices present on the wire.\n");
>  			break;
>  		}
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
