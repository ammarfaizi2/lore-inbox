Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSHNOWD>; Wed, 14 Aug 2002 10:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHNOWD>; Wed, 14 Aug 2002 10:22:03 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:45707 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318772AbSHNOWC>; Wed, 14 Aug 2002 10:22:02 -0400
Date: Wed, 14 Aug 2002 09:22:28 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020814142228.GB17969@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <3D59F22E.D0DA5FC6@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D59F22E.D0DA5FC6@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Greg Banks]
> warning:drivers/parport/Config.in:14:forward declared symbol "CONFIG_SERIAL" compared ambiguously to "n"
> warning:drivers/parport/Config.in:14:forward reference to "CONFIG_SERIAL"
> warning:drivers/parport/Config.in:15:forward reference to "CONFIG_SERIAL"
> 
> 
> warning:drivers/char/Config.in:193:forward declared symbol "CONFIG_PCMCIA" compared ambiguously to "n"
> warning:drivers/char/pcmcia/Config.in:8:forward declared symbol "CONFIG_PCMCIA" used in dependency list for "CONFIG_SYNCLINK_CS"
> warning:drivers/ide/Config.in:19:forward declared symbol "CONFIG_PCMCIA" used in dependency list for "CONFIG_BLK_DEV_IDECS"
> warning:drivers/isdn/hardware/avm/Config.in:20:forward declared symbol "CONFIG_PCMCIA" used in dependency list for "CONFIG_ISDN_DRV_AVMB1_AVM_CS"

Hmmm, either I missed those in your earlier messages, or you didn't
post them.

> > +# FIXME usb should depend on (PCI || SA1111) - but that causes other ordering problems
> > +tristate 'USB support' CONFIG_USB
> 
> Nasty.

Yeah, I don't see any clean fix for that one.

> > +# FIXME parisc, sparc didn't include this menu before - any reason?
> 
> I'd suggest preserving that behaviour.  CONFIG_PARISC for parisc.

...and CONFIG_SPARC32 for sparc.  Thanks.  I didn't notice
CONFIG_SPARC32 because it's not defined in time for init/config.in.
Time for another trivial patch....

> > +   dep_tristate '  I2C bit-banging interfaces' CONFIG_I2C_ALGOBIT $CONFIG_I2C
> > +fi
> > +
> >  endmenu
> 
> Are you sure want this one there?

I didn't like it either, but it's needed in a couple odd places.  What
would you suggest - moving the whole i2c menu up?

> Your first patch made the following improvements
> 
> --- s-2.5.31.txt	Wed Aug 14 15:51:44 2002
> +++ s-2.5.31-sam1.txt	Wed Aug 14 15:52:48 2002

Thanks, your "oracle" feedback is much appreciated.

> Your second patch made the following improvements (well,
> mostly improvements).
> 
> --- s-2.5.31-sam1.txt	Wed Aug 14 15:52:48 2002
> +++ s-2.5.31-sam2.txt	Wed Aug 14 15:56:09 2002
> @@ -206,3 +206,3 @@
>      1      CONFIG_WILLOW
> -61     different-parent
> +66     different-parent
>      7      CONFIG_NET_FC
> @@ -210,2 +210,5 @@
>      2      CONFIG_FB
> +    2      CONFIG_KMOD
> +    2      CONFIG_MODULES
> +    2      CONFIG_MODVERSIONS
>      2      CONFIG_RTC

What does that mean?  All I did there was to combine two toplevel
menus into one.  Did this do something bad?

> -36     overlapping-definitions
> +38     overlapping-definitions
>      11     CONFIG_SOUND_CMPCI_FMIO
> @@ -261,2 +263,3 @@
>      2      CONFIG_PARPORT
> +    2      CONFIG_USB

OK, I see CONFIG_USB in arch/cris/drivers/Config.in - is there another
instance I'm missing?

> -8      different-compound-type
> -3290   total
> +10     different-compound-type
> +3055   total

different-compound-type?

Peter
