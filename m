Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTJ0Txg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTJ0Txg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:53:36 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:31670 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263478AbTJ0Txd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:53:33 -0500
Message-ID: <3F9D77D5.4010306@blue-labs.org>
Date: Mon, 27 Oct 2003 14:53:57 -0500
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test9 suspend problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# echo -n mem > /sys/power/state

PM: Preparing system for suspend
Stopping tasks: ======================================================|
hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
drivers/usb/host/uhci-hcd.c: bf80: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dcf667f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dcf667f8)
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue df5b4bf8, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
hdb: completing PM request, resume
drivers/acpi/osl.c:734: spin_lock(drivers/acpi/osl.c:dffe0cb0) already 
locked by                     drivers/acpi/osl.c/734
drivers/acpi/osl.c:753: spin_unlock(drivers/acpi/osl.c:dffe0cb0) not locked
Restarting tasks... done
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
eth1: New link status: Connected (0001)
PM: Preparing system for suspend
Stopping tasks: ======================================================
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, artsd not stopped
 done
PM: Preparing system for suspend
Stopping tasks: ======================================================
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, artsd not stopped
 done


On resume, I need to a) close the lid and open it, b) run setfont to 
clear the garbage off the screen and make the text readable, and c) run 
kbdrate to reset the keyboard rate.

Problems: USB doesn't work after resuming. After plugging in a USB 
mouse, all I get is:

drivers/usb/host/uhci-hcd.c: bf80: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad

Also, artsd and suspend just don't cooperate well.

artsd         D C255DAFC     0  2227   2080          2233       (NOTLB)
d8465ea8 00200082 df8d5960 c255dafc 0000000c df314df8 00000001 d849e960
       d8465ebc d035c960 c255dafc 0000000c df8d5960 0000014f c2566a95 
0000000c
       d849e960 df3aae24 00200286 d8464000 df3aae2c c0108155 df314df8 
0000000e
Call Trace:
 [<c0108155>] __down+0x133/0x32c
 [<c03ca818>] snd_pcm_action_single+0x5f/0x61
 [<c01259bd>] default_wake_function+0x0/0x2e
 [<c03d0605>] snd_pcm_playback_ioctl+0x0/0x33
 [<c0108830>] __down_failed+0x8/0xc
 [<c03d1548>] .text.lock.pcm_native+0x2d/0xc9
 [<c03cfc05>] snd_pcm_playback_ioctl1+0x52/0x610
 [<c01128f9>] timer_interrupt+0x2c6/0x3b6
 [<c03d0605>] snd_pcm_playback_ioctl+0x0/0x33
 [<c0195013>] sys_ioctl+0x214/0x405
 [<c0130b0d>] sys_gettimeofday+0x67/0xd0
 [<c010a07b>] syscall_call+0x7/0xb



