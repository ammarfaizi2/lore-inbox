Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUBLW3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUBLW3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:29:45 -0500
Received: from mail.inter-page.com ([12.5.23.93]:51205 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S266633AbUBLW3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:29:36 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Marko Macek'" <Marko.Macek@gmx.net>, <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ps/2 mouse problem with KVM switch
Date: Thu, 12 Feb 2004 14:29:24 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAIH4lUMJJWUqlFPWIv65Y6gEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <402602B9.1090005@gmx.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the KVM Switch (typically) implements an intermediate "device" for
the mouse so that when you are switched away to the other machine, the first
machine is still "talking to something".

This has the less-than-desireable effect of causing the mouse device "inside
the switch" to act as a largest-common-denominator.  Consequently many of
the special features and peculiarities of your real device may not be
accessible to your computer.

A particular, and bette-documented, example of this can probably be found by
trying to hook up a "new-fangled" keyboard (with the media control key
cluster across the top and such) to your windows box.  When the keyboard
drivers cannot find the special buttons and you call the KVM switch vendor
they will promptly tell you about how all those hot extra buttons are not
supported with their product, have a nice day, good-bye... 8-)

The same things go four your mouse, but are not as well documented and
accessible to the KFM help desk weasels.

You should find that if you select a "much more generic" mouse configuration
"everything works fine".

Some newer windows drivers "look past" the switch and activate the mouse
features anyway.

Regardless, if your "other" computer is initializing the mouse through
voodoo and dark magic to increase the reporting (baud?) rate and such, when
you toggle to the Linux box you will see all sorts of unhappiness.  The
inverse is also true, if the windows driver is expecting
fast-and-feature-full and the side trip to Linux has set things back to
mundane, the return to Windows will be "exciting"

Ibid for switching between two differently-abled Linux boxes, or two windows
boxes with different driver revisions and settings.

It got so bad for me in a couple of places that I have re-mastered the art
of the keyboard shortcut and don't have my mouse plugged into the KVM switch
at all, and only mouse when using my "prime" environment.  (for emergency
mousing on "the other box" I have an old mouse plugged in and set aside.)

More often than not I just hook up one box with an near-optimal
configuration and then use VNC from that box to reach out to all the others.

A/The KVM switched environment should be considered "imperfect" for almost
all other-than-stock uses.


(My optimal configuration that saves heartache)

2-Port plasma flat panel
  DVI port connected to my primary use machine
  VGA port connected to my KVM

Keyboard (no special buttions 8-) connected to KVM

Mouse connected to Primary Machine via USB

KVM keyboard ports connected to all machines

KVM mouse ports connected to all machines *EXCEPT* primary

Stand-by mouse connected to KVM

Normally I am use the directly connected mouse and monitor.

When I switch to any other machine via the KVM the VGA port comes live on
the monitor and I touch the "other input source" button on the monitor too.
As long as I am visiting the other machines I stay VGA.  When I switch back
to the primary the VGA feed goes dead and the monitor automatically switches
back to DVI.

So now It takes two button presses to switch away, but only one to home
back.

---
Less than optimal, yes, but technologically sound.  Since there is no "soft
reset" behavior provided by the PS/2 standard, let alone any way for the KVM
switch to signal the driver that such logic needs to be invoked in software,
the real truth of the issue is that this is a limitation inherent in the
design of the PS/2 interface and any solution other than
greatest-common-denominator will be unstable.

It would have been better if the PS/2 (and keyboard) interface were designed
with hot-plugability in mind and the KVM switch did nothing but detach the
devices so that a "switch to" even caused the software to rediscover the
device and reset the parameters.  The thing was that part of the core
purpose of the KVM today was designed to prevent the old "keyboard not
found, press F1 to continue booting" nonsense... Thank You Pane/Webber. 8-)

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Marko Macek
Sent: Sunday, February 08, 2004 1:35 AM
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: ps/2 mouse problem with KVM switch

Hello!

Kernel 2.6.2, XFree86 4.3.0

I am using a Logitech MouseMan 2xOptical mouse connected trough a KVM 
switch.

By default the mouse is detected as "ImExPS/2 Logitech Explorer Mouse".

The problem is that the mouse doesn't work. It is too slow and no mouse 
clicks work. If I move it very fast I sometimes get a random click event.

I specify psmouse.proto=bare mouse works OK, but not the wheel :(
(I have seen at least one "lost synchronization").

Specifying psmouse.proto=imps or exps doesn't help.

Without the KVM switch all is ok (as much as I tested under 2.6.0).

Under 2.4 mouse works perfectly, wheel and all.

I am using /dev/input/mice under XF86 (kernel does complain about X 
using direct hardware for keyboard and gives a bunch of errors).

GPM shows the same behavior if I run it (I'm not using it).

What else can I do?

Regards,
MArk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



