Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317562AbSFMJXq>; Thu, 13 Jun 2002 05:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317563AbSFMJXp>; Thu, 13 Jun 2002 05:23:45 -0400
Received: from skunk.directfb.org ([212.84.236.169]:27265 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S317562AbSFMJXo>; Thu, 13 Jun 2002 05:23:44 -0400
Date: Thu, 13 Jun 2002 11:23:23 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Denis Oliver Kropp <dok@directfb.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
Message-ID: <20020613092323.GA2384@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020613083243.GA32352@skunk.convergence.de> <20020613100924.A24154@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King (rmk@arm.linux.org.uk):
> On Thu, Jun 13, 2002 at 10:32:43AM +0200, Denis Oliver Kropp wrote:
> > - * Integraphics CyberPro 2000, 2010 and 5000 frame buffer device
> > + * Intergraphics CyberPro 2000, 2010 and 5000 frame buffer device
> 
> This isn't actually a spelling mistake.  The chips I have are quite
> clearly marked "Integraphics" not "Intergraphics".

Ok, I'm sorry for that, seemed obvious.

> > @@ -355,7 +367,9 @@
> >  
> >  			if (regno < 16)
> >  				((u16 *)cfb->fb.pseudo_palette)[regno] =
> > -					regno | regno << 5 | regno << 11;
> > +					((red   << 8) & 0xf800) |
> > +					((green << 3) & 0x07e0) |
> > +					((blue  >> 3));
> >  			break;
> >  		}
> >  #endif
> 
> This seems wrong.  We're setting up the DAC palette to map pixel color
> component 'regno' to 'read', 'green' and 'blue' respectively.
> 
> This means that the pseudopalette should be a 1:1 mapping of desired
> colour value (ie, the 16 VGA colors) to the DAC palette entries -
> the pseudopalette contains the pixel values to insert into the frame
> buffer for each of the 16 VGA colors.

The palette is being bypassed anyway by setting bit 4 in palette_ctrl.
Besides that I tested the rgb modes on a CyberPro 5000 with and without
this fix. The text was dark gray (as expected) in 16bit and hardly
visible in 24bit.

Why is the pseudo palette used anyway? There's no speed benefit and
applications running in true/direct color would look wrong.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
