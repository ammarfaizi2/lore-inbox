Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTEOEm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbTEOEm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:42:26 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:25542 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262413AbTEOEmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:42:24 -0400
Date: Wed, 14 May 2003 21:56:37 -0700
From: Greg KH <greg@kroah.com>
To: davej@codemonkey.org.uk, mdharm-usb@one-eyed-alien.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: mysterious shifts in USB storage drivers.
Message-ID: <20030515045637.GB5779@kroah.com>
References: <200305150331.h4F3VHID000770@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305150331.h4F3VHID000770@deviant.impure.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:31:17AM +0100, davej@codemonkey.org.uk wrote:
> These went into 2.4 over a year ago. Unfortunatly,
> with no comments in the logs.

My logs show this went into 2.4 with this comment:

  usb-storage: ISD-200 fixes, more unusual devices, and many cleanups
  
  (o) Fix to ISD-200 driver to work on big-endian platforms, including PPC.
      This has been in circulation for a while, and seems well-tested.
  (o) Add several unusual_devs.h entries
  (o) A couple more debugging improvements
  (o) A slight improvement to the EXPERIMENTAL HP82xx driver, which should
      help with newer units.
  (o) A _major_ cleanup of error handling code throughout the driver.  Note
      that this is in preparation to deploy the new error-handling state
      machine (special thanks to Alan Sterm for this work).  Right now, the
      optimizations are simple and straightforward (elimination of redundant
      code paths, etc).  Nothing tremendous, but it looks kinda invasive.

So this was a tiny part of a bigger patch.  I defer to Matt as to if
this kind of change should be put into 2.5.

thanks,

greg k-h

> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/datafab.c linux-2.5/drivers/usb/storage/datafab.c
> --- bk-linus/drivers/usb/storage/datafab.c	2003-04-10 06:01:25.000000000 +0100
> +++ linux-2.5/drivers/usb/storage/datafab.c	2003-03-17 23:42:38.000000000 +0000
> @@ -670,7 +670,7 @@ int datafab_transport(Scsi_Cmnd * srb, s
>  			srb->result = SUCCESS;
>  		} else {
>  			info->sense_key = UNIT_ATTENTION;
> -			srb->result = CHECK_CONDITION << 1;
> +			srb->result = CHECK_CONDITION;
>  		}
>  		return rc;
>  	}
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/jumpshot.c linux-2.5/drivers/usb/storage/jumpshot.c
> --- bk-linus/drivers/usb/storage/jumpshot.c	2003-04-10 06:01:25.000000000 +0100
> +++ linux-2.5/drivers/usb/storage/jumpshot.c	2003-03-17 23:42:38.000000000 +0000
> @@ -611,7 +611,7 @@ int jumpshot_transport(Scsi_Cmnd * srb, 
>  			srb->result = SUCCESS;
>  		} else {
>  			info->sense_key = UNIT_ATTENTION;
> -			srb->result = CHECK_CONDITION << 1;
> +			srb->result = CHECK_CONDITION;
>  		}
>  		return rc;
>  	}
