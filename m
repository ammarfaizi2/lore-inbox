Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbUKRXZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUKRXZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKRXXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:23:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:44931 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261166AbUKRXUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:20:30 -0500
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CUv66-0000HA-00@penngrove.fdns.net>
References: <E1CUv66-0000HA-00@penngrove.fdns.net>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 10:17:02 +1100
Message-Id: <1100819822.25520.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The PowerMac 8500/G3 does not come up at all.  Upgrading to 2.6.10-rc2-bk1
> fixed a couple of minor PPC problems, but it's still failing.  I can't see
> what's going on because it appears that the video parameters don't match
> the framebuffer geometry and almost everything is black with a few thin 
> diagonal lines of dots and dashes (which don't look like morse code...).  
> I have not mananged to get serial console to work on this machine, so i'm
> rather clueless.  So all i can offer is the .config for it (see below).  
> I tried to regress this problem and it seems to have appeared somewhere 
> between 2.6.8 and 2.6.9-rc1.
> 
> It does seem to be specific to CONFIG_FB_CONTROL, as if CONFIG_FB_OF is set
> instead, the PowerMac will boot OK, but all that will appear on the screen
> until 'xdm' is started is a cute penguin.  The nearly-blank screen with 
> CONFIG_FB_OF only set goes back at least until 2.6.3, after which i lost
> patience chasing the problem down.

You lack CONFIG_FRAMEBUFFER_CONSOLE maybe ? You should use the
pmac_defconfig ... Now, if controlfb still doesn't work, then I'll have
to dig out my old 8500, it's possible that the recent changes to the
fbdev layer broke some of those old drivers.

As for serial, check out CONFIG_SERIAL_PMACZILOG and
CONFIG_SERIAL_PMACZILOG_CONSOLE.

> In addition, to that on the PowerMac, when things are running normally
> (under 2.6.8 for example), switching to a virtual console from X windows 
> causes the vertical refresh rate to be set to about 47Hz, i.e. the screen
> loses sync.  It can be fixed (until X windows is visited again) using 'ssh' 
> from another machine and doing a 'fbset' with the correct vertical sync
> rate.  That problem has been with me for quite awhile.

Yes, that is due to the 2.6 changes in fbdev/fbcon, the loss of the per
VT mode data structure, the driver is now sort-of supposed to re-invent
a mode based on bogus stuff sent by fbcon on console switch. I don't
like it much, but I suppose I'll have to fix controlfb (and platinumfb
etc...).


