Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbTCZPeb>; Wed, 26 Mar 2003 10:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbTCZPeb>; Wed, 26 Mar 2003 10:34:31 -0500
Received: from ext-ch1gw-2.online-age.net ([216.34.191.36]:61890 "EHLO
	ext-ch1gw-2.online-age.net") by vger.kernel.org with ESMTP
	id <S261748AbTCZPeP> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:34:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Can not open '/dev/sg0' - attach failed.
Date: Wed, 26 Mar 2003 21:00:22 +0530
Message-ID: <62DD37292ED5464CBB142913FC65F8AB01E08771@BANMLVEM01.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can not open '/dev/sg0' - attach failed.
Thread-Index: AcLzrYumd2cRu+RgS1ylHmZavQ5nDg==
From: "Subramanian, M (MED)" <M.Subramanian@geind.ge.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Mar 2003 15:31:27.0072 (UTC) FILETIME=[C428AE00:01C2F3AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a program which uses cdrecord library to do attach, record, eject and load with CD-RW media.  Was trying to test this program for hours with cleanup (cdrecord blank=fast option), record, eject and load operations onto CD RW media. This program was running fine for almost 6 and half hours.  After that when it try to do the attach (open_scsi), it gave the following error (Can not open '/dev/sg0').  Couldn't figure out why it can happen like this.  Also noted that modprobe has put some error on to messages file.  Whether loading modules can give problem to this kind of operations with CD-RW media.  Anyone, can tell me what could be the problem.  Help is really appreciated.  

- Mani

cdrecord error
==============

scsibus: 1 target: 0 lun: 0
Cannot open '/dev/sg0'

uname -a

Linux archive_linux 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown

cdrecord -scanbus

Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) *
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) 'SONY    ' 'SMO-F551-SD     ' '1.04' Removable Optical Storage
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus1:
        1,0,0   100) 'HL-DT-ST' 'CD-RW GCE-8320B ' '1.04' Removable CD-ROM
        1,1,0   101) *
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *


cdrecord -scanbus

Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling

lsmod

Module                  Size  Used by
msr                     1456   0  (unused)
sg                     26688   0 
st                     26016   0  (autoclean) (unused)
nfs                    79008   3  (autoclean)
lockd                  52464   0  (autoclean) [nfs]
sunrpc                 61328   1  (autoclean) [nfs lockd]
agpgart                23392   5  (autoclean)
3c59x                  25344   1  (autoclean)
ipchains               38976   0  (unused)
ide-scsi                8352   0 
ide-cd                 26848   0 
cdrom                  27232   0  [ide-cd]
usb-uhci               20720   0  (unused)
usbcore                49664   1  [usb-uhci]
aic7xxx               136080   0 
sd_mod                 11680   0 
scsi_mod               95072   5  [sg st ide-scsi aic7xxx sd_mod]

File: /etc/modules.conf
=======================

alias scsi_hostadapter aic7xxx
alias eth0 3c59x
alias parport_lowlevel parport_pc
alias sound-slot-0 i810_audio
options i810_audio ftsodell=1
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1 || :
alias usb-controller usb-uhci
alias char-major-97 off

File: /var/log/messages
=======================

