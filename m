Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbRCQCJV>; Fri, 16 Mar 2001 21:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRCQCJM>; Fri, 16 Mar 2001 21:09:12 -0500
Received: from ip165-137.fli-ykh.psinet.ne.jp ([210.129.165.137]:24515 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131158AbRCQCJA>;
	Fri, 16 Mar 2001 21:09:00 -0500
Message-ID: <3AB2C709.E8C3C5F4@yk.rim.or.jp>
Date: Sat, 17 Mar 2001 11:08:09 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com> <3AB030F6.246C6F23@redhat.com> <3AB24511.EA8BD2A2@yk.rim.or.jp> <3AB26A9A.9F1B3FAE@redhat.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> It would still be helpful because this problem has to be fixed before 2.5.
> The only question is whether to fix it with a simple patch such as I just
> submitted, or a more complex patch that uses REPORT LUNs.  Part of that answer
> is how my simple patch works on your device.

Hi, I applied the patch, and found no ill-effect.

The multi-lun devices I have only supports non-hard disk drive types.
On dc390 adaptor(tmscsim):
 target:5  Two (2) Lun device. Matsushita (panasonic)
  CD/PD combo.
 target:6  Seven(7) lun device.
  Nakamichi MBR Cd changer.

These devices seem to report all LUN's as available even
if the media is not in the drive.

The driver, tmscsim.o,  is compiled as module and is inserted during boot
(using Debian's /etc/module mechanism).

Eg.

Device config.

ishikawa@duron$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: HITACHI  Model: DK318H-91WS      Rev: B2BQ
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: MATSHITA Model: PD-1 LF-1000     Rev: A111
  Type:   Optical Device                   ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 01
  Vendor: MATSHITA Model: PD-1 LF-1000     Rev: A111
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 01
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 02
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 03
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 04
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 05
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 06
  Vendor: NRC      Model: MBR-7            Rev: 110
  Type:   CD-ROM                           ANSI SCSI revision: 02
ishikawa@duron$


----------------------------------------
>From dmesg output: I deleted devfs debug messages from below.
----------------------------------------

Linux version 2.4.2 (root@duron) (gcc version 2.95.2 20000220 (Debian GNU/Linux)
) #35 Sat Mar 17 10:35:57 JST 2001
 ...

Kernel command line: devfs=mount,dmod,dreg,dilookup root=/dev/sda6 ro
scsihosts= sym53c8xx:tmscsim BOOT_IMAGE=242-doug.pat Initializing
CPU#0
 ...
 ...
DC390: 1 adapters found
scsi1 : Tekram DC390/AM53C974 V2.0f 2000-12-20
  Vendor: MATSHITA  Model: PD-1 LF-1000      Rev: A111
  Type:   Optical Device                     ANSI SCSI revision: 02
Detected scsi removable disk sdb at scsi1, channel 0, id 5, lun 0
  Vendor: MATSHITA  Model: PD-1 LF-1000      Rev: A111
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NRC       Model: MBR-7             Rev: 110
  Type:   CD-ROM                             ANSI SCSI revision: 02
sg_init called: 1


 ...
 ... The following is reported since the
 ... target : 5 , lun : 0 is an optical PD drive and
 ... it seemed to be treated as if it were a removable hard disk.
 ... Since no media was in the tray when the system booted
 ... the error is repoted.
 ... (Note that /dev/sda is Hitachi hard disk.)

sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 28
sdb : extended sense code = 2
sdb : block size assumed to be 512 bytes, disk size 1GB.
 /dev/scsi/host1/bus0/target5/lun0: I/O error: dev 08:10, sector 0
 unable to read partition table

 ...
 ... I ran "modprobe sr_mod"
 ...

init_sr: pid=425 [comm=modprobe] ppid=424 [comm=bash]
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 5, lun 1
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 6, lun 0
Detected scsi CD-ROM sr2 at scsi1, channel 0, id 6, lun 1
Detected scsi CD-ROM sr3 at scsi1, channel 0, id 6, lun 2
Detected scsi CD-ROM sr4 at scsi1, channel 0, id 6, lun 3
Detected scsi CD-ROM sr5 at scsi1, channel 0, id 6, lun 4
Detected scsi CD-ROM sr6 at scsi1, channel 0, id 6, lun 5
Detected scsi CD-ROM sr7 at scsi1, channel 0, id 6, lun 6
sr_init called: sr_template.dev_noticed = 8
sr_init going to register if not yet.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sr1: scsi-1 drive
sr2: scsi-1 drive
sr3: scsi-1 drive
sr4: scsi-1 drive
sr5: scsi-1 drive
sr6: scsi-1 drive
sr7: scsi-1 drive

PS: Oh, wait a second. Doesn't ANSI revision 02 mean SCSI-2 drive, at least?
Why did the CD-ROM driver report scsi-1 drives then?
This has nothing to do with the scsi_scan problem, I think, though.

[end of memo]


