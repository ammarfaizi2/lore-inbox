Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265398AbSJRTJF>; Fri, 18 Oct 2002 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSJRTHt>; Fri, 18 Oct 2002 15:07:49 -0400
Received: from mimas.island.net ([199.60.19.4]:65037 "EHLO mimas.island.net")
	by vger.kernel.org with ESMTP id <S265379AbSJRTHD>;
	Fri, 18 Oct 2002 15:07:03 -0400
Date: Fri, 18 Oct 2002 12:12:59 -0700 (PDT)
From: andy barlak <andyb@island.net>
Reply-To: <andyb@island.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.43 scsi _eh_ buslogic
Message-ID: <Pine.LNX.4.30.0210181201060.29276-100000@tosko.alm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Buslogic is still not functional in 2.5.43.
Info below is from successive boots on the same system.
Two scsi HDs and one scsi cdrom.
Removing the cdrom changes nothing.

Kernel 2.4.19 has run buslogic scsi just fine:

SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 10 for device 00:08.0
scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.06J, I/O Address: 0xE800, IRQ Channel: 10/Level
scsi0:   PCI Bus: 0, Device: 8, Address: 0xED001000, Host Adapter SCSI ID: 7
scsi0:   Parity Checking: Disabled, Extended Translation: Disabled
scsi0:   Synchronous Negotiation: FFFFSFF#FFFFFFFF, Wide Negotiation: YYYYNYY#YY
YYYYYY
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Disabled
scsi0:   SCSI Bus Termination: High Enabled, SCAM: Disabled
scsi0: *** BusLogic BT-958 Initialized Successfully ***
scsi0 : BusLogic BT-958
  Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-5701TA  Rev: 0167
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0: Target 0: Queue Depth 28, Wide Synchronous at 20.0 MB/sec, offset 15
scsi0: Target 1: Queue Depth 28, Wide Synchronous at 20.0 MB/sec, offset 15
scsi0: Target 2: Queue Depth 3, Synchronous at 10.0 MB/sec, offset 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 4194303 512-byte hdwr sectors (2147 MB)
 sda: sda1 sda2
SCSI device sdb: 45322644 512-byte hdwr sectors (23205 MB)
 sdb: sdb1 sdb2 sdb3

-----------------------------



Kernel 2.5.43 and earlier produce this dmesg info
(edited  redundant lines):

SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 10 for device 00:08.0
scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.06J, I/O Address: 0xE800, IRQ Channel: 10/Level
scsi0:   PCI Bus: 0, Device: 8, Address: 0xED001000, Host Adapter SCSI ID: 7
scsi0:   Parity Checking: Disabled, Extended Translation: Disabled
scsi0:   Synchronous Negotiation: FFFFSFF#FFFFFFFF, Wide Negotiation: YYYYNYY#YY
YYYYYY
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Disabled
scsi0:   SCSI Bus Termination: High Enabled, SCAM: Disabled
scsi0: *** BusLogic BT-958 Initialized Successfully ***
scsi0 : BusLogic BT-958
  Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 1 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 1 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 2 lun 0
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 2 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 2 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 3 lun 0
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
.
.
.
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 15 lun 0
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 15 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 15 lun 0
st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdg at scsi0, channel 0, id 6, lun 0
Attached scsi disk sdh at scsi0, channel 0, id 8, lun 0
Attached scsi disk sdi at scsi0, channel 0, id 9, lun 0
Attached scsi disk sdj at scsi0, channel 0, id 10, lun 0
Attached scsi disk sdk at scsi0, channel 0, id 11, lun 0
Attached scsi disk sdl at scsi0, channel 0, id 12, lun 0
Attached scsi disk sdm at scsi0, channel 0, id 13, lun 0
Attached scsi disk sdn at scsi0, channel 0, id 14, lun 0
Attached scsi disk sdo at scsi0, channel 0, id 15, lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 0 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 0 lun 0
SCSI device sda: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 0 lun 0
sda : sector size 0 reported, assuming 512.
SCSI device sda: 1 512-byte hdwr sectors (0 MB)
.
.
.

scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 15 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 15 lun 0
SCSI device sdo: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 15 lun 0
sdo : sector size 0 reported, assuming 512.
SCSI device sdo: 1 512-byte hdwr sectors (0 MB)
Initializing USB Mass Storage driver...



-- 