Mar 26 10:14:52 archive_linux login(pam_unix)[1621]: session opened for user chetanv by (uid=0)
Mar 26 10:14:52 archive_linux  -- chetanv[1621]: LOGIN ON pts/13 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 10:21:13 archive_linux su(pam_unix)[22692]: session opened for user root by chetanv(uid=1069)
Mar 26 10:22:13 archive_linux su(pam_unix)[22692]: session closed for user root
Mar 26 10:23:55 archive_linux login(pam_unix)[1621]: session closed for user chetanv
Mar 26 10:24:09 archive_linux login(pam_unix)[22812]: session opened for user chetanv by (uid=0)
Mar 26 10:24:09 archive_linux  -- chetanv[22812]: LOGIN ON pts/13 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 10:24:44 archive_linux login(pam_unix)[22812]: session closed for user chetanv
Mar 26 10:25:17 archive_linux login(pam_unix)[22838]: session opened for user chetanv by (uid=0)
Mar 26 10:25:17 archive_linux  -- chetanv[22838]: LOGIN ON pts/13 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 10:25:23 archive_linux su(pam_unix)[22856]: session opened for user root by chetanv(uid=1069)
Mar 26 11:14:21 archive_linux su(pam_unix)[1145]: session closed for user terra
Mar 26 11:16:47 archive_linux kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Mar 26 11:16:47 archive_linux kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Mar 26 11:16:47 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:16:47 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:16:47 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:16:47 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:16:47 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:16:47 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:21:50 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:21:50 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:21:50 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:21:50 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:21:50 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:21:50 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:25:24 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:25:24 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:25:24 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:25:24 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:25:24 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:25:24 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:29:00 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:29:00 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:29:00 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:29:00 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:29:00 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:29:00 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:32:36 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:32:36 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:32:36 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:32:36 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:32:36 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:32:36 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:36:13 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:36:13 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:36:13 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:36:13 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:36:13 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:36:13 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:40:56 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:40:56 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:40:56 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:40:56 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:40:56 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:40:56 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:44:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:44:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:44:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:44:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:44:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:44:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:48:07 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:48:07 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:48:07 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 11:48:07 archive_linux kernel: attempt to access beyond end of device
Mar 26 11:48:07 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 11:48:07 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:26:54 archive_linux su(pam_unix)[22856]: session closed for user root
Mar 26 12:28:48 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:28:48 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:28:48 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:28:48 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:28:48 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:28:48 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:32:24 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:32:24 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:32:24 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:32:24 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:32:24 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:32:24 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:35:58 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:35:58 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:35:58 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:35:58 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:35:58 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:35:58 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:39:34 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:39:34 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:39:34 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:39:34 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:39:34 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:39:34 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:43:40 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:43:40 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:43:40 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:43:40 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:43:40 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:43:40 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:47:16 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:47:16 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:47:16 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:47:16 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:47:16 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:50:56 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:50:56 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:50:56 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:50:56 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:50:56 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:50:56 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:54:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:54:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:54:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 12:54:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 12:54:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 12:54:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:33:01 archive_linux login(pam_unix)[23919]: session opened for user anilm by (uid=0)
Mar 26 13:33:01 archive_linux  -- anilm[23919]: LOGIN ON pts/13 BY anilm FROM 3.70.203.172
Mar 26 13:34:54 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:34:54 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:34:54 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:34:54 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:34:54 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:34:54 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:38:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:38:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:38:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:38:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:38:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:38:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:40:31 archive_linux login(pam_unix)[24009]: session opened for user terra by (uid=0)
Mar 26 13:40:31 archive_linux  -- terra[24009]: LOGIN ON pts/15 BY terra FROM compaq8.gsoi.med.ge.com
Mar 26 13:42:07 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:42:07 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:42:07 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:42:07 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:42:07 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:42:07 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:45:42 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:45:42 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:45:42 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:45:42 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:45:42 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:45:42 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:49:18 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:49:18 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:49:18 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:49:18 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:49:18 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:49:18 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:52:53 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:52:53 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:52:53 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:52:53 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:52:53 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:56:33 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:56:33 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:56:33 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 13:56:33 archive_linux kernel: attempt to access beyond end of device
Mar 26 13:56:33 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 13:56:33 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:00:07 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:00:07 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:00:07 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:00:07 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:00:07 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:00:07 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:10:34 archive_linux login(pam_unix)[24140]: session opened for user chetanv by (uid=0)
Mar 26 14:10:34 archive_linux  -- chetanv[24140]: LOGIN ON pts/15 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 14:12:55 archive_linux login(pam_unix)[24162]: session opened for user chetanv by (uid=0)
Mar 26 14:12:55 archive_linux  -- chetanv[24162]: LOGIN ON pts/15 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 14:14:23 archive_linux login(pam_unix)[24199]: session opened for user chetanv by (uid=0)
Mar 26 14:14:23 archive_linux  -- chetanv[24199]: LOGIN ON pts/15 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 14:14:32 archive_linux login(pam_unix)[24199]: session closed for user chetanv
Mar 26 14:40:37 archive_linux kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Mar 26 14:40:37 archive_linux kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Mar 26 14:40:37 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:40:37 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:40:37 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:40:37 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:40:37 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:40:37 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:44:13 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:44:13 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:44:13 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:44:13 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:44:13 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:44:13 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:48:26 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:48:26 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:48:26 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:48:26 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:48:26 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:48:26 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:52:02 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:52:02 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:52:02 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:52:02 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:52:02 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:52:02 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:55:43 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:55:43 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:55:43 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:55:43 archive_linux kernel: attempt to access beyond end of device
Mar 26 14:55:43 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 14:55:43 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 14:55:43 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:00:05 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:00:05 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:00:05 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:00:05 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:00:05 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:00:05 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:04:37 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:04:37 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:04:37 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:04:37 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:04:37 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:04:37 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:08:15 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:08:15 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:08:15 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:08:15 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:08:15 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:08:15 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:48:34 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:48:34 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:48:34 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:48:34 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:48:34 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:48:34 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:52:12 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:52:12 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:52:12 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:52:12 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:52:12 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:52:12 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:55:47 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:55:47 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:55:47 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:55:47 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:55:47 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:55:47 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:59:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:59:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:59:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 15:59:31 archive_linux kernel: attempt to access beyond end of device
Mar 26 15:59:31 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 15:59:31 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:03:06 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:03:06 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:03:06 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:03:06 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:03:06 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:03:06 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:06:40 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:06:40 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:06:40 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:06:40 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:06:40 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:06:40 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:10:16 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:10:16 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:10:16 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:10:16 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:10:16 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:10:16 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:13:51 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:13:51 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:13:51 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:13:51 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:13:51 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:13:51 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:32:55 archive_linux su(pam_unix)[5199]: session closed for user root
Mar 26 16:54:12 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:54:12 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:54:12 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:54:12 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:54:12 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:54:12 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:57:47 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:57:47 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:57:47 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 16:57:47 archive_linux kernel: attempt to access beyond end of device
Mar 26 16:57:47 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 16:57:47 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:01:22 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:01:22 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:01:22 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:01:22 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:01:22 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:01:22 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:04:58 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:04:58 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:04:58 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:04:59 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:04:59 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:04:59 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:08:36 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:08:36 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:08:36 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:08:36 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:08:36 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:08:36 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:12:12 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:12:12 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:12:12 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:12:12 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:12:12 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:12:12 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:15:53 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:15:53 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:15:53 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:15:53 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:15:53 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:15:53 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:19:27 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:19:27 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:19:27 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:19:27 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:19:27 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:19:27 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:59:54 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:59:54 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:59:54 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 17:59:54 archive_linux kernel: attempt to access beyond end of device
Mar 26 17:59:54 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 17:59:54 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:04:09 archive_linux kernel: attempt to access beyond end of device
Mar 26 18:04:09 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 18:04:09 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:04:09 archive_linux kernel: attempt to access beyond end of device
Mar 26 18:04:09 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 18:04:09 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:08:27 archive_linux kernel: attempt to access beyond end of device
Mar 26 18:08:27 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 18:08:27 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:08:27 archive_linux kernel: attempt to access beyond end of device
Mar 26 18:08:27 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 18:08:27 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:12:38 archive_linux kernel: attempt to access beyond end of device
Mar 26 18:12:38 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 18:12:38 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:12:38 archive_linux kernel: attempt to access beyond end of device
Mar 26 18:12:38 archive_linux kernel: 0b:00: rw=0, want=34, limit=2
Mar 26 18:12:38 archive_linux kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Mar 26 18:33:11 archive_linux login(pam_unix)[26191]: session opened for user chetanv by (uid=0)
Mar 26 18:33:11 archive_linux  -- chetanv[26191]: LOGIN ON pts/15 BY chetanv FROM opal.gsoi.med.ge.com
Mar 26 18:33:17 archive_linux su(pam_unix)[26207]: session opened for user root by chetanv(uid=1069)
Mar 26 18:40:14 archive_linux modprobe: modprobe: Can't locate module char-major-97
Mar 26 18:40:14 archive_linux last message repeated 3 times
Mar 26 18:41:24 archive_linux login(pam_unix)[26284]: session opened for user gvei by (uid=0)
Mar 26 18:41:24 archive_linux  -- gvei[26284]: LOGIN ON pts/17 BY gvei FROM 3.249.249.196
Mar 26 18:48:13 archive_linux login(pam_unix)[26284]: session closed for user gvei
Mar 26 18:52:32 archive_linux modprobe: modprobe: Nothing to load ??? Specify at least a module or a wildcard like \*
Mar 26 19:04:22 archive_linux modprobe: modprobe: Can't locate module char-major-97

