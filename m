Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTGTF3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTGTF3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 01:29:49 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:30469 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261874AbTGTF3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 01:29:47 -0400
Subject: Radeon in LK 2.4.21pre7
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: ajoshi@kernel.crashing.org, benh@kernel.crashing.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jul 2003 01:43:11 -0400
Message-Id: <1058679793.10948.47.camel@ktkhome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, Ani, et al,

Just tried Linux kernels 2.4.21pre6 and pre7 with my Radeon 8500LEE and
have had some dreadful corruption problems related to pixel clearing
during scroll and ypan.  This is probably old news to you; so <aol>me
too</aol>.  I first noticed this in the -ac kernels, but a variant is
now in mainline -pre.

Problem #1:  When scrolling, radeonfb fails to erase the portion of the
screen at the bottom, leaving all sorts of random pixels in the bottom
line.  Further scrolling propagates these pixels upwards.
See http://enterprise.bidmc.harvard.edu/~ktk/temp/radeonfb/screen-1.jpg
(Sorry for camera-shake; hand-held in dim room...)

Problem #2:  When one VC has scrolled up some number of lines, causing
it to display somewhere in the middle of its virtual Y buffer, and you
switch consoles to one that is still displaying from some other Y-start
value, the screen tends to redraw itself in an odd location (not at the
bottom) thus leaving large portions as they were from the previous VC.
See: http://enterprise.bidmc.harvard.edu/~ktk/temp/radeonfb/screen-2.jpg

Problem #3:  Possibly a side-effect of problem #2, when switching VCs
via Alt-<F1...Fn> the new VC often fails to appear.  The cursor
disappears, but the screen remains as it was.  Hitting <Enter> to scroll
the screen has no effect.  Interestingly, pressing <Alt>-<SysRQ>-? to
get a magic-sysrq help line restores the screen to operation, and it
displays all further output normally.  This occurs perhaps 50% of the
time.

Workaround #1:  Setting vyres == yres causes the aforementioned issues
to go away.  However, it also takes accelerated scrolling with it.
# fbset -vyres 10240
# time locate xine
[lots of screen output]

real	0m0.935s
# fbset -vyres 1024
# time locate xine
[lots of screen output]

real	0m2.548s
#

Problem #4:  I think this was already reported.  But when running X,
switching to a text console (with <Ctrl>-<Alt>-<F1...Fn>) results in
complete corruption of the output.

HTH,
Kris Karas

P.S.  Hardware is an ATI brand Radeon 8500 LEE:
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon QL (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 8500
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 255, IRQ 11
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at c000 [size=256]
	Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2


