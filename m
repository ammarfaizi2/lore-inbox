Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVK0Sxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVK0Sxv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVK0Sxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:53:51 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:47833 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1750729AbVK0Sxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:53:50 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc2-mm1: kernel BUG at kernel/timer.c:213
Date: Sun, 27 Nov 2005 19:51:55 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271951.55262.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when modprobe-ing rt2500 (http://rt2400.sf.net/) -- since the 
same driver works perfectly on older kernels, the timer rework may be at 
fault (didn't have a lot of time to look into this yet)

------------[ cut here ]------------
kernel BUG at kernel/timer.c:213!
invalid operand: 0000 [#1]
last sysfs file: /block/hda/range
Modules linked in: rt2500 intel_agp agpgart snd_intel8x0 snd_ac97_codec 
snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc psmouse 
parport_pc lp parport ipv6 i2c_dev i2c_core eepro100 mii af_packet 8250 
serial_core ide_cd cdrom uhci_hcd usbcore video thermal processor fan 
container button battery ac rtc vesafb_tng vesafb_thread
CPU:    0
EIP:    0060:[<c01237ab>]    Not tainted VLI
EFLAGS: 00210246   (2.6.15-0.rc2.1ark) 
EIP is at __mod_timer+0x7b/0x90
eax: ffff54db   ebx: c35f5994   ecx: c35f5994   edx: 00000000
esi: 00000004   edi: 00000000   ebp: c35f0260   esp: c50eadcc
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 1921, threadinfo=c50ea000 task=c46fca90)
Stack: 00000000 00000000 00000004 c35f0260 d09d55e9 c35f5994 ffff54db 00000004 
      00000000 ffffffff c0158944 cfeef120 00000020 c50eae1c 0000001 fc35f0260 
      c50eae28 d09e2d26 c35f0260 00000000 00013d12 00000012 00000000 00000012 
Call Trace:
[<d09d55e9>] AsicLockChannel+0x39/0x160 [rt2500]
[<c0158944>] cache_alloc_refill+0x434/0x480
[<d09e2d26>] NICInitializeAsic+0x166/0x210 [rt2500]
[<d09e2e59>] NICInitializeAdapter+0x89/0x90 [rt2500]
[<d09d13e3>] RT2500_open+0xd3/0x1c0 [rt2500]
[<c02878cd>] dev_open+0x7d/0x90
[<c0288c5f>] dev_change_flags+0x5f/0x140
[<c02cd83d>] devinet_ioctl+0x50d/0x63d
[<c02cebf7>] inet_ioctl+0xc7/0xe0
[<c027df17>] sock_ioctl+0x1d7/0x270
[<c016f65e>] do_ioctl+0x6e/0x80
[<c016f726>] vfs_ioctl+0xb6/0x2c0
[<c027f629>] sys_socketcall+0x89/0x260
[<c016f9b8>] sys_ioctl+0x88/0xa0
[<c0102e0f>] sysenter_past_esp+0x54/0x75
[<c012007b>] iomem_open+0xb/0x30
Code: 14 00 6a 3c c0 8b 44 24 18 89 da 89 43 08 89 f0 e8 3b fe ff ff ff 34 24 
9d 89 f8 8b 5c 24 04 8b 74 24 08 8b 7c 24 0c 83 c4 10 c3 <0f> 0b d5 00 13 ee 
2f c0 eb 97 89 ce eb cc 8d b4 26 00 00 00 00 
