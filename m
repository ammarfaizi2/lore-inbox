Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUBOJzx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUBOJzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:55:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:56733 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264434AbUBOJzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:55:50 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m2znbk4s8j.fsf@p4.localdomain>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <m2znbk4s8j.fsf@p4.localdomain>
Content-Type: text/plain
Message-Id: <1076838882.6957.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 20:54:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 20:17, Peter Osterlund wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Benjamin Herrenschmidt:
> >   o New radeonfb
> >   o Fix a link conflict between radeonfb and the radeon DRI
> >   o Fix incorrect kfree in radeonfb
> 
> It doesn't seem to work on my x86 laptop. The screen goes black when
> the framebuffer is enabled early in the boot sequence. The machine
> boots normally anyway and I can log in from the network or log in
> blindly at the console. I can then start the X server which appears to
> work correctly, but switching back to a console still gives me a black
> screen. Running "setfont" doesn't fix it. Here is what dmesg reports
> when running 2.6.3-rc3:

Did it ever work ? (I need to know if it's a regression or some problem
that was already there in the first place). (Hrm... looking at the end
of your mail, it indeed seem to be a regression with this version)

>     $ cat 263r3.dmesg | egrep -A 1 'Console:|radeon'
>     Console: colour VGA+ 80x25
>     Memory: 254460k/261632k available (2532k kernel code, 6388k reserved, 879k data, 148k init, 0k highmem)
>     --
>     radeonfb: Invalid ROM signature 0 should be 0xaa55
>     radeonfb: Retreived PLL infos from BIOS
>     radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=183.00 MHz
>     Non-DDC laptop panel detected
>     radeonfb: Monitor 1 type LCD found
>     radeonfb: Monitor 2 type no found
>     radeonfb: panel ID string: Samsung LTN150P1-L02    
>     radeonfb: detected LVDS panel size from BIOS: 1400x1050
>     radeondb: BIOS provided dividers will be used
>     radeonfb: Power Management enabled for Mobility chipsets
>     radeonfb: ATI Radeon LW  DDR SGRAM 64 MB
>     SBF: Simple Boot Flag extension found and enabled.

The above sounds sane.

Do you have some backlight control via the BIOS ? Can you dbl check it's
not a problem with the backlight not beeing enabled ? (If you have
working BIOS-driven backlight, try turning in all the way down, then
back up).

I sounds like a problem with LVDS_GEN_CNTL register. This is very
"touchy", the old radeonfb was wrong, but the new may not be fully right
neither, basing myself on what XFree does, which is dodgy at least...

I didn't fully figure out the proper sequence for powering up/down the
LCD panel on the LVDS output. (Well, the code I have now works on all
pmac laptop panels at least...)

Also, what exact model of laptop are you using ?

Ben.


