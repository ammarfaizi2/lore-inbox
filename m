Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317154AbSFFU5a>; Thu, 6 Jun 2002 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSFFU53>; Thu, 6 Jun 2002 16:57:29 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:59566
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S317154AbSFFU51> convert rfc822-to-8bit; Thu, 6 Jun 2002 16:57:27 -0400
Message-ID: <20020606205727.18760.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: linux-kernel@vger.kernel.org
Subject: Devfs strangeness in 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 06 Jun 2002 23:57:27 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
just installed a fresh Mandrake 8.2 here and am
seeing devfs behaving very strangely.
Here is some out put that shows the problems:

backup:dev 1004 % ls -ld sg*
drwxr-xr-x    1 root     root            0 Jun  7  2002 sg
lr-xr-xr-x    1 root     root           36 Jun  7  2002 sg0 -> 
scsi/host0/bus0/target0/lun0/generic
lr-xr-xr-x    1 root     root           36 Jun  7  2002 sg1 -> 
scsi/host1/bus0/target1/lun0/generic
lr-xr-xr-x    1 root     root           36 Jun  7  2002 sg2 -> 
scsi/host1/bus0/target2/lun0/generic
lr-xr-xr-x    1 root     root           36 Jun  7  2002 sg3 -> 
scsi/host1/bus0/target3/lun0/generic
lr-xr-xr-x    1 root     root           36 Jun  6 23:46 sg4 -> 
scsi/host2/bus0/target2/lun0/generic
backup:dev 1005 % cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: ADIC     Model: VLS DLT          Rev: 0235
  Type:   Medium Changer                   ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: Quantum  Model: DLT4000          Rev: CD3C
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: WangDAT  Model: Model 3400DX     Rev: 1.4a
  Type:   Sequential-Access                ANSI SCSI revision: 02
backup:dev 1006 % ls -l /dev/st?
lr-xr-xr-x    1 root     root           31 Jun  7  2002 /dev/st0 -> 
scsi/host1/bus0/target2/lun0/mt
lr-xr-xr-x    1 root     root           31 Jun  7  2002 /dev/st1 -> 
scsi/host1/bus0/target3/lun0/mt

The problems are tha the sg? links doesn't correspond to the real
devices shown by /proc/scsi/scsi (Which matches the real situation)
sg0 matches the first disk, OK
sg1 matches the Medium changer, OK
sg2 matches nothing...... There is no target 2 on host1 !!!
sg3 matches the DLT tape drive
sg4 matches the DAT tape drive

The other problem is the st? links.
st0 is linked out into nothing ...

Seems like 3 host adapters is too much for devfs......
Do I need an upgrade ?

BRGDS

-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


