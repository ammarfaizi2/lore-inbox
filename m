Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbTCRFF5>; Tue, 18 Mar 2003 00:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbTCRFF5>; Tue, 18 Mar 2003 00:05:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55262 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261914AbTCRFFz>; Tue, 18 Mar 2003 00:05:55 -0500
Date: Mon, 17 Mar 2003 21:16:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 466] New: SBP2 driver doesn't appear to register a block device? 
Message-ID: <46120000.1047964602@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=466

           Summary: SBP2 driver doesn't appear to register a block device?
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: bcollins@debian.org
         Submitter: thoffman@arnor.net


Distribution: Red Hat 8.0
Hardware Environment: Single Processor Pentium III, details below
Software Environment: 
Problem Description: Loading ieee1394 SBP2 driver doesn't result in a usable
block device appearing.

Steps to reproduce: 
Attach firewire drive. 
Boot 2.5.65, load ieee1394, ohci1394, sbp2 modules.

The firewire to IDE bridge is correctly detected, as is the actual hard drive
attached to the bridge.  Everything seems to be fine, but the drive does not
show up in /proc/partitions, and I can't mount /dev/sda1.

(Under a 2.4.x kernel, /dev/sda and /dev/sda1 would show up at this point)

Here is more information: ieee1394 and SCSI settings from .config:

CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m

CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m

dmesg after loading the modules has:

ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e9000000-e90007ff]  Max
Packet=[2048]
ieee1394: Node added: ID:BUS[00:1023]  GUID[0004830000002cb3]  [Unknown] (Oxford  )
ieee1394: Host added: ID:BUS[01:1023]  GUID[0030dd8000505e29]  [Unknown] (Linux
OHCI-1394)

SCSI subsystem initialized
scsi0 : SCSI emulation for for IEEE-1394 Storage Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
  Vendor: WDC WD12  Model: 00JB-00CRA1       Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06

- - -
thoffman@rohan linux-2.5.65]$ cat /proc/partitions
major minor  #blocks  name

   3     0   60030432 hda
   3     1    1052226 hda1
   3     2    5245222 hda2
   3     3    1052257 hda3
   3     4          1 hda4
   3     5     522081 hda5
   3     6     522081 hda6
   3     7   51632878 hda7

cat /proc/bus/ieee1394/devices
Node[00:1023]  GUID[0004830000002cb3]:
  Vendor ID   : `Unknown' [0x000483]
  Vendor text : `Oxford  '
  Capabilities: 0x0083c0
  Tlabel stats:
    Free  : 64
    Total : 66
    Mask  : 0000000000000000
  Bus Options :
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID  : Oxford   [000483] / 911D [000001]
    Software Spec ID : 00609e
    Software Version : 010483
    Driver           : SBP2 Driver
    Length (in quads): 8
Node[01:1023]  GUID[0030dd8000505e29]:
  Vendor ID   : `Unknown' [0x000000]
  Vendor text : `Linux OHCI-1394'
  Capabilities: 0x0083c0
  Tlabel stats:
    Free  : 64
    Total : 23
    Mask  : 0000000000000000
  Bus Options :
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no

cat scsi/sbp2/0
Host scsi0             : SBP-2 IEEE-1394 (ohci1394)
Driver version         : $Rev: 797 $ James Goodwin <jamesg@filanet.com>

Module options         :
  sbp2_max_speed       : S400
  sbp2_max_sectors     : 255
  sbp2_serialize_io    : no
  sbp2_exclusive_login : yes

Attached devices       :
  [Channel: 00, Id: 00, Lun: 00]  Direct-Access     WDC WD12 00JB-00CRA1

- - - - -
$ cat /proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDC WD12 Model: 00JB-00CRA1      Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 06

- - - - -
$ cat /proc/devices
[cut char devices]
Block devices:
  1 ramdisk
  3 ide0
  7 loop
 22 ide1


