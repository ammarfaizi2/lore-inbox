Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUEID4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUEID4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 23:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUEIDz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 23:55:56 -0400
Received: from duke.cs.duke.edu ([152.3.140.1]:46796 "EHLO duke.cs.duke.edu")
	by vger.kernel.org with ESMTP id S264268AbUEIDzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 23:55:42 -0400
Date: Sat, 8 May 2004 23:55:39 -0400 (EDT)
From: Patrick Reynolds <reynolds@cs.duke.edu>
To: linux-kernel@vger.kernel.org
Subject: Synaptics touchpad jumpy under 2.6.2+
Message-ID: <Pine.GSO.4.58.0405082305520.17603@shekel.cs.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Synaptics touchpad on my Asus M5N laptop is jumpy (sampling ~3 times
per second or less) under Linux 2.6.2, but it works fine under 2.6.1.  I
have also tried 2.6.5, and the problem persists.  In all cases, the
kernels are straight from kernel.org with no extra patches.

The kernel identifies my touchpad like so:

   Synaptics Touchpad, model: 1
    Firmware: 5.9
    Sensor: 17
    new absolute packet format
    Touchpad has extended capability bits
    -> multifinger detection
    -> palm detection
   input: SynPS/2 Synaptics TouchPad on isa0060/serio1

The problem shows up in both gpm (1.19.6) and XFree86 (4.3.0.1 with the
Synaptics driver 0.13.0).  It even shows up if I 'cat /dev/input/event0',
which produces 3-4 events per second under 2.6.2 and 75-80 events per
second under 2.6.1.

The touchpad problems seem to "spill over" to the keyboard.  When I touch
the touchpad at all, the keyboard becomes unresponsive for a second or
two.  If I don't use the touchpad, the keyboard is fine.

The keyboard and touchpad are both built in, i8042 devices.

I tried adding 'i8042.nomux' to the kernel command line.  It didn't make a
difference for me.

I #define'd DEBUG in i8042.c.  Here's the resulting dmesg:
  http://www.cs.duke.edu/~reynolds/dmesg.txt

Does anyone have any suggestions?  Any idea what changed in 2.6.2 that
disagrees with my touchpad?

--Patrick
