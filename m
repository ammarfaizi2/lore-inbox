Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbTGCWEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTGCWE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:04:29 -0400
Received: from mailf.telia.com ([194.22.194.25]:26828 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S265464AbTGCWES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:04:18 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Mike Keehan <mike_keehan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics driver on HP6100 and 2.5.73
References: <20030626220016.27332.qmail@web12304.mail.yahoo.com>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Jul 2003 00:15:45 +0200
In-Reply-To: <20030626220016.27332.qmail@web12304.mail.yahoo.com>
Message-ID: <m2brwb9rzi.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Keehan <mike_keehan@yahoo.com> writes:

> The touchpad is recognised OK when the kernel boots,
> and my usb
> connected mouse works fine.  But I get the following
> message in
> the syslog when I try to use the mousepad or any of
> the buttons :-
> 
>     ... kernel: Synaptics driver lost sync at 1st byte
> 
> It worked alright in previous kernels before the
> Synaptic driver was
> added.
> 
> Relevant /var/log/dmesg content:-
> 
>  drivers/usb/core/usb.c: registered new driver hid
>  drivers/usb/input/hid-core.c: v2.0:USB HID core
> driver
>  mice: PS/2 mouse device common for all mice
>  synaptics reset failed
>  synaptics reset failed
>  synaptics reset failed

The logs from your other mail show that the touchpad is still in
relative mode (using 3 byte packets) instead of absolute mode (using 6
byte packets.) I don't know why this happens, but here are some things
to investigate:

* Does the touchpad work with the synaptics XFree driver and a 2.4
  kernel?
* Does the Synaptics aware GPM version work?
  (:pserver:cvs@ar.linux.it:/data/cvs)
* Can you add some printks to the synaptics_reset() function to see
  why it fails?
* Maybe it helps to remove the call to synaptics_reset() in
  query_hardware(). (I know this helped one user that used the user
  space XFree driver with a 2.4 kernel.)

>  (**) Option "Device" "/dev/input/mouse1"
>  (EE) xf86OpenSerial: Cannot open device
> /dev/input/mouse1
>          No such device.
>  Synaptics driver unable to open device
>  (EE) PreInit failed for input device "Mouse1"
>  (II) UnloadModule: "synaptics"
> 
> Other device names I tries were /dev/input/mice,
> /dev/event/event0
> and /dev/psaux, but none of them work.

You should use /dev/input/eventX, where X is a number that depends on
your hardware configuration. My config looks like this:

Section "InputDevice"
        Identifier      "TouchPad"
        Driver  "synaptics"
        Option  "Device"        "/dev/input/event2"
        Option  "Protocol"      "event"
        Option  "LeftEdge"      "1800"
        Option  "RightEdge"     "5400"
        Option  "TopEdge"       "4200"
        Option  "BottomEdge"    "1500"
        Option  "FingerLow"     "25"
        Option  "FingerHigh"    "30"
        Option  "MaxTapTime"    "180"
        Option  "MaxTapMove"    "220"
        Option  "VertScrollDelta"       "100"
        Option  "HorizScrollDelta"      "100"
        Option  "EdgeMotionSpeed"       "40"
        Option  "MinSpeed"      "0.08"
        Option  "MaxSpeed"      "0.10"
        Option  "AccelFactor"   "0.0010"
        Option  "SHMConfig"     "on"
        Option  "EmulateMidButtonTime" "75"
#       Option  "UpDownScrolling" "off"
EndSection

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
