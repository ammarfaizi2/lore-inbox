Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVLMUJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVLMUJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVLMUJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:09:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751369AbVLMUJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:09:02 -0500
Date: Tue, 13 Dec 2005 21:09:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
Message-ID: <20051213200902.GS23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de> <20051213140001.GG23349@stusta.de> <20051213173112.GA24094@flint.arm.linux.org.uk> <Pine.LNX.4.62.0512131837380.17990@pademelon.sonytel.be> <20051213195314.GB24094@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213195314.GB24094@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 07:53:14PM +0000, Russell King wrote:
> On Tue, Dec 13, 2005 at 06:38:36PM +0100, Geert Uytterhoeven wrote:
> > On Tue, 13 Dec 2005, Russell King wrote:
> > > If, in order to have a working platform configuration, they deem that
> >                          ^^^^^^^
> > > CONFIG_BROKEN must be enabled, then that's the way it is.
> >          ^^^^^^
> > Still funny...
> > 
> > So either one of them is lying...
> 
> They might be broken in other situations.  However, if you look at
> the latest build at:
> 
>  http://armlinux.simtec.co.uk/kautobuild/
> 
> you'll notice that all, even the ones with CONFIG_BROKEN build
> successfully.  Without any bug reports to the contary, we must
> assume that the configuration files supplied by the folk who
> developed the support for the platform are correct and working.

The bug in this case was the (implicit) BROKEN dependency of MTD_SHARP.

> Therefore, CONFIG_BROKEN may have been added to configuration
> options which don't work for some particular small corner cases.

Such corner cases could easily be handled using
	depends on (BROKEN || SA1100_COLLIE)

Or in other cases wie have
	depends on (BROKEN || !64BIT)

If it works its not BROKEN, and we can express this.

> This brings on to another subject.  If we mark something broken
> we should say _why_ we're doing so, especially if it is non-obvious.
> That seems to be the case here - if these drivers are broken, it's
> non-obvious why they're broken.

The vast majority of drivers depending on BROKEN simply don't compile.

How many examples besides MTD_SHARP can you name where you have problems 
to determine why something is marked as BROKEN?

> So, all in all, CONFIG_BROKEN is a broken idea in itself!

The idea behind BROKEN is to not offer drivers where we know that they 
don't compile or will for sure not work to users.

The ARM case that people are using the supplied defconfig's more or less 
unchanged is a big exception.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

