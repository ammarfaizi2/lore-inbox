Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136186AbRECH73>; Thu, 3 May 2001 03:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136196AbRECH7U>; Thu, 3 May 2001 03:59:20 -0400
Received: from aeon.tvd.be ([195.162.196.20]:16097 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S136186AbRECH7G>;
	Thu, 3 May 2001 03:59:06 -0400
Date: Thu, 3 May 2001 09:57:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <p05100308b716bb9ed170@[207.213.214.37]>
Message-ID: <Pine.LNX.4.05.10105030956290.9438-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Jonathan Lundell wrote:
> At 3:18 AM -0400 2001-05-03, Jeff Garzik wrote:
> >"David S. Miller" wrote:
> >>  There is a school of thought which believes that:
> >>
> >  > struct xdev_regs {
> >>          u32 reg1;
> >>          u32 reg2;
> >>  };
> >  >
> >>          val = readl(&regs->reg2);
> >>
> >>  is cleaner than:
> >>
> >>  #define REG1 0x00
> >>  #define REG2 0x04
> >>
> >>          val = readl(regs + REG2);
> >>
> >>  I'm personally ambivalent and believe that both cases should be allowed.
> >
> >Agreed...  Tangent a bit, I wanted to plug using macros which IMHO make
> >code even more readable:
> >
> >	val = RTL_R32(REG2);
> >	RTL_W32(REG2, val);
> >
> >Since these are driver-private, if you are only dealing with one chip
> >you could even shorten things to "R32" and "W32", if that doesn't offend
> >any sensibilities :)
> 
> With a little arithmetic behind the scenes and a NULL pointer to the 
> struct xdev, you could have:
> 
> struct xdev_regs {
>          u32 reg1;
>          u32 reg2;
> } *xdr = 0;
> 
> #define RTL_R32(REG) readl(cookie+(unsigned long)(&xdr->REG))

You can easily get rid of the xdr variable by s/xdr/((struct xdev_regs *)0)/.

> cookie = ioremap(blah, blah);
> 
> val = RTL_R32(reg2);
> 
> ...and have the benefits of the R32 macro as well as the use of 
> structure members.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

