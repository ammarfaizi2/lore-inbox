Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbTGHXN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267902AbTGHXN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:13:26 -0400
Received: from mailb.telia.com ([194.22.194.6]:46551 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S267893AbTGHXNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:13:16 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Carl Thompson <cet@carlthompson.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Problems with touchpad on 2.5
References: <1057692706.540499d16346c@carlthompson.net>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Jul 2003 01:25:23 +0200
In-Reply-To: <1057692706.540499d16346c@carlthompson.net>
Message-ID: <m2znjoppng.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl Thompson <cet@carlthompson.net> writes:

> My laptop (emachines M5305 Widescreen) has a Synaptics touchpad with a
> scroll area.  This scroll area serves the same purpose as mouse wheel on a
> normal ps2 mouse.  The touchpad uses a ps2 interface.
> 
> Under 2.4, everything works fine.  With X I just configure it to use
> /dev/psaux with the IMPS/2 protocol.  The touchpad and the scroll area work
> correctly.
> 
> Under 2.5, there are two problems.  The first problem is that the touchpad
> won't work at all with normal settings.  However, if I start the kernel
> with "psmouse_noext" the touchpad works.  I believe that the kernel should
> not require any options to use this very common touchpad.
> 
> The second problem is that once I get the touchpad working with the boot
> option above, the scroll area still will not work.  I have tried the same
> setup (X cofigured to point to /dev/psaux and using protocol IMPS/2).  I
> have also tried using /dev/input/mouse0 and /dev/input/mice.  I have tried
> the XFree86 Synaptics driver instead of the X built in "mouse" driver but
> that does not work at all under 2.5 (works under 2.4).

You need an updated driver with 2.5 support:

        http://w1.894.telia.com/~u89404340/touchpad/index.html

(There is no GPM support yet unfortunately.) Boot without the
psmouse_noext option. Use something like this in your XF86Config file.

        Section "InputDevice"
                Identifier      "TouchPad"
                Driver  "synaptics"
                Option  "Device"        "/dev/input/event3"
                Option  "Protocol"      "event"
                Option  "MinSpeed"      "0.08"
                Option  "MaxSpeed"      "0.10"
                Option  "AccelFactor"   "0.0010"
                Option  "SHMConfig"     "on"
        EndSection

Note that you need to replace the "3" with the correct number for your
hardware setup.

Vojtech. Is it possible to figure out automatically from user space
which eventX device is connected to the touchpad? It's not very user
friendly to have to figure out this number manually, and it's quite
annoying that you get a different number if a USB mouse is connected
to the computer.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
