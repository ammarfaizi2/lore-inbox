Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQK3Vw4>; Thu, 30 Nov 2000 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbQK3Vwr>; Thu, 30 Nov 2000 16:52:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55565 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129183AbQK3Vw2>;
	Thu, 30 Nov 2000 16:52:28 -0500
Date: Thu, 30 Nov 2000 22:21:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Pries <PriesRx@hlyw.com>
Cc: Glen Gerber <GlenG@hlyw.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace wrong structure type in mmc_ioctl() in cdrom.c
Message-ID: <20001130222153.A16299@suse.de>
In-Reply-To: <sa264be0.009@hlyw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sa264be0.009@hlyw.com>; from PriesRx@hlyw.com on Thu, Nov 30, 2000 at 12:45:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30 2000, Richard Pries wrote:
> Jens, 
> 
> Please consider the following patch for the wrong type of structure 
> in mmc_ioctl() in cdrom.c.
> 
> Currently, mmc_ioctl() in cdrom.c is passed a cdrom_msf structure 
> when ioctl() is called with CDROMREADRAW, CDROMREADMODE1, or 
> CDROMREADMODE2 as its second argument.  This structure does not 
> provide the required buffer for reading the data, and it does not 
> correspond to the structure that cdrom.h says to use with these 
> ioctl() calls. This patch replaces the cdrom_msf structure with a 
> cdrom_read structure (as specified in cdrom.h).  Preliminary tests 
> indicate that this patch works for both IDE and SCSI drives.   

Sure I bet it works, but you just broke all the programs that currently
use any of the above ioctls. I've known about this for years... You
can do all that you want with cdrom_msf, it's just more hassle. For
2.5 I'll introduce newer variants of the above ioctls and keep them as-is
for compatability, tossing them out is not an option.

I will take a patch that corrects the comment though!

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
