Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTDNHqo (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 03:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTDNHqo (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 03:46:44 -0400
Received: from [12.47.58.203] ([12.47.58.203]:65121 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262811AbTDNHqm (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 03:46:42 -0400
Date: Mon, 14 Apr 2003 00:58:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [FBDEV BK] Updates and fixes.
Message-Id: <20030414005814.6719915f.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 07:58:23.0712 (UTC) FILETIME=[9F765E00:01C3025B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> 
> As usually I have a standard diff at 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 

There are a lot of compilation warnings.


drivers/char/agp/agp.h:50: warning: `global_cache_flush' defined but not used
drivers/char/agp/agp.h:50: warning: `global_cache_flush' defined but not used
drivers/char/agp/agp.h:50: warning: `global_cache_flush' defined but not used
drivers/video/aty/mach64_gx.c:194: warning: initialization from incompatible pointer type
drivers/video/aty/mach64_gx.c:486: warning: initialization from incompatible pointer type
drivers/video/aty/mach64_gx.c:602: warning: initialization from incompatible pointer type
drivers/video/aty/mach64_gx.c:726: warning: initialization from incompatible pointer type
drivers/video/aty/mach64_gx.c:873: warning: initialization from incompatible pointer type
drivers/video/console/fbcon.c: In function `fbcon_startup':
drivers/video/console/fbcon.c:530: warning: unused variable `irqres'
drivers/video/console/fbcon.c: At top level:
drivers/video/console/fbcon.c:206: warning: `fb_vbl_handler' defined but not used
drivers/video/riva/fbdev.c: In function `rivafb_cursor':
drivers/video/riva/fbdev.c:1472: warning: unused variable `s_idx'
drivers/video/riva/fbdev.c:1472: warning: unused variable `d_idx'
drivers/video/riva/fbdev.c:1472: warning: unused variable `j'



I tried your patch on a bunch of machines.

IBM A21P laptop:

Since 2.5.54, this machine has had a problem with the VGA console.  No fb
stuff configured at all.  During boot, as soon as the kernel output hits the
bottom of the screen (the point where it would first scroll), no more output
comes out, ever.  The machine boots up OK though.

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

Disabling CONFIG_MDA_CONSOLE prevents that from happening.

When I enable framebuffer with your latest patch on this machine the display
screws up - it alternates between blackness and a strange flicker of
horizontal and vertical grey lines.  No text is visible.

This machine has:

ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)





A second desktop machine has:

VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX440] (rev a3)

When fbcon is enabled here the screen is full of random uninitialised gunk
and no text is readable.





Another machine has Cirrus hardware.  The Cirrus drivers do not compile.





A fourth machine has:

	nVidia Corporation NV11 [GeForce2 MX] (rev b2)

this seems to work OK.  The penguins initially have a white background, then
the background goes black, then they go away.  Perhaps that is intentional. 
But it gets to a readable login prompt.



A fifth machine has:

	ATI Technologies Inc Radeon VE QY

it seems to work OK as well.  The penguins started out on a black background.
I didn't test dual-head mode.


