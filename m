Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTABTmC>; Thu, 2 Jan 2003 14:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbTABTmC>; Thu, 2 Jan 2003 14:42:02 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:9411 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266356AbTABTmB>; Thu, 2 Jan 2003 14:42:01 -0500
Date: Thu, 2 Jan 2003 20:50:24 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] top-level config menu dependencies
Message-ID: <20030102195024.GC17053@louise.pinerecords.com>
References: <20030101162519.GF15200@louise.pinerecords.com> <3E143F74.434AD08B@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E143F74.434AD08B@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [zippel@linux-m68k.org]
> 
> > While converting the way submenus appear in menuconfig depending on
> > their main, parent config option, I stumbled upon certain subsystems
> > (such as MTD or IrDA) that should clearly have an on/off switch directly
> > in the main menu so that one doesn't have to enter the corresponding
> > submenus to even see if they're enabled or disabled.
> > 
> > Since the new kernel configurator would have no problems with such
> > a setup, I'm posting this RFC to get the general opinion on whether
> > this should be carried on with.  I'm willing to create and send in
> > the patches.
> 
> While all config programs should be able to handle this, it might look a
> bit strange. Especially the split view of xconfig relies a bit on the
> current organisation of the config data.
> My idea to handle this would be to turn e.g.:
> 
> menu "Memory Technology Devices (MTD)"
> 
> config MTD
> 	tristate "Memory Technology Device (MTD) support"
> 
> into something like this:
> 
> menuconfig MTD
> 	tristate "Memory Technology Device (MTD) support"
> 
> This would give the front ends the most flexibility. The required
> changes are quite small, so it should be doable for 2.6. I'm not
> completely sure about the syntax yet, but above is the most likely
> version.

If I understand you correctly, what you are proposing is equivalent
to how the following currently works:

config MTD
	tristate "Memory Technology Device (MTD) support"

menu "Memory Technology Device (MTD) support"
	depends on MTD

...

endmenu

It seems to me the infrastructure you've provided by kconfig
is completely sufficient -- it's the config frontends that would
require minor updates (xconfig mainly, menuconfig seems to be
working nicely -- at least with the setup I outlined above).

-- 
Tomas Szepe <szepe@pinerecords.com>
