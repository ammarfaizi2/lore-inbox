Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTDOTJz (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTDOTJz 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:09:55 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:35590 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263023AbTDOTJx (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 15:09:53 -0400
Date: Tue, 15 Apr 2003 20:21:43 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [FBDEV BK] Updates and fixes.
In-Reply-To: <20030414005814.6719915f.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304152004350.8236-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are a lot of compilation warnings. 
> 
> drivers/char/agp/agp.h:50: warning: `global_cache_flush' defined but not used

Not related.

> drivers/video/aty/mach64_gx.c:194: warning: initialization from incompatible pointer type

Haven't applied a few driver patches yet because I have been working on 
the upper layer stuff.

> drivers/video/console/fbcon.c: In function `fbcon_startup':
> drivers/video/console/fbcon.c:530: warning: unused variable `irqres'
> drivers/video/console/fbcon.c: At top level:
> drivers/video/console/fbcon.c:206: warning: `fb_vbl_handler' defined but not used

Which brings up the point. The driver specific code for handing the 
flashing (acorn, atarti, and mac generic) driver shoudl move that code to 
there respected driver. 

> drivers/video/riva/fbdev.c: In function `rivafb_cursor':

Cleaned up.

> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_MDA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> 
> Disabling CONFIG_MDA_CONSOLE prevents that from happening.

That is strange. I think it might have to do with the font height issue 
someone reported just recently. Before thee was a global variable 
video_font_height. This caused issues with framebuffer consoles since 
different VCs can have different font heights. Now it is private to each 
driver. This is probable related. I will test. I have a few more updates 
to vgacon coming later one.

> This machine has:
> 
> ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)

The patch applied is the latest work from Monta Vista to get that chipset 
working on non ix86 platforms. As usual any changes to the Mach 64 driver 
affects a bunch of other machines. 

> VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX440] (rev a3)
> 
> When fbcon is enabled here the screen is full of random uninitialised gunk
> and no text is readable.

Well you are using bleeding edge code here.  

> Another machine has Cirrus hardware.  The Cirrus drivers do not compile.

Haven't ported it over to the new api yet. I have been fixing the upper 
layer lately. As soon as I'm done I plan to do extensive house cleaning. 
Alot of the drivers where ported over as fast as possible and as such 
suffered.

> A fourth machine has:
> 
> 	nVidia Corporation NV11 [GeForce2 MX] (rev b2)
> 
> this seems to work OK.  The penguins initially have a white background, then
> the background goes black, then they go away.  Perhaps that is intentional. 
> But it gets to a readable login prompt.

That is the stable code. As for the white background that is strange.

> A fifth machine has:
> 
> 	ATI Technologies Inc Radeon VE QY
> 
> it seems to work OK as well.  The penguins started out on a black background.
> I didn't test dual-head mode.

Great. I don't think the driver supports dual head mode yet.


