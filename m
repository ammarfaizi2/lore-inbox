Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTJ0Wf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTJ0Wf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:35:27 -0500
Received: from palrel12.hp.com ([156.153.255.237]:41400 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263632AbTJ0WfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:35:14 -0500
Date: Mon, 27 Oct 2003 14:35:09 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
To: vojtech@suse.cz
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: serious 2.6 bug in USB subsystem?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One-line summary: plug-in your USB keyboard, see your machine die.

So, I have this non-name USB keyboard (with built-in 2-port USB hub)
which reliably crashes 2.6.0-test{8,9} on both x86 and ia64.  In
retrospect, it's clear to me that the same keyboard also occasionally
crashes 2.4 kernels, but there the problem appears more seldom.
Perhaps once in 10 reboots and once the machine is booted and the
keyboard is running, it keeps on working.  The keyboard in question is
a BTC 5141H.

I'm wondering if anybody out there has the same keyboard and could see
if the same problem exists with all 5141H keyboards.

In any case, even if the keyboard happened to be completely broken, I
don't think it should be possible to crash the kernel merely by
connecting a (potentially) bad USB device, so, regardless, there seems
to be something off in the 2.6 USB subsystem.

Here is a more detailed description of how to reproduce the problem
and the behavior that I'm seeing with 2.6 (I don't think the exact
kernel version matters much; it definitely happens both with
2.6.0-test8 and 2.6.0-test9):

 1) disconnect the 5141H keyboard
 2) power on the machine
 3) boot into Linux 2.6
 4) connect the keyboard
 5) see the normal "USB HID" keyboard connection message
 6) wait a few seconds
 7) machine is dead

On x86, I see this message prior to the death of the machine:

 drivers/usb/input/hid-core.c: ctrl urb status -104 received
 drivers/usb/input/hid-core.c: timeout initializing reports

On ia64, the keyboards triggers an MCA apparently because the USB
controller ends up trying to read from physical address 0xf0000000,
which is a write-only area for the box in question.

I don't have a lot of experience with debugging the USB stack, but if
there is something in particular you want me to try, let me know.

Thanks,

	--david
