Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317557AbSFMJJ1>; Thu, 13 Jun 2002 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317558AbSFMJJ0>; Thu, 13 Jun 2002 05:09:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34572 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317557AbSFMJJZ>; Thu, 13 Jun 2002 05:09:25 -0400
Date: Thu, 13 Jun 2002 10:09:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Oliver Kropp <dok@directfb.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
Message-ID: <20020613100924.A24154@flint.arm.linux.org.uk>
In-Reply-To: <20020613083243.GA32352@skunk.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 10:32:43AM +0200, Denis Oliver Kropp wrote:
> - * Integraphics CyberPro 2000, 2010 and 5000 frame buffer device
> + * Intergraphics CyberPro 2000, 2010 and 5000 frame buffer device

This isn't actually a spelling mistake.  The chips I have are quite
clearly marked "Integraphics" not "Intergraphics".

> @@ -355,7 +367,9 @@
>  
>  			if (regno < 16)
>  				((u16 *)cfb->fb.pseudo_palette)[regno] =
> -					regno | regno << 5 | regno << 11;
> +					((red   << 8) & 0xf800) |
> +					((green << 3) & 0x07e0) |
> +					((blue  >> 3));
>  			break;
>  		}
>  #endif

This seems wrong.  We're setting up the DAC palette to map pixel color
component 'regno' to 'read', 'green' and 'blue' respectively.

This means that the pseudopalette should be a 1:1 mapping of desired
colour value (ie, the 16 VGA colors) to the DAC palette entries -
the pseudopalette contains the pixel values to insert into the frame
buffer for each of the 16 VGA colors.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

