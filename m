Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272388AbTHIPiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272396AbTHIPiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:38:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42501 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272388AbTHIPiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:38:19 -0400
Date: Sat, 9 Aug 2003 16:38:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Molina <tmolina@cablespeed.com>,
       James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test3: logo patch
Message-ID: <20030809163812.A22875@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	James Simmons <jsimmons@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org> <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>; from tmolina@cablespeed.com on Sat, Aug 09, 2003 at 11:00:57AM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 11:00:57AM -0500, Thomas Molina wrote:
> The following patch has been floating around forever.  Can we get it in 
> mainstream sometime in the near future?
> 
> --- linux-2.5-tm/drivers/video/cfbimgblt.c.orig	2003-08-08 17:42:16.000000000 -0500
> +++ linux-2.5-tm/drivers/video/cfbimgblt.c	2003-08-08 17:42:30.000000000 -0500
> @@ -325,7 +325,7 @@
>  		else 
>  			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
>  					start_index, pitch_index);
> -	} else if (image->depth == bpp) 
> +	} else if (image->depth <= bpp) 
>  		color_imageblit(image, p, dst1, start_index, pitch_index);
>  }
>  

Is this patch _still_ not in the kernel.

Linus - please merge this patch - its required for several ARM framebuffer
drivers, and several other drivers.  James has indicated that this is the
correct fix back in May:

On Tue, May 13, 2003 at 11:41:34PM +0100, James Simmons wrote:
> At the very bottom of cfbimgblt.c change
>
> } else if (image->depth == bpp)
>
> to
>
> } else if (image->depth <= bpp)
>
> and tell me if this works.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

