Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUCUXOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCUXOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:14:09 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:21426 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261455AbUCUXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:13:59 -0500
To: Dmitry Torokhov <dtor@mail.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Synaptics touchpad + external mouse with Linux 2.6?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 21 Mar 2004 23:52:31 +0100
Message-ID: <m33c81lsnk.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a notebook PC (an old Fujitsu-Siemens Liteline, celeron 600 etc)
with a Synaptics touchpad:

Synaptics Touchpad, model: 1
 Firmware: 4.6
 Sensor: 19
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1

This notebook has external mouse+keyboard connector. Is it possible to
have both the touchpad and the external mouse simultaneously active in
their native modes? The hardware (keyboard controller) doesn't seem to
support the active multiplexing mode (by Synaptics and others):

drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [3]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [3]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: 5b <- i8042 (return) [3]

It looks the keyboard controller just forwards all data from both
devices. I can set them (i.e. Linux and XFree86 driver) to IM PS/2 mode
and they will both work (Linux treats them as one device), but I can't
use touchpad's special features.

I was thinking about setting them to IM PS/2 mode first (both would go
IM PS/2) then switching to Synaptics mode (the mouse should ignore it).
On the receiving side, I could check if the packet is valid for IM or
Synaptics mode and pass it to the respective driver. Not sure if the
keyboard controller is fully transparent, though - it could be changing
data as outlined in the Synaptics PS2-MUX paper ("legacy hidden
multiplexing").

If I set Linux to Synaptics mode (i.e. modprobe psmouse without any
parameters), I can't use the external mouse as it produces 3-byte
packets by default (the kernel = synaptics.c prints "Synaptics driver
lost sync at byte 1").

What do you think?
-- 
Krzysztof Halasa, B*FH
