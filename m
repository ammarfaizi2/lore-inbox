Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSLOAfW>; Sat, 14 Dec 2002 19:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSLOAfV>; Sat, 14 Dec 2002 19:35:21 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:44849
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266101AbSLOAfU>; Sat, 14 Dec 2002 19:35:20 -0500
Date: Sat, 14 Dec 2002 19:45:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Matthew Bell <mwsb@operamail.com>, "" <linux-parport@torque.net>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Obvious(ish): 3c515 should work if ISAPNP is a module.
In-Reply-To: <Pine.LNX.4.44.0212141709250.7099-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.50.0212141944400.32566-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0212141709250.7099-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Kai Germaschewski wrote:

> On Sun, 15 Dec 2002, Matthew Bell wrote:
>
> > This is valid for at least 2.4.20 and earlier; it works for me, and I
> > can't see any exceptional reason why it shouldn't work when ISAPNP is a
> > module.
>
> > --- linux-2.4.19.orig/drivers/net/3c515.c       2002-02-25 19:37:59.000000000 +0000
> > +++ linux-2.4.19/drivers/net/3c515.c    2002-08-03 18:24:05.000000000 +0100
> > @@ -370,7 +370,7 @@
> >         { "Default", 0, 0xFF, XCVR_10baseT, 10000},
> >  };
> >
> > -#ifdef CONFIG_ISAPNP
> > +#if defined(CONFIG_ISAPNP) || defined (CONFIG_ISAPNP_MODULE)
> >  static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
> >         {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
> >                 ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051),
> [...]
>
> It's really only obvious*ish*: If isapnp is a module but 3c515 built-in,
> you'll get link errors. The real fix for this is to do
>
> +#ifdef __ISAPNP__
>
> which will get all cases right.

... but unfortunately thats currently going away ;) to make way for
CONFIG_PNP

	Zwane
-- 
function.linuxpower.ca
