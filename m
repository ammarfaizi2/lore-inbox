Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWC0LGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWC0LGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWC0LGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:06:24 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:20460 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750876AbWC0LGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:06:23 -0500
Date: Mon, 27 Mar 2006 13:06:22 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Message-ID: <20060327110622.GB16409@MAIL.13thfloor.at>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	"Antonino A. Daplas" <adaplas@hotpop.com>
References: <20060327004741.GA19187@MAIL.13thfloor.at> <1143422242.3589.2.camel@localhost.localdomain> <20060327033743.GA19788@MAIL.13thfloor.at> <1143437199.2221.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143437199.2221.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 04:26:38PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:

thanks for the quick response, Tony's patch fixed
the issue for me, the console fonts are fine again.

> > after that, the screen goes white for half a second
> > and becomes black with a large terminal font on it
> > (the one I get without framebuffer, I think), the
> > text there is printed undistorted ... shortly after
> > that, I get a flash, and the mode switches to a much
> > smaller font (the final framebuffer font) and the
> > kernel messages written there are already distorted.
> > half a second later (or less) the penguin appears at
> > the top area (undistorted), when the bootup is done
> > I get the following prompt (which again is okay)
> > 
> > 	bash-2.05b#
> > 
> > typing anything there is distorted again ...
> 
> Hrm... this is a a pristine 2.6.16 without any patch applied? 

yep!

> Also, what video chip revision do you have exactly? 
> (lspci will tell you)

it did and it should have told you too :)
(it's in the original mail)

> > pressing enter several times leaves 'copies' of
> > the caracters on the screen, forming vertical bars
> > the prompt (bash) is now always fine, the copy one
> > line above (as all the others) is distorted ...
> > 
> > note, the bootup is not much different with older
> > kernels, except for the strange distortions ...
> > 
> > attached my kernel configuration, just in case
> > it is related ...
> 
> # CONFIG_VGA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> CONFIG_FONTS=y
> # CONFIG_FONT_8x8 is not set
> # CONFIG_FONT_8x16 is not set
> CONFIG_FONT_6x11=y
> CONFIG_FONT_7x14=y
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_10x18 is not set
> 
> Interesting... I suspect there is an endian bug in the new 
> font code that hits odd sized fonts (or non-multiple-of-8 
> fonts). Can you try enabling 8x8 and 8x16 instead of 6x11 
> and 7x14 fonts and tell me if those work ?

yep, 8x16 font works as it seems ...

> Tony: If my suspition is confirmed, I think that's your call :)

best,
Herbert

> Cheers,
> Ben.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
