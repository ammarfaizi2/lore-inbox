Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133098AbRAaCGE>; Tue, 30 Jan 2001 21:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135196AbRAaCFy>; Tue, 30 Jan 2001 21:05:54 -0500
Received: from [64.160.188.242] ([64.160.188.242]:13573 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S133098AbRAaCFo>; Tue, 30 Jan 2001 21:05:44 -0500
Date: Tue, 30 Jan 2001 18:04:42 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: David Raufeisen <david@fortyoz.org>, linux-kernel@vger.kernel.org
Subject: Re:  VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.21.0101301716490.3105-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.21.0101301755330.3205-200000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1606356292-798176763-980906682=:3205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1606356292-798176763-980906682=:3205
Content-Type: TEXT/PLAIN; charset=US-ASCII

OK, just completed the upgrade to 2.4.1-pre12 + via82cxxxx.diff.

SYSTEM SPECS CHANGES
===================
Shut off ACPI
Shut off 2nd IDE controller in BIOS
Shut off APM
Disabled UDMA support in BIOS
Removed 256MB RAM (768M total RAM) *


Everything is running stabler now. Here's what I've got set up right now.


VIA SUPPORT
============
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d4000000-d7ffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000
	Capabilities: [c0] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

00:0c.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ac00
	I/O ports at b000
	I/O ports at b400
	I/O ports at b800
	I/O ports at bc00
	Memory at db000000 (32-bit, non-prefetchable)
	Capabilities: [58] Power Management version 1

00:0e.0 SCSI storage controller: Advanced System Products, Inc ABP940-UW
	Flags: bus master, medium devsel, latency 32, IRQ 15
	I/O ports at c000
	Memory at db020000 (32-bit, non-prefetchable)

00:10.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at c400
	Memory at db021000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
	Flags: 66Mhz, fast devsel
	Memory at d4000000 (32-bit, non-prefetchable)
	Memory at d8000000 (32-bit, prefetchable)
	I/O ports at 9000
	Capabilities: [54] AGP version 1.0
	Capabilities: [60] Power Management version 1


PROMISE SUPPORT
===============
PDC20265: IDE controller on PCI bus 00 dev 60
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.



DMESG - VIA
==============
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
System Vendor: VIA Technologies, Inc..
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB


DD TESTING
==========
[root@timberwolf /root]# dd if=/dev/hda7 of=/tmp/testing.img bs=1024k count=20002000+0 records in
2000+0 records out
[root@timberwolf /root]# ls -al /tmp/testing.img
-rw-r--r--    1 root     root     2097152000 Jan 29 17:54 /tmp/testing.img
[root@timberwolf /root]# ls -alh /tmp/testing.img
-rw-r--r--    1 root     root         2.0G Jan 29 17:54 /tmp/testing.img
[root@timberwolf /root]#




I'm also attaching a ksyms dump.


David D.W. Downey


---1606356292-798176763-980906682=:3205
Content-Type: TEXT/plain; name="kernel-symbols.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0101301804420.3205@ns-01.hislinuxbox.com>
Content-Description: 
Content-Disposition: attachment; filename="kernel-symbols.txt"

QWRkcmVzcyAgIFN5bWJvbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
ZWZpbmVkIGJ5DQpmMjg2YTA2MCAgYWR2YW5zeXNfcHJvY19pbmZvICAgICAg
ICAgICAgICAgIFthZHZhbnN5c10NCmYyODZhMDYwICBfX2luc21vZF9hZHZh
bnN5c19TLnRleHRfTDYwODk2ICAgW2FkdmFuc3lzXQ0KZjI4NmNhZjAgIGFk
dmFuc3lzX3Jlc2V0ICAgICAgICAgICAgICAgICAgICBbYWR2YW5zeXNdDQpm
Mjg2Yzc3MCAgYWR2YW5zeXNfYWJvcnQgICAgICAgICAgICAgICAgICAgIFth
ZHZhbnN5c10NCmYyODZjNjYwICBhZHZhbnN5c19jb21tYW5kICAgICAgICAg
ICAgICAgICAgW2FkdmFuc3lzXQ0KZjI4NmE1OGMgIGFkdmFuc3lzX2RldGVj
dCAgICAgICAgICAgICAgICAgICBbYWR2YW5zeXNdDQpmMjg2ZDA4NCAgYWR2
YW5zeXNfYmlvc3BhcmFtICAgICAgICAgICAgICAgIFthZHZhbnN5c10NCmYy
ODdiMGUwICBfX2luc21vZF9hZHZhbnN5c19TLmRhdGFfTDE1NDg4ICAgW2Fk
dmFuc3lzXQ0KZjI4N2VmMDAgIF9faW5zbW9kX2FkdmFuc3lzX1MuYnNzX0wx
MjggICAgICBbYWR2YW5zeXNdDQpmMjg3OGU2MCAgX19pbnNtb2RfYWR2YW5z
eXNfUy5yb2RhdGFfTDg4MDggIFthZHZhbnN5c10NCmYyODZjMzUwICBhZHZh
bnN5c19yZWxlYXNlICAgICAgICAgICAgICAgICAgW2FkdmFuc3lzXQ0KZjI4
NmM2OTggIGFkdmFuc3lzX3F1ZXVlY29tbWFuZCAgICAgICAgICAgICBbYWR2
YW5zeXNdDQpmMjg2YTAwMCAgX19pbnNtb2RfYWR2YW5zeXNfTy9saWIvbW9k
dWxlcy8yLjQuMS1wcmUxMi9rZXJuZWwvZHJpdmVycy9zY3NpL2FkdmFuc3lz
Lm9fTTNBNzYxQTNBX1YxMzIwOTcgIFthZHZhbnN5c10NCmYyODZjNDQ0ICBh
ZHZhbnN5c19pbmZvICAgICAgICAgICAgICAgICAgICAgW2FkdmFuc3lzXQ0K
ZjI4NmQxMGMgIGFkdmFuc3lzX3NldHVwICAgICAgICAgICAgICAgICAgICBb
YWR2YW5zeXNdDQpmMjg2MjM0NCAgdHVsaXBfZGVidWcgICAgICAgICAgICAg
ICAgICAgICAgIFt0dWxpcF0NCmYyODYyNmUwICB0MjEwNDBfY3NyMTMgICAg
ICAgICAgICAgICAgICAgICAgW3R1bGlwXQ0KZjI4NWJhOTggIHR1bGlwX21k
aW9fd3JpdGUgICAgICAgICAgICAgICAgICBbdHVsaXBdDQpmMjg1YTI5YyAg
dDIxMTQyX3N0YXJ0X253YXkgICAgICAgICAgICAgICAgIFt0dWxpcF0NCmYy
ODYyMzQ4ICB0dWxpcF90YmwgICAgICAgICAgICAgICAgICAgICAgICAgW3R1
bGlwXQ0KZjI4NjI2ZjAgIHQyMTA0MV9jc3IxMyAgICAgICAgICAgICAgICAg
ICAgICBbdHVsaXBdDQpmMjg2MjZmYSAgdDIxMDQxX2NzcjE0ICAgICAgICAg
ICAgICAgICAgICAgIFt0dWxpcF0NCmYyODYyNzA0ICB0MjEwNDFfY3NyMTUg
ICAgICAgICAgICAgICAgICAgICAgW3R1bGlwXQ0KZjI4NWQxNjAgIGNvbWV0
X3RpbWVyICAgICAgICAgICAgICAgICAgICAgICBbdHVsaXBdDQpmMjg2MmE0
NCAgdHVsaXBfbWF4X2ludGVycnVwdF93b3JrICAgICAgICAgIFt0dWxpcF0N
CmYyODViMjg4ICB0dWxpcF9pbnRlcnJ1cHQgICAgICAgICAgICAgICAgICAg
W3R1bGlwXQ0KZjI4NWEwNjAgIF9faW5zbW9kX3R1bGlwX1MudGV4dF9MMjMx
ODYgICAgICBbdHVsaXBdDQpmMjg1YTAwMCAgX19pbnNtb2RfdHVsaXBfTy9s
aWIvbW9kdWxlcy8yLjQuMS1wcmUxMi9rZXJuZWwvZHJpdmVycy9uZXQvdHVs
aXAvdHVsaXAub19NM0E3NjFBMzlfVjEzMjA5NyAgW3R1bGlwXQ0KZjI4NjJh
NDAgIHR1bGlwX3J4X2NvcHlicmVhayAgICAgICAgICAgICAgICBbdHVsaXBd
DQpmMjg1YTc5MCAgdHVsaXBfcGFyc2VfZWVwcm9tICAgICAgICAgICAgICAg
IFt0dWxpcF0NCmYyODVkMTE4ICBteGljX3RpbWVyICAgICAgICAgICAgICAg
ICAgICAgICAgW3R1bGlwXQ0KZjI4NWM3MTAgIHBuaWNfZG9fbndheSAgICAg
ICAgICAgICAgICAgICAgICBbdHVsaXBdDQpmMjg1YmJmMCAgdHVsaXBfc2Vs
ZWN0X21lZGlhICAgICAgICAgICAgICAgIFt0dWxpcF0NCmYyODYxNzg0ICBt
ZWRpYW5hbWUgICAgICAgICAgICAgICAgICAgICAgICAgW3R1bGlwXQ0KZjI4
NWI5MzAgIHR1bGlwX21kaW9fcmVhZCAgICAgICAgICAgICAgICAgICBbdHVs
aXBdDQpmMjg2MjljMCAgX19pbnNtb2RfdHVsaXBfUy5ic3NfTDEzNiAgICAg
ICAgIFt0dWxpcF0NCmYyODVjNTY4ICB0dWxpcF9jaGVja19kdXBsZXggICAg
ICAgICAgICAgICAgW3R1bGlwXQ0KZjI4NWEwNjAgIHQyMTE0Ml90aW1lciAg
ICAgICAgICAgICAgICAgICAgICBbdHVsaXBdDQpmMjg1YTNiMCAgdDIxMTQy
X2xua19jaGFuZ2UgICAgICAgICAgICAgICAgIFt0dWxpcF0NCmYyODYyMGNh
ICB0MjExNDJfY3NyMTQgICAgICAgICAgICAgICAgICAgICAgW3R1bGlwXQ0K
ZjI4NWZiODAgIF9faW5zbW9kX3R1bGlwX1Mucm9kYXRhX0w5NTIyICAgICBb
dHVsaXBdDQpmMjg1YWQ1OCAgdHVsaXBfcmVhZF9lZXByb20gICAgICAgICAg
ICAgICAgIFt0dWxpcF0NCmYyODYxOThjICB0dWxpcF9tZWRpYV9jYXAgICAg
ICAgICAgICAgICAgICAgW3R1bGlwXQ0KZjI4NWM4NDAgIHBuaWNfbG5rX2No
YW5nZSAgICAgICAgICAgICAgICAgICBbdHVsaXBdDQpmMjg2MjBjMCAgX19p
bnNtb2RfdHVsaXBfUy5kYXRhX0wxNjY0ICAgICAgIFt0dWxpcF0NCmYyODVj
OTE0ICBwbmljX3RpbWVyICAgICAgICAgICAgICAgICAgICAgICAgW3R1bGlw
XQ0KZjI4NWNiNjAgIHR1bGlwX3RpbWVyICAgICAgICAgICAgICAgICAgICAg
ICBbdHVsaXBdDQo=
---1606356292-798176763-980906682=:3205--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
