Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275202AbTHAIfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 04:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275203AbTHAIfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 04:35:42 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38551
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S275202AbTHAIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 04:35:31 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Messing with Kconfig.
Date: Fri, 1 Aug 2003 04:37:54 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308010335.07396.rob@landley.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm looking at menuconfig and contemplating rearranging the heck out of it 
to slather some calamine lotion on one of my longstanding personal itches.  
(You may have seen a couple trivial patches float by.)   I thought it would 
be polite to ask about a couple of things before trying anything major:

1) There are no actual options at the top level, and I'm wondering if that's 
policy or coincidence.  For example, CONFIG_EXPERIMENTAL lives by itself in a 
wrapper menu that's pretty darn specifically tailored to it, and is unlikely 
to grow too many more options.  Would taking it out of the wrapper menu be a 
bad thing?

2) There's at least two different menu types.  The standard top-level menus 
are just "descend into this" (the "menu" type), often with a guard item at 
the top of the menu you descend into that deactivates and hides everything in 
it.  But a couple (like CONFIG_EMBEDDED, under general setup) are type 
"menuconfig", where you have to select the menu in order to be able to 
descend into it.  These two are basically functionally equivalent,but provide 
have two different user interface styles.  Which is preferred?  (The 
menuconfig type is more straightforward and more compact, but also slightly 
easier to miss the need to descend into something and configure stuff.  Is 
there some kind of subtle policy here, using one to indicate a pure guard 
item with no associated functionality (which only affects the configurator 
and not generated code), and the other to indicate associated generated code 
is attached?  Or what?)

4) Some menu guards don't actually disable everything in their menu when you 
switch 'em off.  The CONFIG_INPUT is one example, CONFIG_VIDEO_DEV is 
another.

5) Is the indentation level supposed to mean something?  Look at PCI IDE 
chipset support, for example.  Disable it and the indented menu items under 
it disappear, along with a dozen or so menu items underneath it that aren't 
indented.  Am I missing a subtle policy issue here?  (It makes cases like 
"does USB Gadet support need USB Support, cause it doesn't go away when you 
disable it" harder to figure out...)

6) In test-2, if you do a make distclean (zapping your .config) and also rip
the config out  of /boot, and then do a make menuconfig, you get the
following:

boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
#
# using defaults found in arch/i386/defconfig
#
arch/i386/defconfig:68: trying to assign nonexistent symbol X86_SSE2
arch/i386/defconfig:182: trying to assign nonexistent symbol PNP_CARD
arch/i386/defconfig:324: trying to assign nonexistent symbol SCSI_EATA_DMA
arch/i386/defconfig:336: trying to assign nonexistent symbol SCSI_NCR53C7xx
arch/i386/defconfig:338: trying to assign nonexistent symbol SCSI_NCR53C8XX
arch/i386/defconfig:361: trying to assign nonexistent symbol SCSI_PCMCIA
arch/i386/defconfig:395: trying to assign nonexistent symbol FILTER
arch/i386/defconfig:544: trying to assign nonexistent symbol NET_PCMCIA_RADIO
arch/i386/defconfig:663: trying to assign nonexistent symbol INTEL_RNG
arch/i386/defconfig:664: trying to assign nonexistent symbol AMD_RNG
arch/i386/defconfig:678: trying to assign nonexistent symbol AGP3

This is a bad thing, yes?

Rob


