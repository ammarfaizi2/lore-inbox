Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTLUUnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 15:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTLUUng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 15:43:36 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:38533 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S264093AbTLUUne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 15:43:34 -0500
Date: Sun, 21 Dec 2003 15:43:31 -0500
From: Raul Miller <moth@magenta.com>
To: linux-kernel@vger.kernel.org
Subject: problem with usb duo mouse and keyboard
Message-ID: <20031221154331.Z28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.0 (and 2.6.0-test11) appears to have a significant problem
with the mouse of the logitech 700mx duo when it's plugged in using usb.

The mouse works fine* when plugged in using the ps/2 mouse connector,
and the keyboard works ok even when plugged in using usb.  However,
when using usb:

o   horizontal mouse movement is interpreted as vertical movement 
o   vertical mouse movement is ignored 
o   strange things happen with mouse button presses (I didn't bother
    working with this configuration long enough to figure out the
    details).

This occurs under both x and gpm, which is mild evidence that it's
not a user space problem.

It might also be worth noting that some of the extra keys on the keyboard
do odd mouse-like things (like move the mouse's pointer horizontally
a short distance) when it's a usb keyboard.  However, these keys work
reasonably normally (or, in two cases**, generate entries in syslog)
when it's plugged in as a ps/2 keyboard.

My guess is that the respective usb drivers haven't taken into account
that both a keyboard and a mouse might appear on the same physical
connection.  [But I'm still coming up to speed, and haven't yet figured
out how to confirm/disprove that guess.]

-- 
Raul Miller
moth@magenta.com


* one mouse button is ignored, however it is so awkwardly placed that I
doubt anyone would want to use it.


** the syslog entries from the unsupported keys:

Dec 21 15:28:07 localhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x11d, data 0x11, on isa0060/serio0).
Dec 21 15:28:07 localhost kernel: atkbd.c: Unknown key released (translated set
2, code 0x11d, data 0x91, on isa0060/serio0).
Dec 21 15:28:10 localhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x12c, data 0x14, on isa0060/serio0).
Dec 21 15:28:10 localhost kernel: atkbd.c: Unknown key released (translated set
2, code 0x12c, data 0x94, on isa0060/serio0).

Perhaps it's also worth noting that most of the other extra keys send two
byte sequences when pressed (as reported by showkey -s), and showkey -k
seems to be reporting the extra information as extra key releases, I think
I've seen something similar on other keyboards, but I don't have one of
those handy to test on).  If anyone cares, I can document this for them.
