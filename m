Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUE2PMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUE2PMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUE2PMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:12:55 -0400
Received: from main.gmane.org ([80.91.224.249]:11449 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264212AbUE2PMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:12:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: keyboard problem with 2.6.6
Date: Sat, 29 May 2004 17:12:30 +0200
Message-ID: <MPG.1b22bf86a8dd16ca9896a4@news.gmane.org>
References: <20040525201616.GE6512@gucio> <20040528194136.GA5175@pclin040.win.tue.nl> <20040528214620.GA2352@gucio> <20040529132320.GC5175@pclin040.win.tue.nl> <20040529134614.GA6420@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-39-142.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sat, May 29, 2004 at 03:23:20PM +0200, Andries Brouwer wrote:
> 
> > >>> But showkeys -s shows 0x5b when the key in question is pressed
> > >>> (and no release event!!??)
> > 
> > 0x5b is 91 which is x86_keycodes[101].
> > 
> > Yes, so all is clear:
> > The 2.6 kernel no longer has a raw mode - it has a simulated raw mode
> > that is not very raw. When you updated the table used for the
> > scancode->keycode translation, the table used to reconstruct what
> > might have been the original scancode was not changed accordingly.
> > Thus, showkeys -s gave a garbage answer.
> > 
> > Thanks for the report. It shows that resurrecting raw mode is even
> > more desirable than I thought at first.
> 
> What for?

One for all: X. Especially with multimedia keyboards. X has a 
very exhaustive set of keyboard definitions for the many 
multimedia keyboards. Each of them has multimedia keys in a 
very wide and diverse range of strange scancodes. They all get 
standard keysyms (XF86VolumeUp, etc).

Yes, the 'proper' solution would be to have the kernel provide 
the abstraction layer: let the kernel have standard keycodes 
for all the multimedia functions, and know, for the various 
keyboard model, which scancodes generate them. And then have X 
work on the keycodes.

But:

1. the Linux kernel does not (yet) have such an exhaustive 
mapping as the xkbd models
2. the Linux kernel does not (yet) have any knowledge at all of 
multimedia keys, for what I can see.
3. X works on non-Linux kernels and on older Linux kernels

The time to bring the new system to the same functionality 
level as the old one is not short. The time to implement a 
proper raw mode (e.g. by bleeding, see other post) would be 
much shorter.

So, while we wait for complete support, at the kernel level, 
for all the multimedia keyboards supported by X, we *need* 
proper raw mode.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

