Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268066AbRG3VQR>; Mon, 30 Jul 2001 17:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbRG3VQI>; Mon, 30 Jul 2001 17:16:08 -0400
Received: from 209-221-203-158.dsl.qnet.com ([209.221.203.158]:42500 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S268025AbRG3VPy>; Mon, 30 Jul 2001 17:15:54 -0400
Message-ID: <3B65CE7D.859A37F9@rinspin.com>
Date: Mon, 30 Jul 2001 14:15:41 -0700
From: Scott Bronson <bronson@rinspin.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Conflict between v4l and adi module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I tracked this conflict down a few days ago.  It's 100%
reproducible.  Does anyone have any insight, or any ideas
of what I should look at now?

Immediately after booting, if I fire up my BT848-based TV
tuner, quit, then try to open /dev/js0, this happens:

  [vesper] ~/joystick$ ./jstest /dev/js0
  jstest: No such device

If I don't use v4l before trying to open the joystick, everything
just works as it should.  This failure also happens if I grab
frames from my ov511-based webcam or my QuickCam Express instead
of watching TV.  That's why I think it's v4l that's the culprit.

After jstest reports the missing /dev/js0, if I rmmod adi and
modprobe it again, the joystick starts working again.  And it
continues to work from then on, no matter what I do (watch TV,
capture frames, run, quit, etc).

To summarize, the failure (/dev/js0: No such device) only happens
if I use v4l before opening /dev/js0 after booting the computer.
Once /dev/js0 is successfully opened, it always works from then on. 
rmmoding and insmoding adi always resolves the conflict.  Rebooting
and then using v4l before opening the joystick always causes it.

One last data point, probably not terribly valuable: if I leave
xawtv and the v4l driver open while I rmmod and insmod adi, then
nothing changes. jstest still reports No such device.  To get
things working, I need to close xawtv and THEN reload adi.

Linux kernel 2.4.7, X 4.0.3, on a 700 MHz AMD Athlon system.
The joystick is plugged in to a Hoontech 4DWave sound card
with Alsa drivers.  All modules are being loaded at boot by
/etc/modules:

   tulip
   bttv

   # joystick...
   joydev
   pcigame
   analog
   adi

Nothing is in the logs.

Any ideas?  Uninitialized variable maybe?  I'm happy to go
digging through the source, but I'm hoping somebody could
give me some hints to narrow down what I have to look through.
Thanks,

	- Scott
