Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbUDBRtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUDBRtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:49:40 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:26263 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264137AbUDBRtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:49:33 -0500
Subject: regression: oops with usb bcm203x bluetooth dongle 2.6.5-rc3-ben0
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080927872.1721.8.camel@localhost>
Mime-Version: 1.0
Date: Fri, 02 Apr 2004 19:44:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This dongle used to work fine (at least till 2.6.3).
While this kernel version does not have the same issues that rc2 had
with usb (not recognizing devices again once they are
removed/reinserted), this dongle gives me an oops on _insert_.
Mass storage devices seem to work fine.

This is on a ppc machine with xmon support compiled in. So if you need
more infos than this backtrace, please say so.

Soeren.

usb 2-1: new full speed USB device using address 2 
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
drivers/usb/core/usb.c: registered new driver bcm203x
usb 2-1: USB disconnect, address 2
usb 2-1: new full speed USB device using address 3 
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C026192C LR: C0261BD0 SP: EFEB9D00 REGS: efeb9c50 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 40000000
TASK = c1aee000[5] 'khubd' Last syscall: -1 
GPR00: C0261BD0 EFEB9D00 C1AEE000 EF978D48 C137D448 00000000 EFD71A0C C04622C4 
GPR08: 00009032 00000017 00010C00 C04F9958 82008022 
Call trace:
[c0261bd0] usb_set_interface+0x94/0x164
[f2443ab4] hci_usb_probe+0x21c/0x48c [hci_usb]
[c025b360] usb_probe_interface+0x80/0x98
[c01f6f6c] bus_match+0x50/0x8c
[c01f7000] device_attach+0x58/0xbc
[c01f7280] bus_add_device+0x7c/0xd8
[c01f5b20] device_add+0xb0/0x184
[c0261fbc] usb_set_configuration+0x20c/0x25c
[c025c69c] usb_new_device+0x2bc/0x3d4
[c025e0fc] hub_port_connect_change+0x1a0/0x298
[c025e4c8] hub_events+0x2d4/0x354
[c025e584] hub_thread+0x3c/0xf4
[c000930c] kernel_thread+0x44/0x60

