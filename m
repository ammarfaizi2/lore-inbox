Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277818AbRJOQg5>; Mon, 15 Oct 2001 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJOQgr>; Mon, 15 Oct 2001 12:36:47 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:61641 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277818AbRJOQgf>;
	Mon, 15 Oct 2001 12:36:35 -0400
Date: Mon, 15 Oct 2001 09:37:05 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Wireless Extension update
Message-ID: <20011015093705.A22660@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011008191247.B6816@bougret.hpl.hp.com> <200110150008.RAA09482@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110150008.RAA09482@cesium.transmeta.com>; from hpa@zytor.com on Sun, Oct 14, 2001 at 05:08:16PM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 05:08:16PM -0700, H. Peter Anvin wrote:
> Followup to:  <20011008191247.B6816@bougret.hpl.hp.com>
> By author:    Jean Tourrilhes <jt@bougret.hpl.hp.com>
> In newsgroup: linux.dev.kernel
> >  /* -------------------------- IOCTL LIST -------------------------- */
> > @@ -137,6 +144,8 @@
> >  #define SIOCGIWRANGE	0x8B0B		/* Get range of parameters */
> >  #define SIOCSIWPRIV	0x8B0C		/* Unused */
> >  #define SIOCGIWPRIV	0x8B0D		/* get private ioctl interface info */
> > +#define SIOCSIWSTATS	0x8B0E		/* Unused */
> > +#define SIOCGIWSTATS	0x8B0F		/* Get /proc/net/wireless stats */
> >  
> >  /* Mobile IP support */
> >  #define SIOCSIWSPY	0x8B10		/* set spy addresses */
> > @@ -177,11 +186,33 @@
> >  #define SIOCSIWPOWER	0x8B2C		/* set Power Management settings */
> >  #define SIOCGIWPOWER	0x8B2D		/* get Power Management settings */
> >  
> 
> Please, pretty please, use _IOC() macros...
> 
> 	-hpa

	Already discussed countless times since 96, same answer as
before : not possible.
	For normal devices, you have the full ioctl range, so you can
afford to "waste" this space by coding type/direction in the ioctl
number.
	For networking devices, only a *very* small portion of the
ioctl space goes to the driver (because the various networking
components grab tons of them), so we are required to be more
efficient.
	In summary : if you convert all the regular ifconfig ioctls
(see .../include/linux/sockios.h) to use _IOC() macros and workaround
ioctl space limitation for networking devices, then I'll fix the
wireless ioctls.
	Regards,

	Jean
