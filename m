Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJRWSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJRWSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:18:49 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:23681
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261879AbTJRWSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:18:48 -0400
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: re: swsusp in test8 fails with intel-agp and i830
Message-Id: <E1AAzPT-0001TY-00@penngrove.fdns.net>
Date: Sat, 18 Oct 2003 15:18:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   > I am not sure which of the two modules causes the problem, I can only load
   > them both. Unfortunately, without those modules the vaio laptop can only give
   > 640x480, so this is not much of a workaround...

   With vesafb, you should be able to get any resultion you want at
   60Hz. Which is okay, because you have LCD.

Not necessarily, at least not on a VAIO R505EL  This is due to the well-
known (to some X hackers at least) 'stolen memory' problem.  Yes, you can 
have 1024x768x8 with 'vesafb' (0x305), but if i use 'vga=ask', then i 
can't get it to accept anything of the form 0x31x (e.g., nothing more 
than 256 colors).  And netscape/mozilla grabs everything in sight, so if 
you want a color that 'netscape' doesn't use after 'netscape' has been
started, you're out of luck.

   drivers/char/drm/i830_drv driver is apparently using DMA _and_ has no
   suspend/resume support. That looks dangerous to me, perhaps you'll
   need to implement those, too.

Yeah, i looked at that driver and couldn't figure out how it was supposed
to hand suspend/resume, but didn't have anything to compare it with.  So
thank you for remark, as i was wondering if that were the case.  Basically
what i think it comes to is that whatever initialization that X does to
a display when it starts up needs to be done again after software suspend.
Given that i doubt X knows anything about software suspend, the underlying
kernel code is going to have to remember whatever X wanted and repeat that.

I did look very briefly at 'drivers/video/i810/' (i810/i815 framebuffer
driver), but no free lunch there.  Someone who knows just how the i830m
differs might have a chance at that, but that's too much work for me
to think about right now (e.g. i've got too much else to learn right
now).

So i think your workaround is to use VESA (XF86Config-4 available upon
request), probably only 256 colors, until this problem can be resolved 
with the DRM driver.
				-- JM

P.S.  Uh, do any of the DRM drivers work properly with software suspend
on other machines?
