Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUFBUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUFBUjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUFBUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:39:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:58570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264119AbUFBUiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:38:54 -0400
Date: Wed, 2 Jun 2004 13:33:07 -0700
From: Greg KH <greg@kroah.com>
To: Tobias Weisserth <tobias@weisserth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.6.4] EagleTec (rev 1.13) USB external harddisk support -> patch to unusual_devs.h
Message-ID: <20040602203307.GA19749@kroah.com>
References: <1086086759.10599.14.camel@coruscant.weisserth.net> <20040602165723.GI7829@kroah.com> <1086200163.8709.8.camel@coruscant.weisserth.net> <20040602182131.GA13193@kroah.com> <1086207977.8707.38.camel@coruscant.weisserth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086207977.8707.38.camel@coruscant.weisserth.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 10:26:18PM +0200, Tobias Weisserth wrote:
> Hi Greg,
> 
> On Wed, 2004-06-02 at 20:21, Greg KH wrote:
> ...
> > I did that in the response I wrote above.  Look in the Documentation
> > directory of the kernel source for the SubmittingPatches file...
> 
> Stupid me. I didn't know until then that there is so much documentation
> already included with the kernel sources...
> 
> > Good luck,
> 
> Well, I hope I did this right.
> 
> This is the patch:
> 
> ######################################
> 
> --- drivers/usb/storage/unusual_devs.h.orig	2004-06-02
> 21:53:18.292064768 +0200
> +++ drivers/usb/storage/unusual_devs.h	2004-06-02 22:00:39.486992944
> +0200
> @@ -409,6 +409,17 @@ UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0x
>  		US_SC_DEVICE, US_PR_DEVICE, NULL,
>  		US_FL_FIX_INQUIRY ),
>  
> +/* Reported by Tobias Weisserth <tobias@weisserth.org>
> + * Some EagleTec devices don't work with the other entry for EagleTec. 
> + * EagleTec devices with revision 1.13 like the "Pocket Boy" need a
> slight adjustment.
> + * That is the only reason this entry is needed.
> +*/
> +UNUSUAL_DEV(  0x05e3, 0x0702, 0x0113, 0x0113,
> +                "EagleTec",
> +                "External Hard Disk",
> +                US_SC_DEVICE, US_PR_DEVICE, NULL,
> +                US_FL_FIX_INQUIRY ),
> +
>  /* Reported by Hanno Boeck <hanno@gmx.de>
>   * Taken from the Lycoris Kernel */
>  UNUSUAL_DEV(  0x0636, 0x0003, 0x0000, 0x9999,
> 
> ######################################
> 
> I hope there is no problem with the line wrapping and I did this
> right... first timer :-/

The patch got line-wrapped :(

Care to try it again?

> The patch applies to version 2.6.4 from www.kernel.org. It also works
> with Con Kolivas' sources version 2.6.4. I guess if all the symbols that
> are being used in the unit entry haven't disappeared from later kernel
> versions then it can be applied to later (or earlier) versions as well.

You might want to see if the patch is still needed on 2.6.6 as that is
the latest kernel.  I need a diff against that kernel version.

thanks,

greg k-h
