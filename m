Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUBOKdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUBOKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:33:41 -0500
Received: from av9-1-sn4.m-sp.skanova.net ([81.228.10.108]:63206 "EHLO
	av9-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264450AbUBOKdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:33:39 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc3
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	<m2znbk4s8j.fsf@p4.localdomain> <1076838882.6957.48.camel@gaston>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Feb 2004 11:33:35 +0100
In-Reply-To: <1076838882.6957.48.camel@gaston>
Message-ID: <m2smhc4oow.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2004-02-15 at 20:17, Peter Osterlund wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > Benjamin Herrenschmidt:
> > >   o New radeonfb
> > >   o Fix a link conflict between radeonfb and the radeon DRI
> > >   o Fix incorrect kfree in radeonfb
> > 
> > It doesn't seem to work on my x86 laptop. The screen goes black when
> > the framebuffer is enabled early in the boot sequence. The machine
> > boots normally anyway and I can log in from the network or log in
> > blindly at the console. I can then start the X server which appears to
> > work correctly, but switching back to a console still gives me a black
> > screen. Running "setfont" doesn't fix it. Here is what dmesg reports
> > when running 2.6.3-rc3:
> 
> Did it ever work ? (I need to know if it's a regression or some problem
> that was already there in the first place). (Hrm... looking at the end
> of your mail, it indeed seem to be a regression with this version)

Yes, the old 2.6 radeon driver works, but has the transient screen
corruption problem that you fixed in 2.4 a while ago:

        http://marc.theaimsgroup.com/?l=linux-kernel&m=105827669410512&w=2

> Do you have some backlight control via the BIOS ? Can you dbl check it's
> not a problem with the backlight not beeing enabled ? (If you have
> working BIOS-driven backlight, try turning in all the way down, then
> back up).

Backlight is enabled. It is possible to change the backlight intensity
using Fn-F8 and Fn-F9, but it is not possible to completely turn off
backlight from the BIOS/keyboard. Changing the intensity works both
from within X and from the black console, but doesn't cure the
problem.

> I sounds like a problem with LVDS_GEN_CNTL register. This is very
> "touchy", the old radeonfb was wrong, but the new may not be fully right
> neither, basing myself on what XFree does, which is dodgy at least...
> 
> I didn't fully figure out the proper sequence for powering up/down the
> LCD panel on the LVDS output. (Well, the code I have now works on all
> pmac laptop panels at least...)
> 
> Also, what exact model of laptop are you using ?

It's a "Clevo 5600P" sold as a "Best 5650". More details at:

        http://w1.894.telia.com/~u89404340/best5650/laptop.html

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
