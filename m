Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRHGUaA>; Tue, 7 Aug 2001 16:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbRHGU3v>; Tue, 7 Aug 2001 16:29:51 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:64016 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S268079AbRHGU3c>; Tue, 7 Aug 2001 16:29:32 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC557@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: linux-kernel@vger.kernel.org
Subject: A bug in the new aic7xxx.o driver in kernel 2.4.7
Date: Tue, 7 Aug 2001 16:21:09 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It fails to detected all the external scsi devices, and communicate with
devices 
when there is a gap between lun numbers. If there is a gap, it omits devices
from
the absent lun number to the next 2 power # lun number, and I/O error after
that.
For example, if device /dev/scsi/host1/bus0/target1/lun7 is taken out from
the 
system, the aic7xxx driver fails to detect disks from
/dev/scsi/host1/bus0/target1/lun8
to /dev/scsi/host1/bus0/target1/lun31, in stead jumps to ..../lun32, and
fails
to talk to the device ever since.

Old aic7xxx driver is OK. 

 
/var/log/messages, using aic7xxx_old.o
...
Aug  7 04:01:04 cel1125 kernel: Partition check:
Aug  7 04:01:04 cel1125 kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 <
p5 p6 p7 p8 p9 >
Aug  7 04:01:04 cel1125 kernel: SCSI device sdb: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:04 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun0: unknown
partition table
Aug  7 04:01:04 cel1125 kernel: SCSI device sdc: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun1: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sdd: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun2: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sde: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun3: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sdf: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun4: unknown
partition table
Aug  7 04:01:05 cel1125 atd: atd startup succeeded
Aug  7 04:01:05 cel1125 kernel: SCSI device sdg: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun5: p1
Aug  7 04:01:05 cel1125 kernel: SCSI device sdh: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun6: p1
Aug  7 04:01:05 cel1125 kernel: SCSI device sdi: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun8: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sdj: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun9: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sdk: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun10: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sdl: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 04:01:05 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun11: unknown
partition table
Aug  7 04:01:05 cel1125 kernel: SCSI device sdm: 70709760 512-byte hdwr
sectors (36203 MB)       
.....

/var/log/messages, using aic7xxx.o
...
Aug  7 00:28:21 cel1125 kernel: Partition check:
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 <
p5 p6 p7 p8 p9 >
Aug  7 00:28:21 cel1125 kernel: SCSI device sdb: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:19 cel1125 nfslock: rpc.lockd startup failed
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun0: unknown
partition table
Aug  7 00:28:21 cel1125 kernel: SCSI device sdc: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun1: unknown
partition table
Aug  7 00:28:21 cel1125 kernel: SCSI device sdd: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun2: unknown
partition table
Aug  7 00:28:21 cel1125 kernel: SCSI device sde: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun3: unknown
partition table
Aug  7 00:28:21 cel1125 kernel: SCSI device sdf: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun4: unknown
partition table
Aug  7 00:28:21 cel1125 kernel: SCSI device sdg: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun5: p1
Aug  7 00:28:21 cel1125 kernel: SCSI device sdh: 70709760 512-byte hdwr
sectors (36203 MB)
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun6: p1
Aug  7 00:28:21 cel1125 kernel: sdi : READ CAPACITY failed.
Aug  7 00:28:21 cel1125 kernel: sdi : status = 1, message = 00, host = 0,
driver = 08
Aug  7 00:28:21 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:21 cel1125 kernel: Additional sense indicates Logical unit not
supported             
Aug  7 00:28:21 cel1125 kernel: sdi : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun32: I/O
error: dev 08:80, sector 0
Aug  7 00:28:21 cel1125 kernel:  unable to read partition table
Aug  7 00:28:21 cel1125 kernel: sdj : READ CAPACITY failed.
Aug  7 00:28:21 cel1125 kernel: sdj : status = 1, message = 00, host = 0,
driver = 08
Aug  7 00:28:21 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:21 cel1125 kernel: Additional sense indicates Logical unit not
supported
Aug  7 00:28:21 cel1125 kernel: sdj : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun33: I/O
error: dev 08:90, sector 0
Aug  7 00:28:21 cel1125 kernel:  unable to read partition table
Aug  7 00:28:21 cel1125 kernel: sdk : READ CAPACITY failed.
Aug  7 00:28:21 cel1125 kernel: sdk : status = 1, message = 00, host = 0,
driver = 08
Aug  7 00:28:21 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:21 cel1125 kernel: Additional sense indicates Logical unit not
supported
Aug  7 00:28:21 cel1125 kernel: sdk : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun34: I/O
error: dev 08:a0, sector 0
Aug  7 00:28:21 cel1125 kernel:  unable to read partition table
Aug  7 00:28:21 cel1125 kernel: sdl : READ CAPACITY failed.
Aug  7 00:28:21 cel1125 kernel: sdl : status = 1, message = 00, host = 0,
driver = 08
Aug  7 00:28:21 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:21 cel1125 kernel: Additional sense indicates Logical unit not
supported
Aug  7 00:28:21 cel1125 kernel: sdl : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:21 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun35: I/O
error: dev 08:b0, sector 0
Aug  7 00:28:21 cel1125 kernel:  unable to read partition table
Aug  7 00:28:21 cel1125 kernel: sdm : READ CAPACITY failed.
Aug  7 00:28:21 cel1125 kernel: sdm : status = 1, message = 00, host = 0,
driver = 08         
Aug  7 00:28:21 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:21 cel1125 kernel: Additional sense indicates Logical unit not
supported
Aug  7 00:28:21 cel1125 kernel: sdm : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:22 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun36: I/O
error: dev 08:c0, sector 0
Aug  7 00:28:22 cel1125 kernel:  unable to read partition table
Aug  7 00:28:22 cel1125 kernel: sdn : READ CAPACITY failed.
Aug  7 00:28:22 cel1125 kernel: sdn : status = 1, message = 00, host = 0,
driver = 08
Aug  7 00:28:22 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:22 cel1125 kernel: Additional sense indicates Logical unit not
supported
Aug  7 00:28:22 cel1125 kernel: sdn : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:22 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun37: I/O
error: dev 08:d0, sector 0
Aug  7 00:28:22 cel1125 kernel:  unable to read partition table
Aug  7 00:28:22 cel1125 kernel: sdo : READ CAPACITY failed.
Aug  7 00:28:22 cel1125 kernel: sdo : status = 1, message = 00, host = 0,
driver = 08
Aug  7 00:28:22 cel1125 kernel: Current sd00:00: sense key Illegal Request
Aug  7 00:28:22 cel1125 kernel: Additional sense indicates Logical unit not
supported
Aug  7 00:28:22 cel1125 kernel: sdo : block size assumed to be 512 bytes,
disk size 1GB.
Aug  7 00:28:22 cel1125 kernel:  /dev/scsi/host1/bus0/target1/lun38: I/O
error: dev 08:e0, sector 0
Aug  7 00:28:22 cel1125 kernel:  unable to read partition table            
