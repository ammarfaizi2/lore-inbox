Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWI3FGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWI3FGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWI3FGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 01:06:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:28540 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750902AbWI3FGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 01:06:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=qYtY2LldxdbdCqjxTO7zaJeRLjY8MzW5zRTIXbmeYFTLkXRDL93MkxGGD/BS9Z100d2t0tGGYmgc5fOXp8xxyqyWc4kUMJOgOdFs3AvvY7LaPEwu9HlH4ceDI4H5/zxribw2mSBvh31ObBWsh5/Hsp+KUtuwiODkaUFKLFBGqhs=
Message-ID: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>
Date: Sat, 30 Sep 2006 13:06:47 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] libata: skip reset on bus not a device
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16676_29106052.1159592807346"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16676_29106052.1159592807346
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On my pc(Dell OptiPlex GX620), while boot up it by 2.6.18, the next
info always report:
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

and follow is lspci output:
===========================================
00:00.0 Host bridge: Intel Corporation 945G/GZ/P/PL Express Memory
Controller Hub (rev 02)
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, fast devsel, latency 0
        Capabilities: <available only to root>
00: 86 80 70 27 06 01 90 20 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 945G/GZ/P/PL Express PCI Express
Root Port (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: fe900000-fe9fffff
        Capabilities: <available only to root>
00: 86 80 71 27 07 05 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
 20: 90 fe 90 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0b 01 02 00

00:02.0 VGA compatible controller: Intel Corporation 945G/GZ Express
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at feb00000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at e898 [size=8]
         Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Memory at feac0000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: <available only to root>
00: 86 80 72 27 07 00 90 00 02 00 00 03 00 00 80 00
10: 00 00 b0 fe 99 e8 00 00 08 00 00 e0 00 00 ac fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00

00:02.1 Display controller: Intel Corporation 945G/GZ Express
Integrated Graphics Controller (rev 02)
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, fast devsel, latency 0
        Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: <available only to root>
00: 86 80 76 27 07 00 90 00 02 00 80 03 00 00 80 00
10: 00 00 b8 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: fe800000-fe8fffff
        Capabilities: <available only to root>
00: 86 80 d0 27 07 05 10 00 01 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
 20: 80 fe 80 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 02 00

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Memory behind bridge: fe700000-fe7fffff
        Capabilities: <available only to root>
00: 86 80 d2 27 07 05 10 00 01 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f0 00 00 20
20: 70 fe 70 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 02 00

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 233
         I/O ports at ff80 [size=32]
00: 86 80 c8 27 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 50
        I/O ports at ff60 [size=32]
00: 86 80 c9 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 58
        I/O ports at ff40 [size=32]
00: 86 80 ca 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 00

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 225
        I/O ports at ff20 [size=32]
00: 86 80 cb 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 233
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>
00: 86 80 cc 27 06 01 90 02 01 20 03 0c 00 00 00 00
10: 00 08 a8 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 00 00

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        Capabilities: <available only to root>
00: 86 80 4e 24 07 01 10 00 e1 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 f0 00 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 02 00

00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7
Family) AC'97 Audio Controller (rev 01)
        Subsystem: Dell: Unknown device 01ad
        Flags: bus master, medium devsel, latency 0, IRQ 225
        I/O ports at ec00 [size=256]
        I/O ports at e8c0 [size=64]
        Memory at feabfa00 (32-bit, non-prefetchable) [size=512]
        Memory at feabf900 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>
00: 86 80 de 27 07 00 90 02 01 00 01 04 00 00 00 00
10: 01 ec 00 00 c1 e8 00 00 00 fa ab fe 00 f9 ab fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
        Flags: bus master, medium devsel, latency 0
        Capabilities: <available only to root>
00: 86 80 b8 27 07 01 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

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
        Capabilities: <available only to root>
00: 86 80 c0 27 07 00 b0 02 01 8f 01 01 00 00 00 00
10: 01 fe 00 00 11 fe 00 00 21 fe 00 00 31 fe 00 00
20: a1 fe 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 70 00 00 00 00 00 00 00 05 03 00 00

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
        Subsystem: Dell: Unknown device 01ad
        Flags: medium devsel, IRQ 177
        I/O ports at e8a0 [size=32]
00: 86 80 da 27 01 01 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 e8 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 01)
        Subsystem: Dell Optiplex GX620
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at fe8f0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: <available only to root>
00: e4 14 77 16 06 00 10 00 01 00 00 02 10 00 00 00
10: 04 00 8f fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 28 10 ad 01
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 00 00
 ===========================================

through traced the code, and found which caused it:
at scsi_eh_[port_no] kernel thread, it should reset the bus, before reset it,
it never check it if have a device. if it should skip it?
thanks

attachment is the patch

-- 
Regards,
Joe Jin

------=_Part_16676_29106052.1159592807346
Content-Type: text/x-patch; name=libata-core.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_espjl4qd
Content-Disposition: attachment; filename="libata-core.patch"

