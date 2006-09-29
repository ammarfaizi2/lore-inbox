Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWI2JSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWI2JSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWI2JSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:18:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:25659 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750810AbWI2JSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:18:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=mMauI4K49hFhfJBSgWrUsbisY1bSVPxJIFFKVjNDFSD+w9/xV+QmJXtIL6yvF+Fl7Bx3d5inU5XZHor08UzJzQgLT/NLPxuf812xRGuYXDPmGSIO3pkupcnMkxv/k8KSmTQ2yJUbZLxUAKI3VUP6757Kqa5ndVowMZO6TpZsooI=
Message-ID: <215036450609290218l401a5f74qa96125d78602b22f@mail.gmail.com>
Date: Fri, 29 Sep 2006 17:18:30 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: [PATCH] libata: skip nodevice bus on execute reset
Cc: lkml <linux-kernel@vger.kernel.org>, chris.mason@oracle.com
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3657_29502206.1159521510700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3657_29502206.1159521510700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

on Dell OptiPlex GX620, 2.6.18 kernel always report next info:
===========================================
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: reset failed, giving up
===========================================

and lspci output:
===========================================
00:00.0 Host bridge: Intel Corporation 945G/GZ/P/PL Express Memory
Controller Hub (rev 02)
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information
00: 86 80 70 27 06 01 90 20 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 50 da fe 01 00 da fe 05 00 00 f0 01 40 da fe
50: 00 00 30 00 1b 00 00 00 00 00 00 00 00 00 00 00
60: 01 c0 da fe 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 11 11 00 00 00 00 00 ff 03 00 00 80 1a 79 00
a0: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 10 01 00 00
e0: 09 00 09 51 02 e1 9b 88 06 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 03 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 945G/GZ/P/PL Express PCI Express
Root Port (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: fe900000-fe9fffff
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [a0] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Unknown (5)
00: 86 80 71 27 07 05 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 90 fe 90 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0b 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
80: 01 90 02 c8 00 00 00 00 0d 80 00 00 86 80 00 00
90: 05 a0 01 00 00 00 e0 fe c1 40 00 00 00 00 00 00
a0: 10 00 41 01 00 00 00 00 00 00 00 00 01 25 01 02
b0: 50 00 01 10 80 0c 00 f0 c0 01 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 00 00
f0: 00 00 01 00 00 00 00 00 86 0f 03 00 00 00 00 00

00:02.0 VGA compatible controller: Intel Corporation 945G/GZ Express
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at feb00000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at e898 [size=8]
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Memory at feac0000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [d0] Power Management version 2
00: 86 80 72 27 07 00 90 00 02 00 00 03 00 00 80 00
10: 00 00 b0 fe 99 e8 00 00 08 00 00 e0 00 00 ac fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 e0 00 00 00 09 00 09 51 02 e1 9b 88
50: 06 00 30 00 1b 00 00 00 00 00 00 00 00 00 80 7f
60: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 34 05 64 34 00 00 00 00 86 0f 03 00 00 00 00 00

00:02.1 Display controller: Intel Corporation 945G/GZ Express
Integrated Graphics Controller (rev 02)
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, fast devsel, latency 0
        Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2
00: 86 80 76 27 07 00 90 00 02 00 80 03 00 00 80 00
10: 00 00 b8 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 e0 00 00 00 09 00 09 51 02 e1 9b 88
50: 06 00 30 00 1b 00 00 00 00 00 00 00 00 00 80 7f
60: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 34 05 64 34 00 00 00 00 86 0f 03 00 00 00 00 00

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: fe800000-fe8fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)
00: 86 80 d0 27 07 05 10 00 01 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
20: 80 fe 80 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 02 00
40: 10 80 41 01 c0 0f 00 00 00 00 10 00 11 24 11 01
50: 40 00 11 30 60 05 10 00 00 00 48 01 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 01 00 00 00 e0 fe c9 40 00 00 00 00 00 00
90: 0d a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 11 00 00 00 00 00
e0: 00 00 c7 00 06 07 08 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Memory behind bridge: fe700000-fe7fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)
00: 86 80 d2 27 07 05 10 00 01 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f0 00 00 20
20: 70 fe 70 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 02 00
40: 10 80 41 01 c0 0f 00 00 00 00 10 00 11 24 11 02
50: 40 00 01 10 60 05 18 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 01 00 00 00 e0 fe d1 40 00 00 00 00 00 00
90: 0d a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 11 00 00 00 00 00
e0: 00 00 c7 00 06 07 08 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 233
        I/O ports at ff80 [size=32]
00: 86 80 c8 27 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 24 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 50
        I/O ports at ff60 [size=32]
