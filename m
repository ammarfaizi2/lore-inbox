Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUD2GFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUD2GFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUD2GFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:05:32 -0400
Received: from [194.95.168.2] ([194.95.168.2]:56784 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263419AbUD2GFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:05:25 -0400
Subject: 2.6.6-rc3 still oops on unplugging usb bluetooth bcm203x dongle
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1083218706.3942.5.camel@localhost>
Mime-Version: 1.0
Date: Thu, 29 Apr 2004 08:05:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I still get:

usb 2-1: USB disconnect, address 3
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C02134B4 LR: F205D414 SP: EFE87DD0 REGS: efe87d20 TRAP: 0600    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BB7, DSISR: 00000120
TASK = effa4030[5] 'khubd' THREAD: efe86000Last syscall: -1 
GPR00: FFFF0001 EFE87DD0 EFFA4030 EE77C828 6B6B6B6B 00000000 EB8EE83C 00000000 
GPR08: 00001388 EF0EE858 00010C00 C0213480 82008022 00000000 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 00000000 
GPR24: 00000000 C0400000 00000001 6B6B6B6B 6B6B6BB7 EF07B8A0 EE77C828 EE77C6FC 
NIP [c02134b4] class_device_del+0x34/0x140
LR [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
Call trace:
 [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
 [f205876c] hci_unregister_dev+0x18/0xb0 [bluetooth]
 [f204cd94] hci_usb_disconnect+0x48/0x90 [hci_usb]
 [c0277a24] usb_unbind_interface+0x88/0x8c
 [c02125a4] device_release_driver+0x84/0x88
 [c0212744] bus_remove_device+0x74/0xd0
 [c0211120] device_del+0xa8/0x114
 [c02111a4] device_unregister+0x18/0x30
 [c027e248] usb_disable_device+0x9c/0xd8
 [c0278768] usb_disconnect+0x9c/0x134
 [c027ab14] hub_port_connect_change+0x294/0x298
 [c027adec] hub_events+0x2d4/0x354
 [c027aea8] hub_thread+0x3c/0xf0
 [c00090b0] kernel_thread+0x44/0x60

Sometimes it helps to hciconfig hci0 down the bluetooth dongle + stop
all programs + rmmod them... However also the
rmmod hci_usb rfcomm bluetooth firmware_class bcm203x l2cap

is very likely to cause the same oops...

Yes, this is on powerpc but quite a number of people have the same issue
on x86 (with 2.6.5 at least... and thats around the time this oops on
unplugging appeared).

Any ideas ?
Soeren

