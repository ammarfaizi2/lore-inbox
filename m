Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286248AbRLTN0y>; Thu, 20 Dec 2001 08:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286252AbRLTN0p>; Thu, 20 Dec 2001 08:26:45 -0500
Received: from relay.planetinternet.be ([194.119.232.24]:58885 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S286248AbRLTN0d>; Thu, 20 Dec 2001 08:26:33 -0500
Message-Id: <200112201326.fBKDQQm28645@relay.planetinternet.be>
Content-Type: text/plain; charset=US-ASCII
From: Michele Gius <mgius@pi.be>
Reply-To: mgius@pi.be
Subject: CD-ROM read problem introdruced in 2.4.x and 2.5.x ?
Date: Thu, 20 Dec 2001 14:26:10 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried this on 2 different systems:

1. Pentium 2/ Intel 440LX / SCSI System with 
	Plextor PX32TS and Yamaha CDR400t on aic7880
2. Athlon 1500XP / Via KT266A (vt8233) / IDE System  with 
	Plextor 24/10/40A (DMA off :-( ) and LiteOn DVD-ROM LTD163

A CD-R with mp3 songs (Maxell 74 min. 6x blue writing side):
It reads and plays well on all 4 drives of the 2 machines under kernel 2.2.18 
and 2.2.19 as well as under Windows.

It cannot be read and played under:
2.4.0		(both machines)
2.4.10		(both machines)
2.4.15		(ide, scsi not tested)
2.4.16		(both machines)
2.5.1-pre9	(ide, scsi not tested)

The errors occur always in the same regions of the disk with slight 
differences between drives so it probably has errors but they seem to be 
handled less tolerantly.

Related?: While copying from a CD under the 2.4 kernels the system load on 
the IDE machine goes up to 75 percent even for the LiteOn drive with DMA on, 
while on 2.2.19 it never exceeds 10% even for the Plextor with DMA off and it 
is slightly faster. 
 

---------------------------
Errors from IDE machine (hdb is LiteOn, hdc is Plextor with ide-scsi):

: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
: hdb: drive_cmd: error=0x04

: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x03 00 00 00 40 00
: Info fld=0x4d0, Current sd0b:00: sns = f0  3
: ASC= 6 ASCQ= 0
: Raw sense data:0xf0 0x00 0x03 0x00 0x00 0x04 0xd0 0x0a 0x00 0x00 0x
:  I/O error: dev 0b:00, sector 4928

-------------------

Errors from SCSI machine:

: scsi0: ERROR on channel 0, id 4, lun 0, CDB: 0x28 00 00 00 04 d5 00 00 01 00
: Info fld=0x4d5 (nonstd), Current sd0b:01: sns = 70  3
^^^^^^^^^^^^^^^^^^^^^^ Is this a hint ?               
: ASC= 6 ASCQ= 0
: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x04 0xd5 0x0a 0x00 0x00 0x00 0x00  
  0x06 0x00 0x00 0x00 0x00 0x00
:  I/O error: dev 0b:01, sector 4948

---------------------

CD-Info from debug mode:

cdrom: entering cdrom_count_tracks
cdrom: track 1: format=2, ctrl=4
cdrom: track 2: format=2, ctrl=5
cdrom: disc has 2 tracks: 0=audio 2=data 0=Cd-I 0=XA
...
cdrom: entering CDROMMULTISESSION
cdrom: CDROMMULTISESSION successful
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
--------------------


Sorry for this long post. I know it is quite general but if there is any 
further useful information I can supply.

Kind regards
Michele Gius
