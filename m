Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313556AbSDZAHJ>; Thu, 25 Apr 2002 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSDZAHI>; Thu, 25 Apr 2002 20:07:08 -0400
Received: from bgp01033204bgs.sothfd01.mi.comcast.net ([68.41.239.132]:4356
	"EHLO avi.ashevin.com") by vger.kernel.org with ESMTP
	id <S313556AbSDZAHH>; Thu, 25 Apr 2002 20:07:07 -0400
Date: Thu, 25 Apr 2002 20:07:12 -0400 (EDT)
From: Avi Shevin <avi@avi.ashevin.com>
To: bcollins@debian.org
cc: linux-kernel@vger.kernel.org
Subject: firewire harddrive access causes system hang
Message-ID: <Pine.LNX.4.21.0204251953110.674-100000@avi.ashevin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a Maxtor PCI IEEE1394 controller card with an ACOMData 60GB
firewire drive attached to it.  I can successfully mount the drive as
/dev/sda1 after inserting the ieee1394 and scsi modules in the correct
order.  The problem is that accessing the disk too many times (?)
causes the machine to hang.  The last time it did this, I was copying
the kernel source to it, as a test.  It froze in mid screen refresh.

Drive:  60GB ACOMData, formatted with single ext2 partition
kernel: 2.4.18, with scsi and sd as modules
ieee1394: 460 (nightly from 4/24)

Below is the dmesg output from inserting the modules and running the
rescan-scsi-bus.sh script:

------ from syslog -------------------------------------------------
Apr 25 19:38:07 avi kernel: ohci1394: $Rev: 460 $ Ben Collins
<bcollins@debian.org>
Apr 25 19:38:07 avi kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]
MMIO=[ffefd000-ffefe000]  Max Packet=[2048]
Apr 25 19:38:07 avi kernel: SCSI subsystem driver Revision: 1.00
Apr 25 19:38:07 avi kernel: ieee1394: sbp2: Driver forced to serialize
I/O (serialize_io = 1)
Apr 25 19:38:07 avi kernel: scsi0 : IEEE-1394 SBP-2 protocol driver
(host: ohci1394)
Apr 25 19:38:07 avi kernel: $Revision: 1.0 $ James Goodwin
<jamesg@filanet.com>
Apr 25 19:38:07 avi kernel: SBP-2 module load options:
Apr 25 19:38:07 avi kernel: - Max speed supported: S400
Apr 25 19:38:07 avi kernel: - Max sectors per I/O supported: 255
Apr 25 19:38:07 avi kernel: - Max outstanding commands supported: 8
Apr 25 19:38:07 avi kernel: - Max outstanding commands per lun
supported: 1
Apr 25 19:38:07 avi kernel: - Serialized I/O (debug): yes
Apr 25 19:38:07 avi kernel: - Exclusive login: yes
Apr 25 19:38:07 avi kernel: scsi singledevice 0 0 0 0
Apr 25 19:38:07 avi kernel: scsi singledevice 0 0 1 0
Apr 25 19:38:07 avi kernel: scsi singledevice 0 0 2 0
Apr 25 19:38:07 avi kernel: scsi singledevice 0 0 3 0
Apr 25 19:38:07 avi kernel: scsi singledevice 0 0 4 0
Apr 25 19:38:07 avi kernel: scsi singledevice 0 0 5 0
Apr 25 19:38:08 avi kernel: scsi singledevice 0 0 6 0
Apr 25 19:38:08 avi kernel: scsi singledevice 0 0 7 0
Apr 25 19:38:08 avi kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr 25 19:38:08 avi kernel: ieee1394: sbp2: Node[00:1023]: Max speed
[S400] - Max payload [2048]
Apr 25 19:38:08 avi kernel: ieee1394: Device added: Node[00:1023]
GUID[00063a0245003d2b]  [DMI     ]
Apr 25 19:38:08 avi kernel: ieee1394: Host added: Node[01:1023]
GUID[0030dd8000071760]  [Linux OHCI-1394]
Apr 25 19:38:15 avi kernel: scsi singledevice 0 0 0 0
Apr 25 19:38:15 avi kernel:   Vendor: DMI       Model: 1394 HDD
Rev: 2.34
Apr 25 19:38:15 avi kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Apr 25 19:38:15 avi kernel: Attached scsi disk sda at scsi0, channel 0,
id 0, lun 0
Apr 25 19:38:15 avi kernel: SCSI device sda: 117266688 512-byte hdwr
sectors (60041 MB)
Apr 25 19:38:15 avi kernel:  sda: sda1
------ end syslog --------------------------------------------------



I included the sbp2_serialize_io=1 parameter when inserting sbp2.

If you could please provide direction for debugging this, I would be in
your debt.

Thanks,

---

Avi Shevin
avi@ashevin.com

