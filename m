Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLWUTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTLWUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:19:47 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:4977 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262758AbTLWUTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:19:34 -0500
Subject: 2.6 only sees 1 of 3 firewire devices
From: James J Myers <myersjj@pacbell.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072210771.1597.30.camel@jjmhome>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Dec 2003 12:19:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.0-1.104 from Redhat with latest ieee1394 trunk and
libraw 0.10.  Gscanbus sees 3 devices although it reports errors trying
to get data from one of them.  ieee1394 driver only sees QPS CDRW. It
does NOT see my 2 firewire drives (1 Maxtor and 1 WD).

I'm not subscribed to the list so please reply personally if I can be of
some assistancve in tracking down this problem.

Contents of /proc/scsi/scsi:
--------------------------
root@jjmhome root]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QPS      Model: CRD-BP1500P      Rev: 6z34
  Type:   CD-ROM                           ANSI SCSI revision: 02
[root@jjmhome root]#

Output of gscanbus:
------------------
[root@jjmhome root]# modprobe raw1394
[root@jjmhome root]# gscanbus
Error while reading from IEEE1394: : Resource temporarily unavailable
0/0x0000fffff0000400: read failed
Error while reading from IEEE1394: : Resource temporarily unavailable
0/0x0000fffff0000404: read failed
0/0x0000fffff0000404: wrong magic quadlet:
Error while reading from IEEE1394: : Resource temporarily unavailable
0/0x0000fffff0000400: read failed
0/0x0000fffff0000400: wrong bus info block length


Gscanbus info for OHCI-1394
SelfID info
----------
Physical ID: 3
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: ~1W
Port 0: Not connected
Port 1: Connected to child node
Port 2: Connected to child node
Init.reset: Yes

CSR ROM Info
----------
GUID: 0x0090A94000003903
Node Capabilities: 0x000083C0
Vendor ID: 0x0000004C
Unit Spec ID: 0x00000000
Unit SW Version: 0x00000000
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor: NEC CORPORATION
Textual Leafes:
Linux OHCI-1394

Gscanbus info for Unknown (actually WD hard drive)
SelfID info
----------
Physical ID: 0
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: ~10W
Port 0: Connected to parent node
Port 1: Not connected
Init.reset: No

CSR ROM Info
----------
GUID: 0x0000000000000000
Node Capabilities: 0x00000000
Vendor ID: 0x00000000
Unit Spec ID: 0x00000000
Unit SW Version: 0x00000000
Model ID: 0x00000000
Nr. Textual Leafes: 0

Vendor: (null)
Textual Leafes:

Gscanbus info for Maxtor
SelfID info
----------
Physical ID: 1
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: ~1W
Port 0: Connected to parent node
Port 1: Not connected
Init.reset: No

CSR ROM Info
----------
GUID: 0x0010B920007A2273
Node Capabilities: 0x000083C0
Vendor ID: 0x000010B9
Unit Spec ID: 0x0000609E
Unit SW Version: 0x00010483
Model ID: 0x00005000
Textual Leafes:
Maxtor
v0.04

Gscanbus info for QPS
SelfID info
----------
Physical ID: 2
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: ~1W
Port 0: Connected to parent node
Port 1: Connected to child node
Init.reset: No

CSR ROM Info
----------
GUID: 0x0001F30240001BE7
Node Capabilities: 0x000083C0
Vendor ID: 0x000001F3
Unit Spec ID: 0x0000609E
Unit SW Version: 0x00010483
Model ID: 0x00000240
Nr. Textual Leafes: 1

Vendor: QPS, Inc.
Textual Leafes:
QPS

lspci output:

[root@jjmhome root]# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS961 [MuTIOL
Media IO] (rev 10)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
00:07.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink]
Host Controller (rev 01)
00:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2
MX 100 DDR/200 DDR] (rev b2)

dmesg output:

Linux version 2.6.0-1.104mts (root@jjmhome) (gcc version 3.3.2 20031022
(Red Hat Linux 3.3.2-1)) #2 Sat Dec 20 21:59:23 PST 2003

SCSI subsystem initialized
ohci1394: $Rev$ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9] 
MMIO=[cf001000-cf0017ff]  Max Packet=[1024]
sbp2: $Rev$ Ben Collins <bcollins@debian.org>
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
ieee1394: ConfigROM quadlet transaction error for node 0-00:1023
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0010b920007a2273]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0001f30240001be7]
ieee1394: Host added: ID:BUS[0-03:1023]  GUID[0090a94000003903]
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-01:1023: Max speed [S400] - Max payload [1024]
  Vendor: Maxtor    Model: 5000XT            Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ieee1394: sbp2: Node 0-02:1023: Using 36byte inquiry workaround
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [FUTS]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-02:1023: Max speed [S400] - Max payload [1024]
  Vendor: QPS       Model: CRD-BP1500P       Rev: 6z34
  Type:   CD-ROM                             ANSI SCSI revision: 02
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Error logging into SBP-2 device - login failed
ieee1394: sbp2: sbp2_reconnect_device failed!
ieee1394: sbp2: Reconnected to SBP-2 device
ieee1394: sbp2: Node 0-02:1023: Max speed [S400] - Max payload [1024]


