Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319355AbSHOBX3>; Wed, 14 Aug 2002 21:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319356AbSHOBX3>; Wed, 14 Aug 2002 21:23:29 -0400
Received: from rj.SGI.COM ([192.82.208.96]:14309 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319355AbSHOBX0>;
	Wed, 14 Aug 2002 21:23:26 -0400
Message-ID: <3D5B03A9.4E3CE764@alphalink.com.au>
Date: Thu, 15 Aug 2002 11:28:09 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <3D59F22E.D0DA5FC6@alphalink.com.au> <20020814142228.GB17969@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Greg Banks]
> > [...CONFIG_SERIAL and CONFIG_PCMCIA warnings...]
> >
> Hmmm, either I missed those in your earlier messages, or you didn't
> post them.

Probably I didn't post them.  What I posted was a small subset of the full log.

> > > +   dep_tristate '  I2C bit-banging interfaces' CONFIG_I2C_ALGOBIT $CONFIG_I2C
> >
> > Are you sure want this one there?
> 
> I didn't like it either, but it's needed in a couple odd places.  What
> would you suggest - moving the whole i2c menu up?

Not all the way up to the new menu, but before the bits that depend on them,
which are in drivers/video/ drivers/media/video and drivers/ieee1394 IIRC.

> Thanks, your "oracle" feedback is much appreciated.

I'm hoping to have an RPM out this weekend so you can do the augury yourself.

> > @@ -210,2 +210,5 @@
> >      2      CONFIG_FB
> > +    2      CONFIG_KMOD
> > +    2      CONFIG_MODULES
> > +    2      CONFIG_MODVERSIONS
> >      2      CONFIG_RTC
> 
> What does that mean?  All I did there was to combine two toplevel
> menus into one.  Did this do something bad?

Apparently.  In the stock kernel:

warning:arch/mips/config.in:224:"CONFIG_KMOD" has overlapping definitions
warning:init/Config.in:19:location of previous definition
warning:arch/parisc/config.in:53:"CONFIG_KMOD" has overlapping definitions
warning:init/Config.in:19:location of previous definition

Did I mention Gordian knot?

> > -36     overlapping-definitions
> > +38     overlapping-definitions
> >      11     CONFIG_SOUND_CMPCI_FMIO
> > @@ -261,2 +263,3 @@
> >      2      CONFIG_PARPORT
> > +    2      CONFIG_USB
> 
> OK, I see CONFIG_USB in arch/cris/drivers/Config.in - is there another
> instance I'm missing?

There's two in the same file, lines 185 and 189.

> > -8      different-compound-type
> > -3290   total
> > +10     different-compound-type
> > +3055   total
> 
> different-compound-type?

Please ignore that one.  It's an artifact of the way I check for symbols
not declared anywhere at all, related to config.in's using the same banner
for a menu and a comment.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
