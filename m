Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTGIBiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 21:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbTGIBiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 21:38:00 -0400
Received: from 12-240-128-156.client.attbi.com ([12.240.128.156]:15247 "EHLO
	carlthompson.net") by vger.kernel.org with ESMTP id S265597AbTGIBh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 21:37:58 -0400
Message-ID: <1057715544.891a8306dd477@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue,  8 Jul 2003 18:52:24 -0700
From: Carl Thompson <cet@carlthompson.net>
To: Peter Osterlund <petero2@telia.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Problems with touchpad on 2.5
References: <1057692706.540499d16346c@carlthompson.net>
	<m2znjoppng.fsf@telia.com>
In-Reply-To: <m2znjoppng.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.164
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this works for me.  I had tried the Synaptics driver also, but with
the psmouse_noext option set which didn't work.  It should be noted
somewhere (in the config help?) that the 2.4 behavior of just being able to
use the psaux device with the default X driver no longer works.

Now that this is taken care of and I have ported my 802.11a/b/g wireless
adapter's driver to use 2.5 I can try to use 2.5 full time.  I take it's
about that time when the kernel folks want non-kernel folks to start
banging on 2.5 (soon to be 2.6pre) and send the lkml problem reports,
correct?

Thank you,
Carl Thompson

Quoting Peter Osterlund <petero2@telia.com>:

> Carl Thompson <cet@carlthompson.net> writes:
>
> > My laptop (emachines M5305 Widescreen) has a Synaptics touchpad with a
> > scroll area.  This scroll area serves the same purpose as mouse wheel
> on a
> > normal ps2 mouse.  The touchpad uses a ps2 interface.
> >
> > Under 2.4, everything works fine.  With X I just configure it to use
> > /dev/psaux with the IMPS/2 protocol.  The touchpad and the scroll area
> work
> > correctly.
> >
> > Under 2.5, there are two problems.  The first problem is that the
> touchpad
> > won't work at all with normal settings.  However, if I start the kernel
> > with "psmouse_noext" the touchpad works.  I believe that the kernel
> should
> > not require any options to use this very common touchpad.
> >
> > The second problem is that once I get the touchpad working with the
> boot
> > option above, the scroll area still will not work.  I have tried the
> same
> > setup (X cofigured to point to /dev/psaux and using protocol IMPS/2).
> I
> > have also tried using /dev/input/mouse0 and /dev/input/mice.  I have
> tried
> > the XFree86 Synaptics driver instead of the X built in "mouse" driver
> but
> > that does not work at all under 2.5 (works under 2.4).
>
> You need an updated driver with 2.5 support:
>
>         http://w1.894.telia.com/~u89404340/touchpad/index.html
>
> (There is no GPM support yet unfortunately.) Boot without the
> psmouse_noext option. Use something like this in your XF86Config file.
>
>         Section "InputDevice"
>                 Identifier      "TouchPad"
>                 Driver  "synaptics"
>                 Option  "Device"        "/dev/input/event3"
>                 Option  "Protocol"      "event"
>                 Option  "MinSpeed"      "0.08"
>                 Option  "MaxSpeed"      "0.10"
>                 Option  "AccelFactor"   "0.0010"
>                 Option  "SHMConfig"     "on"
>         EndSection
>
> Note that you need to replace the "3" with the correct number for your
> hardware setup.
>
> Vojtech. Is it possible to figure out automatically from user space
> which eventX device is connected to the touchpad? It's not very user
> friendly to have to figure out this number manually, and it's quite
> annoying that you get a different number if a USB mouse is connected
> to the computer.
>
> --
> Peter Osterlund - petero2@telia.com
> http://w1.894.telia.com/~u89404340
>
>



