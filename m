Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbTFSTcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbTFSTcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:32:02 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:30636 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265926AbTFSTbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:31:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 19 Jun 2003 21:45:44 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb console oops in 2.4.2x
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4E2D2240020@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 03 at 14:47, David Woodhouse wrote:
> On Thu, 2003-06-19 at 13:21, Petr Vandrovec wrote:

> take_over_console() attempts to redraw the screen.

It is not take_over_console... It does init first. 
> >  It is not allowed to call fbdev's putc 
> > before mode set was issued (at least I always believed to it; before
> > first mode set hardware is in VGA state)
> 
> If I omit the fixes, I just get...
> 
> matroxfb: Matrox Mystique (PCI) detected
> matroxfb: 1280x1024x8bpp (virtual: 1280x1635)
> matroxfb: framebuffer at 0x1000000, mapped to 0xc017d000, size 2097152
> matroxfb: Pixel PLL not locked after 5 secs
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  
This one is culprit. If you'll comment this message out, it will not
crash.
 
> Console: switching to colour frame buffer device 160x64
> fb0: MATROX VGA frame buffer device
> 
> If I call matrox_init_putc() earlier as you suggest, then it seems to
> end up busy-waiting in mga_fifo()...

Ok. It means that hardware is completely uninitialized when this happens.
Probably accelerator clocks are stopped (== message about pixclocks was
right...) Bad.

Does driver work with your change without problems? It looks strange
to me that PLL did not stabilized in 5 seconds. Do you get same message
when you change videomode with fbset, or happens this only once during
boot, and never again?
                                        Thanks,
                                                Petr Vandrovec

