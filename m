Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUHLTTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUHLTTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268669AbUHLTTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:19:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7655 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268672AbUHLTTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:19:08 -0400
Date: Thu, 12 Aug 2004 21:18:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040812191859.GN13377@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408120027330.20634@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 01:05:47AM +0200, Roman Zippel wrote:
> 
> 
> On Tue, 10 Aug 2004, Sam Ravnborg wrote:
> 
> > On Tue, Aug 10, 2004 at 10:44:11AM +0200, Adrian Bunk wrote:
> > > 
> > > I assume Sam thinks in the direction to let a symbol inherit the 
> > > dependencies off all symbols it selects.
> > > 
> > > E.g. in
> > > 
> > > config A
> > > 	depends on B
> > > 
> > > config C
> > > 	select A
> >         depends on Z
> > 
> >   config Z
> >         depends on Y
> > > 
> > > 
> > > C should be treated as if it would depend on B.
> 
> There are two problems:
> 1) If A has no prompt it's not visible and so it's dependency is 'n', this 
> means a number of symbols wouldn't be visible anymore.
> 2) It would change the bahaviour of symbols, which already do multiple 
> selects (e.g. CONFIG_INET_AH), the select of CRYPTO would be useless, as 
> it would only become visible, when CRYPTO is enabled. This means such 
> selects wouldn't be possible anymore.
> 
> This really needs a different (but similiar) mechanism, what I have in 
> mind is something like this:
> 
> config A
> 	autoselect
> 
> config B
> 	depends on A
> 
> For the visibility calculation A is set to y and A is automatically 
> selected if any symbol, which depends on A, is enabled.
>...

How do you want to handle the following?

<--  snip  -->

config FW_LOADER
      tristate "Hotplug firmware loading support"
      depends on HOTPLUG

config ATMEL
      tristate "Atmel at76c50x chipset  802.11b support"
      depends on NET_RADIO && EXPERIMENTAL
      select FW_LOADER
      select CRC32

<--  snip  -->


We've been biten that often by cases like a "select I2C_ALGOBIT" without 
a dependency on or a select of I2C and such cases are real issues that 
need a proper handling.


> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

