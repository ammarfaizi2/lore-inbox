Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbTHAJdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 05:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbTHAJdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 05:33:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8199 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268102AbTHAJdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 05:33:40 -0400
Date: Fri, 1 Aug 2003 11:33:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Messing with Kconfig.
In-Reply-To: <200308010335.07396.rob@landley.net>
Message-ID: <Pine.LNX.4.44.0308011112230.717-100000@serv>
References: <200308010335.07396.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Aug 2003, Rob Landley wrote:

> 1) There are no actual options at the top level, and I'm wondering if that's 
> policy or coincidence.  For example, CONFIG_EXPERIMENTAL lives by itself in a 
> wrapper menu that's pretty darn specifically tailored to it, and is unlikely 
> to grow too many more options.  Would taking it out of the wrapper menu be a 
> bad thing?

Kconfig now supports config options at the top level, but changing the 
position of CONFIG_EXPERIMENTAL at this point is probably a bad idea.

> 2) There's at least two different menu types.  The standard top-level menus 
> are just "descend into this" (the "menu" type), often with a guard item at 
> the top of the menu you descend into that deactivates and hides everything in 
> it.  But a couple (like CONFIG_EMBEDDED, under general setup) are type 
> "menuconfig", where you have to select the menu in order to be able to 
> descend into it.  These two are basically functionally equivalent,but provide 
> have two different user interface styles.  Which is preferred?

menuconfig is meant for generic options, like CONFIG_IDE or CONFIG_SCSI, 
so that you can easily see whether they are enabled or not.

> 4) Some menu guards don't actually disable everything in their menu when you 
> switch 'em off.  The CONFIG_INPUT is one example, CONFIG_VIDEO_DEV is 
> another.

This should be fixed.

> 5) Is the indentation level supposed to mean something?  Look at PCI IDE 
> chipset support, for example.  Disable it and the indented menu items under 
> it disappear, along with a dozen or so menu items underneath it that aren't 
> indented.  Am I missing a subtle policy issue here?  (It makes cases like 
> "does USB Gadet support need USB Support, cause it doesn't go away when you 
> disable it" harder to figure out...)

Yes, it's supposed to help the user, how options are related. This needs 
some manual fixing. If you want to start somewhere, try to fix these 
first. It usually requires only moving an option around or adding another 
dependency. xconfig is extremly useful here, enable "show all options" and 
you can easily see which option breaks the indentation and the debug info 
tells you where to find this option.
Please don't do any major reorganization, this is not what we need right 
now.

> 6) In test-2, if you do a make distclean (zapping your .config) and also rip
> the config out  of /boot, and then do a make menuconfig, you get the
> following:

arch/i386/defconfig needs to be updated from time to time.

bye, Roman

