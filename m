Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUADJki (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUADJkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:40:37 -0500
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:50591 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261744AbUADJkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:40:33 -0500
Date: Sun, 4 Jan 2004 10:40:31 +0100 (CET)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Claas Langbehn <claas@rootdir.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <20040104005246.GA2153@rootdir.de>
Message-ID: <Pine.LNX.4.44.0401041026110.28807-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Claas Langbehn wrote:

> > The best thing you can try is to connect a CRT. Its a handy tool (it
> > eats any video mode, including wrong ones) to check if the driver does
> > something wrong. Use it to inspect geometry and the horizontal & vertical
> > refresh rates. The CRT should dislay 1024x768 60 Hz in all resolutions
> > (unless you switch off the LCD display).
> >
> > Compile Atyfb as module. Use fbset to switch video modes blindly. Check
> > the following modes: 640x400, 640x480, 1024x768.

> Okay, the external monitor was a good idea.
> I can boot with the external monitor and atyfb.

2.4.23?

> when I do fbset 1024x768-60, then the screen gets distorted, then I hit
> Fn + F5 (Monitor selection) several times, and finally I get a working
> picture.

Ah you have a working fn-f5? good! fn-f5 will fix your display in most
cases, however, my experience is also that it can mess things up. If you
can get in 1024x768 without fn-f5 please try so, to make sure the chip is
in a clean state.

Remember to do all tests with both displays enabled. When you are in
1024x768 60 Hz, the hardware stretcher is disabled. Test if horizontal
stretching works:

fbset -xres 640

You can do this because the video timings are locked to
1024x768-60, and your refresh rate does not get a boost like with a
normal vga monitor. Because we only use 1 Crt controller, your external
monitor is locked too.

You should now have a 640x768 mode. Watch the image on the Crt display. It
should be rock stable during the mode switch the Crt should not be
detecting any mode change and the picture should not change position.

Switch back to 1024x768:

fbset -xres 1024

Now try the vertical streching:

fbset -yres 480

Check again very close what happens on your crt. It is my expectation that
one of these tests fails and the other will wok correctly.

> So tell me how we can do register debuggig.

I'll send you my register dump programs so you can compare the setting of
the Crt controller with fo example X video modes.

Daniël

