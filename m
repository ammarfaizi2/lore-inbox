Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbWJKEaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbWJKEaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 00:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbWJKEaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 00:30:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24079 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030573AbWJKEaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 00:30:11 -0400
Date: Wed, 11 Oct 2006 06:30:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Judith Lebzelter <judith@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Kconfig dependency !VT for VIOCONS
Message-ID: <20061011043006.GF721@stusta.de>
References: <20061006180549.GB3684@shell0.pdx.osdl.net> <20061006200007.GD3684@shell0.pdx.osdl.net> <20061006143437.f7338860.rdunlap@xenotime.net> <20061010045534.GA3650@stusta.de> <20061010091004.d6d91f8d.rdunlap@xenotime.net> <20061011035629.GC721@stusta.de> <20061010210858.f8c85692.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010210858.f8c85692.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 09:08:58PM -0700, Randy Dunlap wrote:
> On Wed, 11 Oct 2006 05:56:29 +0200 Adrian Bunk wrote:
> 
> > On Tue, Oct 10, 2006 at 09:10:04AM -0700, Randy Dunlap wrote:
> > > On Tue, 10 Oct 2006 06:55:34 +0200 Adrian Bunk wrote:
> > > 
> > > > On Fri, Oct 06, 2006 at 02:34:37PM -0700, Randy Dunlap wrote:
> > > > > On Fri, 6 Oct 2006 13:00:07 -0700 Judith Lebzelter wrote:
> > > > > 
> > > > > > Actually, this gets rid of the CONFIG_VIOCONS from my .config, but 
> > > > > > then I get another warning when I build:
> > > > > > 
> > > > > > Warning! Found recursive dependency: VT VIOCONS VT
> > > > > > 
> > > > > > Can anyone suggest something?
> > > > > 
> > > > > I think that your patch is mostly good/correct, but one more line
> > > > > is needed on the VT side:  a deletion.
> > > > > 
> > > > > This works for me:
> > > > > 
> > > > > From: Randy Dunlap <rdunlap@xenotime.net>
> > > > > 
> > > > > Make allmodconfig .config build successfully by making VIOCONS
> > > > > available only if VT=n.  VT need not check VIOCONS.
> > > > > 
> > > > > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > > > > ---
> > > > >  arch/powerpc/platforms/iseries/Kconfig |    2 +-
> > > > >  drivers/char/Kconfig                   |    1 -
> > > > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > --- linux-2619-rc1g2.orig/arch/powerpc/platforms/iseries/Kconfig
> > > > > +++ linux-2619-rc1g2/arch/powerpc/platforms/iseries/Kconfig
> > > > > @@ -3,7 +3,7 @@ menu "iSeries device drivers"
> > > > >  	depends on PPC_ISERIES
> > > > >  
> > > > >  config VIOCONS
> > > > > -	tristate "iSeries Virtual Console Support (Obsolete)"
> > > > > +	tristate "iSeries Virtual Console Support (Obsolete)" if !VT
> > > > >  	help
> > > > >...
> > > > >  config VT
> > > > >  	bool "Virtual terminal" if EMBEDDED
> > > > 
> > > > With this dependency on EMBEDDED, you could as well simply remove 
> > > > VIOCONS...
> > > > 
> > > > >  	select INPUT
> > > > > -	default y if !VIOCONS
> > > > 
> > > > Removing the "default y" is wrong.
> > > 
> > > Oops, yes, agreed.
> > > 
> > > I don't see a way (using: make ARCH=powerpc iseries_defconfig,
> > > which wants to enable VIOCONS) to prevent VT from being enabled
> > > so that VIOCONS can be enabled.
> > 
> > With iseries_defconfig, CONFIG_VT is not enabled.
> > 
> > > However, since VIOCONS is marked (Obsolete) and since the powerpc
> > > people don't comment on this patch & problem, maybe Judith is the
> > > only person who cares.
> > 
> > allmodconfig turns on CONFIG_EMBEDDED.
> 
> So am I doing this incorrectly?
> 
> $ make ARCH=powerpc iseries_defconfig
> 
> $editor .config
> 
> CONFIG_VT=y
> ...
> #
> # iSeries device drivers
> #
> CONFIG_VIODASD=y
> CONFIG_VIOCD=m
> CONFIG_VIOTAPE=m
> CONFIG_VIOPATH=y

CONFIG_VIOCONS is not enabled.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

