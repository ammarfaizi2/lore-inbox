Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJU1F>; Wed, 10 Jan 2001 15:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAJU0z>; Wed, 10 Jan 2001 15:26:55 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:21527 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129406AbRAJU0q>;
	Wed, 10 Jan 2001 15:26:46 -0500
Message-ID: <3A5CB1EE.5060400@valinux.com>
Date: Wed, 10 Jan 2001 12:03:10 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Charles McLachlan <cim20@mrao.cam.ac.uk>
CC: linux-kernel@vger.kernel.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] 2.4.0 agpgart with i815 and external card.
In-Reply-To: <Pine.SOL.4.30.0101101704070.9183-200000@mraosd.ra.phy.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles McLachlan wrote:

> My problem was that I didn't pay enough attention to the configuration
> options. I opted for *both* the 440LX/BX/GX, 815, 840, 850 support
> (CONFIG_AGP_INTEL) *and* I810/I815 (on-board) support (CONFIG_AGP_I810).
> 
> The latter was taking precedence over the former, and getting confused.
> 
> Petr Vandrovec has made the very good point that, to stop others from
> getting as confused as me, agpgart should default to generic intel if it
> can't find the onboard i815 video card.
> 
> It's a very small patch (one line really) which I present for your
> consideration.
> 
> Thanks to Alan Cox and Petr for putting me right.
> 
> Charlie - Queens' College - Cavendish Astrophysics - 07866 636318
> 
> 
> ------------------------------------------------------------------------
> 
> --- drivers/char/agp/agpgart_be_original.c	Wed Jan 10 16:59:35 2001
> +++ drivers/char/agp/agpgart_be.c	Wed Jan 10 17:00:54 2001
> @@ -2373,9 +2373,9 @@
>  			if (i810_dev == NULL) {
>  				printk(KERN_ERR PFX "agpgart: Detected an "
>  				       "Intel i815, but could not find the"
> -				       " secondary device.\n");
> -				agp_bridge.type = NOT_SUPPORTED;
> -				return -ENODEV;
> +				       " secondary device. Assuming a "
> +				       "non-integrated video card.\n");
> +				break;
>  			}
>  			printk(KERN_INFO PFX "agpgart: Detected an Intel i815 "
>  			       "Chipset.\n");
> agppatch
> 
> Content-Type:
> 
> TEXT/PLAIN
> Content-Encoding:
> 
> BASE64

This looks reasonable, and it will probably avoid alot of people from 
emailing me. ;)  It has my vote for 2.4.1.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
