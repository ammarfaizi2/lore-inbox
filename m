Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSGLQL5>; Fri, 12 Jul 2002 12:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGLQL4>; Fri, 12 Jul 2002 12:11:56 -0400
Received: from unet2-78.univie.ac.at ([131.130.232.78]:3844 "EHLO
	gander.coarse.univie.ac.at") by vger.kernel.org with ESMTP
	id <S316477AbSGLQLz>; Fri, 12 Jul 2002 12:11:55 -0400
Message-ID: <3D2E628A.B368B1A3@unet.univie.ac.at>
Date: Fri, 12 Jul 2002 05:00:58 +0000
From: Piotr Sawuk <a9702387@unet.univie.ac.at>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.21 i586)
X-Accept-Language: de-AT, de, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: joystick.c
References: <3D2AB938.52461BDE@unet.univie.ac.at> <20020709183841.A10953@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Tue, Jul 09, 2002 at 10:21:44AM +0000, Piotr Sawuk wrote:
> 
> > Sorry if I'm off-topic here, since I don't read this list.
> > also when replying please send me a copy...
> >
> > in function js_correct(value,corr) I've found the instructions:
> >
> > if (value < -32767) return -32767;
> > if (value > 32767) return 32767;
> >
> > what's the use of these? I'm asking because my new usb-joystick
> > is returning those values somewhere in the middle of it's threshold
> > and I was wondering if disabling the above would do any good?
> 
> The data coming from the joystick is defined to be bound by this range.
> It's signed 16 bit anyway.

I see, I was just wondering why only 16 and not 32 bit or something.
also after noticing that the little throttle-thing at the top was
not reporting any difference between the most left value and some
1/5 to the right of it, I turned off these lines (in joydev.c),
and now on every axis jstest reports (after an overflow) that the
lowest value is 27700 and the highest value is -27363 (except of
course for the non-analogue axes). could it be possible to fix the
driver in a way to make this throttle-thing work correctly in those
extreme postitions? on the other axes it is indeed a physical limitation
which lets them get their extreme values somewhere in the middle
between center and bumping into the edge, but considering the
thin and fragile construction I would hesitate to let it bump into
the threshold anyway...
> 
> > however, the actual reason why I've looked into that file was
> > because wine reported strange joystick-events 6,7,8,9 and I
> > just can't figure out what those are supposed to do. I've found
> > JS_EVENT 1 and 2 in the linux/joystick.h include, but no mention
> > of anything related to the number '6'. does anyone know anything
> > about those joystick events?
> 
> What joystick is it? This looks like a problem with the HID driver.

It's a [Logitech Inc. WingMan RumblePad]. it has 5 "analogue"
axes (0,1 and 3,4 and 2 being the throttle) and 2 typical for a
gamepad (5,6 -- unless button 12 is switched on, in which case
the axes 5,6 are switched with the axes 0,1 and both become
non-analogue axes with my modified joydev reporting 28038 as the
minimum and -27701 as the maximum-value for the 2 gamepad-axes).
However, jstest reports 10 axes (7,8,9 always at the lowest value),
and also the buttons 9,10 and 13-19 are unused (vibration-feedback?),
it would be nice if those "unused" stuff could stop being displayed...

unfortunately I only have win95, so I can't check how it is handled
there (since even with usb-supplement there is no full hid-support).
I just would *guess* that the above-mentioned throttle-problem isn't
meant to be handled this way...

Oh, and I probably should also mention that I'm using an old usb-chip
and the usb-uhci driver from my 2.2.21 kernel...

for the mailing-list: when replying please send me a copy.

P
