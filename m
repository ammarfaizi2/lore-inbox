Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTKGBrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 20:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKGBrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 20:47:23 -0500
Received: from web20902.mail.yahoo.com ([216.136.226.224]:25772 "HELO
	web20902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262071AbTKGBrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 20:47:21 -0500
Message-ID: <20031107014720.28888.qmail@web20902.mail.yahoo.com>
Date: Thu, 6 Nov 2003 17:47:20 -0800 (PST)
From: Brandon Stewart <rbrandonstewart@yahoo.com>
Subject: 2.6.0-test9-mm1 and mm2: Extremely slow mouse
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.0-test9, sliding my finger from the left of the touchpad to the right
takes the cursor 3/4 of the way across the screen on a 1024x768 resolution.
Doing the same on 2.6.0-test9-mm1 & 2.6.0-test9-mm2 moves the mouse only about
30 pixels, or about 1/33 of the way across the screen. It is exactly the same
system, with exactly the same configuration. The only difference is the kernel.

On 2.6.0-test9:
...
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
...
psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2
bytes away.

On 2.6.0-test9-mm2:
mice: PS/2 mouse device common for all mice
PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12

Note that I don't seem to get "lost synchronization" messages with mm1 or mm2.
Also, it might be important to note that every now and then, my cursor "goes
crazy", flying all over the screen and pressing random buttons in response to
normal user input. Releasing the touchpad for a few seconds invariably fixes
the problem. I think it is related to these messages in the log:

Nov  5 21:02:36 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 1 bytes away.
Nov  5 21:09:57 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 2 bytes away.
Nov  5 21:22:39 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 2 bytes away.
Nov  5 21:24:00 localhost kernel: spurious 8259A interrupt: IRQ7.
Nov  5 21:24:36 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 1 bytes away.
Nov  5 21:27:38 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 2 bytes away.
Nov  5 22:13:17 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 1 bytes away.
Nov  5 22:27:56 localhost kernel: psmouse.c: Mouse at isa0060/serio1/input0
lost synchronization, throwing 2 bytes away.
...

This spurious motion does NOT happen in mm1 or mm2, but it DOES still happen in
2.4.22-10mdk.

Any suggestions?

-Brandon
