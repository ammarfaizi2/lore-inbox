Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVDEO7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVDEO7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVDEO7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:59:55 -0400
Received: from mail48-s.fg.online.no ([148.122.161.48]:32139 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261601AbVDEO7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:59:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
	<873bvyfsvs.fsf@quasar.esben-stien.name>
	<87zmxil0g8.fsf@quasar.esben-stien.name>
	<1110056942.16541.4.camel@localhost>
	<87sm37vfre.fsf@quasar.esben-stien.name>
	<87wtsjtii6.fsf@quasar.esben-stien.name>
	<20050308205210.GA3986@ucw.cz> <1112083646.12986.3.camel@localhost>
	<87psxcsq06.fsf@quasar.esben-stien.name> <87u0mn3l4e.fsf@blackdown.de>
	<87acodvrw5.fsf@quasar.esben-stien.name>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Tue, 05 Apr 2005 16:56:27 +0200
In-Reply-To: <87acodvrw5.fsf@quasar.esben-stien.name> (Esben Stien's message
 of "Tue, 05 Apr 2005 05:12:10 +0200")
Message-ID: <87br8ttgpw.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Stien <b0ef@esben-stien.name> writes:

> can't find a single problem with the device.

I should mention a couple of things after some testing: There are some
inconsistencies with regard to cruise control.

When I press TOP CLICK BACKWARD/TOP CLICK FORWARD to cruise control
down/up, it waits about 100ms before it starts cruising. This means
that pressing a single click does not move me anywhere. I have to hold
the key down and wait until it starts cruising.

When I press HORIZONTAL LEFT/HORIZONTAL RIGHT to cruise control
left/right, it starts immediately going one step in the direction,
then waits about 100ms before it starts cruising left/right
again. This means that a single click takes me one click in the
horizontal direction.

The proper way of working in both horizontal and vertical direction
should be to start immediately going one of the directions. Also, a
single click should take me a single click in the respective
direction.

I still believe this is a kernel issue and the device should be
presented to userspace as a working device.

I'm using linux-2.6.12-rc1-RT-V0.7.41-15 with evdev and
xorg-6.8.1. (As a side note, remember to not enable radeon dri with
linux-2.6.12-rc1 as xorg will freeze)

I'll summarize my new setup:

I've turned off cruise control:

logitech_applet --disable-cc

This is my ~/.xbindkeysrc file: (yup, the whole one). Executing
xbindkeys with the -v switch yields useful debug info.

# "cruise control" disabled:
"true"
  m:0x10 + b:11
"true"
  m:0x10 + b:12

The ~/.Xmodmap file:

pointer = 1 2 3 8 9 10 11 12 6 7 4 5\n

In firefox:

mousewheel.horizscroll.withnokey.action = 0
mousewheel.horizscroll.withnokey.sysnumlines = true

Here's xorg: (I'll also setup the usb settings from Jeremy Nickurak,
but they are not important here and now).

Section "InputDevice"  # Logitech MX1000
  Identifier  "Mouse0"
  Driver      "mouse"
  Option      "Protocol" "evdev"
  Option      "Dev Name" "Logitech USB Receiver" # cat /proc/bus/input/devices
  Option      "Dev Phys" "usb-0000:00:04.2-1/input0" # cat /proc/bus/input/devices
  Option      "Device" "/dev/input/event0" # (/dev/input/mice also appears to work)
  Option      "Buttons" "12"
  Option      "ZAxisMapping" "11 12 10 9"
  Option      "Emulate3Buttons" "false"
  Option      "Resolution" "800"
  Option      "SampleRate" "800"
EndSection

I'll do a mapping of how the keys correspond to key numbers in another
followup as I'm about to leave.

-- 
Esben Stien is b0ef@esben-stien.name
         http://www.
          irc://irc.                /%23contact
          [sip|iax]:
           jid:b0ef@