00: 86 80 c9 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 24 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 58
        I/O ports at ff40 [size=32]
00: 86 80 ca 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 24 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 225
        I/O ports at ff20 [size=32]
00: 86 80 cb 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 24 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 233
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port
00: 86 80 cc 27 06 01 90 02 01 20 03 0c 00 00 00 00
10: 00 08 a8 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 00 a0 20 00 00 00 00
60: 20 20 ff 01 00 00 00 00 01 00 00 01 00 00 08 00
70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 ff 00 ff 00 20 00 00 88
e0: 00 00 00 00 db b6 6d 00 00 00 00 00 00 00 00 00
f0: 00 80 00 09 88 85 40 00 86 0f 01 00 06 17 02 20

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        Capabilities: [50] #0d [0000]
00: 86 80 4e 24 07 01 10 00 e1 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 f0 00 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 12 00 00
50: 0d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7
Family) AC'97 Audio Controller (rev 01)
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 225
        I/O ports at ec00 [size=256]
        I/O ports at e8c0 [size=64]
        Memory at feabfa00 (32-bit, non-prefetchable) [size=512]
        Memory at feabf900 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
00: 86 80 de 27 07 00 90 02 01 00 01 04 00 00 00 00
10: 01 ec 00 00 c1 e8 00 00 00 fa ab fe 00 f9 ab fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
40: 09 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information
00: 86 80 b8 27 07 01 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 08 00 00 80 00 00 00 81 08 00 00 10 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 8b 8a 83 80 d0 00 00 00 85 89 85 8a 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 05 14 01 0c 7c 00 e1 00 04 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 06 00 00 38 00 00 00 13 00 00 00 00 03 00 00
b0: 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 c0 c0 00 00 02 00 00 00
e0: 09 00 0c 10 a8 00 24 00 00 00 00 00 00 00 00 00
f0: 01 80 da fe 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ffa0 [size=16]
00: 86 80 df 27 05 00 88 02 01 8a 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 07 e3 00 00 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controller IDE (rev 01) (prog-if 8f [Master SecP
SecO PriP PriO])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 217
        I/O ports at fe00 [size=8]
        I/O ports at fe10 [size=4]
        I/O ports at fe20 [size=8]
        I/O ports at fe30 [size=4]
        I/O ports at fea0 [size=16]
        Capabilities: [70] Power Management version 2
00: 86 80 c0 27 07 00 b0 02 01 8f 01 01 00 00 00 00
10: 01 fe 00 00 11 fe 00 00 21 fe 00 00 31 fe 00 00
20: a1 fe 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 70 00 00 00 00 00 00 00 05 03 00 00
40: 07 e3 00 00 00 00 00 00 01 00 01 00 00 00 00 00
50: 00 00 00 00 11 10 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 1f 00 80 01 80 40 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
        Subsystem: Dell: Unknown device 01ad
        Flags: medium devsel, IRQ 177
        I/O ports at e8a0 [size=32]
00: 86 80 da 27 01 01 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 e8 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00
40: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 01)
        Subsystem: Dell Optiplex GX620
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at fe8f0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
        Capabilities: [d0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel
00: e4 14 77 16 06 00 10 00 01 00 00 02 10 00 00 00
10: 04 00 8f fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 28 10 ad 01
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 01 50 02 c0 00 20 00 64
50: 03 58 a0 00 20 00 20 06 05 d0 86 00 28 20 84 52
60: 89 0c 90 a8 80 04 00 00 98 02 01 40 00 00 18 76
70: f2 10 00 00 c0 00 00 00 50 00 00 00 00 00 00 00
80: 03 58 a0 00 00 00 00 00 34 00 13 04 82 10 08 3c
90: 09 96 00 01 00 00 00 00 00 00 00 00 40 01 00 00
a0: 00 00 00 00 78 00 00 00 00 00 00 00 9a 00 00 00
b0: 00 00 00 00 00 00 00 ae 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 0e 00 00 00 00 00 00 00
d0: 10 00 01 00 a0 0f 28 00 00 50 10 00 11 64 03 00
e0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

===========================================
it occured while scsi_eh_x  call ata_std_prereset and ata_std_softreset
I dont know if should check device on the bus at these func, and if have
not any devices, should skip it?

if yes , follow patch maybe useful :)

-Joe

------=_Part_3657_29502206.1159521510700
Content-Type: text/x-patch; name="libata-core.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="libata-core.patch"
X-Attachment-Id: f_esod5tpm