LS0tIGxpbnV4LTIuNi4xOC5vcmlnL2RyaXZlcnMvc2NzaS9saWJhdGEtY29yZS5jCTIwMDYtMDkt
MjkgMTY6NTg6MzguMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTgvZHJpdmVycy9zY3Np
L2xpYmF0YS1jb3JlLmMJMjAwNi0wOS0zMCAxMjo0NDozMi4wMDAwMDAwMDAgKzA4MDAKQEAgLTI2
MzEsOCArMjYzMSwxOSBAQCBpbnQgYXRhX3N0ZF9wcmVyZXNldChzdHJ1Y3QgYXRhX3BvcnQgKmFw
CiB7CiAJc3RydWN0IGF0YV9laF9jb250ZXh0ICplaGMgPSAmYXAtPmVoX2NvbnRleHQ7CiAJY29u
c3QgdW5zaWduZWQgbG9uZyAqdGltaW5nID0gc2F0YV9laGNfZGViX3RpbWluZyhlaGMpOworCXVu
c2lnbmVkIGludCBzbGF2ZV9wb3NzaWJsZSA9IGFwLT5mbGFncyAmIEFUQV9GTEFHX1NMQVZFX1BP
U1M7CisJdW5zaWduZWQgaW50IGRldm1hc2sgPSAwOwogCWludCByYzsKIAorCWlmIChhdGFfcG9y
dF9vZmZsaW5lKGFwKSkgCisJCXJldHVybiAwOworCisJLyogZGV0ZXJtaW5lIGlmIGRldmljZSAw
LzEgYXJlIHByZXNlbnQgKi8KKwlpZiAoYXRhX2RldmNoayhhcCwgMCkpCisJCWRldm1hc2sgfD0g
KDEgPDwgMCk7CisJaWYgKHNsYXZlX3Bvc3NpYmxlICYmIGF0YV9kZXZjaGsoYXAsIDEpKQorCQlk
ZXZtYXNrIHw9ICgxIDw8IDEpOworCiAJLyogaGFuZGxlIGxpbmsgcmVzdW1lICYgaG90cGx1ZyBz
cGludXAgKi8KIAlpZiAoKGVoYy0+aS5mbGFncyAmIEFUQV9FSElfUkVTVU1FX0xJTkspICYmCiAJ
ICAgIChhcC0+ZmxhZ3MgJiBBVEFfRkxBR19IUlNUX1RPX1JFU1VNRSkpCkBAIC0yNjYwLDcgKzI2
NzEsOCBAQCBpbnQgYXRhX3N0ZF9wcmVyZXNldChzdHJ1Y3QgYXRhX3BvcnQgKmFwCiAJLyogV2Fp
dCBmb3IgIUJTWSBpZiB0aGUgY29udHJvbGxlciBjYW4gd2FpdCBmb3IgdGhlIGZpcnN0IEQySAog
CSAqIFJlZyBGSVMgYW5kIHdlIGRvbid0IGtub3cgdGhhdCBubyBkZXZpY2UgaXMgYXR0YWNoZWQu
CiAJICovCi0JaWYgKCEoYXAtPmZsYWdzICYgQVRBX0ZMQUdfU0tJUF9EMkhfQlNZKSAmJiAhYXRh
X3BvcnRfb2ZmbGluZShhcCkpCisJaWYgKCEoYXAtPmZsYWdzICYgQVRBX0ZMQUdfU0tJUF9EMkhf
QlNZKSAmJiAKKyAgICAgICAgICAgICFhdGFfcG9ydF9vZmZsaW5lKGFwKSAmJiBkZXZtYXNrKQog
CQlhdGFfYnVzeV9zbGVlcChhcCwgQVRBX1RNT1VUX0JPT1RfUVVJQ0ssIEFUQV9UTU9VVF9CT09U
KTsKIAogCXJldHVybiAwOwpAQCAtMjY5Nyw2ICsyNzA5LDEwIEBAIGludCBhdGFfc3RkX3NvZnRy
ZXNldChzdHJ1Y3QgYXRhX3BvcnQgKmEKIAkJZGV2bWFzayB8PSAoMSA8PCAwKTsKIAlpZiAoc2xh
dmVfcG9zc2libGUgJiYgYXRhX2RldmNoayhhcCwgMSkpCiAJCWRldm1hc2sgfD0gKDEgPDwgMSk7
CisJCisJLyogaGF2ZSBub3QgYSBpbnZhbGlkIGRldmljZSBiZWVuIGZvdW5kICovCisJaWYgKCFk
ZXZtYXNrKQorCQlyZXR1cm4gMDsKIAogCS8qIHNlbGVjdCBkZXZpY2UgMCBhZ2FpbiAqLwogCWFw
LT5vcHMtPmRldl9zZWxlY3QoYXAsIDApOwo=
------=_Part_16676_29106052.1159592807346--
