Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312353AbSC3VNE>; Sat, 30 Mar 2002 16:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312386AbSC3VMy>; Sat, 30 Mar 2002 16:12:54 -0500
Received: from mackman.submm.caltech.edu ([131.215.85.46]:133 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S312353AbSC3VMk>;
	Sat, 30 Mar 2002 16:12:40 -0500
Date: Sat, 30 Mar 2002 13:12:38 -0800 (PST)
From: Ryan Mack <rmack@mackman.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ERROR] SCSI layer or adapter hiccup
Message-ID: <Pine.LNX.4.44.0203301302100.10974-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have very complete logs of this event as the drive were remounted 
R/O and the console filled with messages from the md layer and (ext3) fs 
layer.  Here's the logs that I do have though:

(scsi0:A:0:0): Unexpected busfree in Data-out phase
SEQADDR == 0x54
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28320
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28328
(scsi0:A:0:0): Unexpected busfree in Message-in phase
SEQADDR == 0x16d
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28336
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28344
(scsi0:A:0:0): Unexpected busfree in Message-in phase
SEQADDR == 0x1a6
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28352
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28360
(scsi0:A:0:0): Unexpected busfree in Message-in phase
SEQADDR == 0x16d
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28368
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28376
(scsi0:A:0:0): Unexpected busfree in Message-in phase
SEQADDR == 0x1a6
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 183816
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
 I/O error: dev 08:01, sector 28384

After sysrq'ing an emergency sync, unmount, and reboot, I ran IBM DFT
which reported that no errors had been logged on the disk itself.  
Journal replayed uneventfully and I forced a full fsck which reported no
errors.  Whew.  Good work y'all.

Anyhow, it would seem that there was a hiccup in the SCSI layer itself or 
in the controller (Adaptec AIC-7890) driver.

Here's a brief system synopsis:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11)
02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02

Linux mackman.net 2.4.18 #1 SMP Mon Feb 25 15:14:14 PST 2002 i686 unknown

gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)

Module                  Size  Used by    Not tainted
autofs4                 8964   1 (autoclean)
3c59x                  25896   1
mousedev                4032   1
hid                    12704   0 (unused)
input                   3552   0 [mousedev hid]
uhci                   26248   0 (unused)
usbcore                52832   1 [hid uhci]

Any information you could give me about the source of the error would be 
appreciated.

Thanks,

Ryan Mack