cGF0Y2ggZm9yIHNraXAgIm5vIGRldmljZSBidXMgcmVzZXQgb3BlcmF0aW9ucyIKClNpZ25lZC1v
ZmYtYnk6IEpvZSBKaW4gPGxrbWFpbGxpc3RAZ21haWwuY29tPgotLS0KCi0tLSBsaW51eC0yLjYu
MTgub3JpZy9kcml2ZXJzL3Njc2kvbGliYXRhLWNvcmUuYwkyMDA2LTA5LTI5IDE2OjU4OjM4LjAw
MDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4Lm5ldy9kcml2ZXJzL3Njc2kvbGliYXRhLWNv
cmUuYwkyMDA2LTA5LTI5IDE2OjUzOjIwLjAwMDAwMDAwMCArMDgwMApAQCAtMjYzMSw4ICsyNjMx
LDIwIEBACiB7CiAJc3RydWN0IGF0YV9laF9jb250ZXh0ICplaGMgPSAmYXAtPmVoX2NvbnRleHQ7
CiAJY29uc3QgdW5zaWduZWQgbG9uZyAqdGltaW5nID0gc2F0YV9laGNfZGViX3RpbWluZyhlaGMp
OworCXVuc2lnbmVkIGludCBzbGF2ZV9wb3NzaWJsZSA9IGFwLT5mbGFncyAmIEFUQV9GTEFHX1NM
QVZFX1BPU1M7CisJdW5zaWduZWQgaW50IGRldm1hc2sgPSAwOwogCWludCByYzsKIAorCWlmIChh
dGFfcG9ydF9vZmZsaW5lKGFwKSkgeworCQlyZXR1cm4gMDsKKwl9CisKKwkvKiBkZXRlcm1pbmUg
aWYgZGV2aWNlIDAvMSBhcmUgcHJlc2VudCAqLworCWlmIChhdGFfZGV2Y2hrKGFwLCAwKSkKKwkJ
ZGV2bWFzayB8PSAoMSA8PCAwKTsKKwlpZiAoc2xhdmVfcG9zc2libGUgJiYgYXRhX2RldmNoayhh
cCwgMSkpCisJCWRldm1hc2sgfD0gKDEgPDwgMSk7CisKIAkvKiBoYW5kbGUgbGluayByZXN1bWUg
JiBob3RwbHVnIHNwaW51cCAqLwogCWlmICgoZWhjLT5pLmZsYWdzICYgQVRBX0VISV9SRVNVTUVf
TElOSykgJiYKIAkgICAgKGFwLT5mbGFncyAmIEFUQV9GTEFHX0hSU1RfVE9fUkVTVU1FKSkKQEAg
LTI2NjAsNyArMjY3Miw4IEBACiAJLyogV2FpdCBmb3IgIUJTWSBpZiB0aGUgY29udHJvbGxlciBj
YW4gd2FpdCBmb3IgdGhlIGZpcnN0IEQySAogCSAqIFJlZyBGSVMgYW5kIHdlIGRvbid0IGtub3cg
dGhhdCBubyBkZXZpY2UgaXMgYXR0YWNoZWQuCiAJICovCi0JaWYgKCEoYXAtPmZsYWdzICYgQVRB
X0ZMQUdfU0tJUF9EMkhfQlNZKSAmJiAhYXRhX3BvcnRfb2ZmbGluZShhcCkpCisJaWYgKCEoYXAt
PmZsYWdzICYgQVRBX0ZMQUdfU0tJUF9EMkhfQlNZKSAmJiAKKyAgICAgICAgICAgICFhdGFfcG9y
dF9vZmZsaW5lKGFwKSAmJiBkZXZtYXNrKQogCQlhdGFfYnVzeV9zbGVlcChhcCwgQVRBX1RNT1VU
X0JPT1RfUVVJQ0ssIEFUQV9UTU9VVF9CT09UKTsKIAogCXJldHVybiAwOwpAQCAtMjY5Nyw2ICsy
NzEwLDEwIEBACiAJCWRldm1hc2sgfD0gKDEgPDwgMCk7CiAJaWYgKHNsYXZlX3Bvc3NpYmxlICYm
IGF0YV9kZXZjaGsoYXAsIDEpKQogCQlkZXZtYXNrIHw9ICgxIDw8IDEpOworCQorCS8qIGhhdmUg
bm90IGEgaW52YWxpZCBkZXZpY2UgYmVlbiBmb3VuZCAqLworCWlmICghZGV2bWFzaykKKwkJcmV0
dXJuIDA7CiAKIAkvKiBzZWxlY3QgZGV2aWNlIDAgYWdhaW4gKi8KIAlhcC0+b3BzLT5kZXZfc2Vs
ZWN0KGFwLCAwKTsK
------=_Part_3657_29502206.1159521510700--
