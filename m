Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUATCb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUATC3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:29:33 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:4325 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265203AbUATAHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:07:39 -0500
Date: Mon, 19 Jan 2004 16:07:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.1-bk2] Might sleep while loading st.ko
Message-ID: <20040120000725.GY1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this in my kernel log while working with a scsi tape drive.

Is this a known sleeping function, or should I take more action to notify
the scsi or adaptec driver teams?

st: Version 20031228, fixed bufsize 32768, s/g segs 256
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [__might_sleep+157/224] __might_sleep+0x9d/0xe0
 [kmem_cache_alloc+92/96] kmem_cache_alloc+0x5c/0x60
 [cdev_alloc+23/80] cdev_alloc+0x17/0x50
 [_end+542090623/1069194756] st_probe+0x3fb/0x790 [st]
 [bus_match+47/96] bus_match+0x2f/0x60
 [driver_attach+87/144] driver_attach+0x57/0x90
 [bus_add_driver+138/160] bus_add_driver+0x8a/0xa0
 [_end+541199949/1069194756] init_st+0x49/0x94 [st]
 [sys_init_module+288/624] sys_init_module+0x120/0x270
 [sysenter_past_esp+82/121] sysenter_past_esp+0x52/0x79

Attached scsi tape st0 at scsi0, channel 0, id 2, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
st0: Block limits 2 - 16777215 bytes.
st0: Incorrect block size.

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF
02:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
02:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)

/proc/modules:
st 35608 0 - Live 0xe0949000
soundcore 7488 0 - Live 0xe08d6000
r128 91948 28 - Live 0xe0972000
hid 61888 0 - Live 0xe08fa000
usbmouse 4352 0 - Live 0xe0854000
nfs 94124 3 - Live 0xe095a000
lockd 58992 2 nfs, Live 0xe090d000
sunrpc 122312 10 nfs,lockd, Live 0xe091e000
uhci_hcd 31120 0 - Live 0xe08cd000
ohci_hcd 17408 0 - Live 0xe086f000
ehci_hcd 22148 0 - Live 0xe0877000
usbcore 98524 7 hid,usbmouse,uhci_hcd,ohci_hcd,ehci_hcd, Live 0xe08e0000
evdev 8192 0 - Live 0xe080c000
parport_pc 31788 1 - Live 0xe08b9000
lp 9376 0 - Live 0xe086b000
parport 36712 2 parport_pc,lp, Live 0xe08af000
floppy 56052 0 - Live 0xe087f000
i2c_isa 2048 0 - Live 0xe084f000
i2c_core 21256 1 i2c_isa, Live 0xe0857000
tulip 45216 0 - Live 0xe085e000
crc32 4224 1 tulip, Live 0xe080f000
rtc 11976 0 - Live 0xe084b000
unix 26032 247 - Live 0xe0815000
