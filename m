Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSHOCdS>; Wed, 14 Aug 2002 22:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSHOCdS>; Wed, 14 Aug 2002 22:33:18 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:28301 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S316491AbSHOCdR>; Wed, 14 Aug 2002 22:33:17 -0400
Date: Wed, 14 Aug 2002 21:33:45 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020815023345.GF17969@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <3D59F22E.D0DA5FC6@alphalink.com.au> <20020814142228.GB17969@cadcamlab.org> <3D5B03A9.4E3CE764@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5B03A9.4E3CE764@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Greg Banks]
> > > > +   dep_tristate '  I2C bit-banging interfaces' CONFIG_I2C_ALGOBIT $CONFIG_I2C
> > >
> > > Are you sure want this one there?
> > 
> > I didn't like it either, but it's needed in a couple odd places.  What
> > would you suggest - moving the whole i2c menu up?
> 
> Not all the way up to the new menu, but before the bits that depend on them,
> which are in drivers/video/ drivers/media/video and drivers/ieee1394 IIRC.

It should be possible to take I2C back out of init/Config.in, in that
case.  I'll do that in my tree.

> > > +    2      CONFIG_KMOD
> > > +    2      CONFIG_MODULES
> > > +    2      CONFIG_MODVERSIONS
> > >      2      CONFIG_RTC
> > 
> > What does that mean?  All I did there was to combine two toplevel
> > menus into one.  Did this do something bad?
> 
> Apparently.  In the stock kernel:
> 
> warning:arch/mips/config.in:224:"CONFIG_KMOD" has overlapping definitions
> warning:init/Config.in:19:location of previous definition
> warning:arch/parisc/config.in:53:"CONFIG_KMOD" has overlapping definitions
> warning:init/Config.in:19:location of previous definition

Weird.  These should have triggered all along - any idea why they
didn't?

Well, they're fixed in my tree.  It looks [trivial], but this one
makes me uneasy.  I mean, it's such an obvious bug - the toplevel
"Loadable module support" menu appears twice - that I almost think it
was somehow intentional.

> Did I mention Gordian knot?

Yes, I believe you did.  Does that make ESR Alexander the Great? (:

> > OK, I see CONFIG_USB in arch/cris/drivers/Config.in - is there another
> > instance I'm missing?
> 
> There's two in the same file, lines 185 and 189.

Right - they're mutually exclusive, so I thought it might only count
as one.  Anyway, fixed in my tree.

> related to config.in's using the same banner for a menu and a
> comment.

mainmenu_option next_comment ... now *there's* a bit of syntax that
needs to change.  Even config-language.txt agrees.

Peter
