Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317452AbSFHU52>; Sat, 8 Jun 2002 16:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317453AbSFHU51>; Sat, 8 Jun 2002 16:57:27 -0400
Received: from thoth.sbs.de ([192.35.17.2]:24469 "EHLO thoth.sbs.de")
	by vger.kernel.org with ESMTP id <S317452AbSFHU51>;
	Sat, 8 Jun 2002 16:57:27 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre9, Iomega Jaz, PPA - endless loop in SCSI recovery thread
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5-3mdk 
Date: 09 Jun 2002 00:55:23 +0400
Message-Id: <1023569729.13619.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like a media went corrupted so one expects some reasonable
error message. What happens is I get endless loop in SCSI error recovery
thread. The only way to clear up situation is to reboot and even then it
hangs on umount so I have to do SysRq-B. Please, what additional
information can be provided; I hope I can keep this media intact for
some time for testing :-)

the kernel is 2.4.18-18mdk based on 2.4.1-pre9.

I am not on lkml so please Cc me. Thank you.

-andrej


{pts/0}% cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: iomega   Model: jaz 2GB          Rev: E.17
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: PHILIPS  Model: CDD3610 CD-R/RW  Rev: 3.09
  Type:   CD-ROM                           ANSI SCSI revision: 02
{pts/0}% cat /proc/scsi/ppa/0
Version : 2.07 (for Linux 2.4.x)
Parport : parport0
Mode    : EPP 32 bit
{pts/0}% uname -a
Linux localhost.localdomain 2.4.18-18mdkcustom #5 Sat Jun 8 23:25:23 MSD
2002 i686 unknown

SCSI log:

Jun  8 20:49:59 localhost kernel: Activating command for device 4 (1)
Jun  8 20:49:59 localhost kernel: Doing sd request, dev = 0x804, block = 944344
Jun  8 20:49:59 localhost kernel: sda : real dev = /dev/0, block = 944376
Jun  8 20:49:59 localhost kernel: sda : reading 248/248 512 byte blocks.
Jun  8 20:49:59 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12892)
Jun  8 20:49:59 localhost kernel: scsi_dispatch_cmnd (host = 0, channel = 0, target = 4, command = cd8b1e58, buffer = c009e000, 
Jun  8 20:49:59 localhost kernel: bufflen = 126976, done = d2813b7a)
Jun  8 20:49:59 localhost kernel: queuecommand : routine at d2a2f1e0
Jun  8 20:49:59 localhost kernel: leaving scsi_dispatch_cmnd()
Jun  8 20:50:00 localhost kernel: Clearing timer for command cd8b1e00 1
Jun  8 20:50:00 localhost kernel: Command failed cd8b1e00 2 active=1 busy=1 failed=0
Jun  8 20:50:00 localhost kernel: bh08:04: old sense key None
Jun  8 20:50:00 localhost kernel: Non-extended sense class 0 code 0x0
Jun  8 20:50:00 localhost kernel: Waking error handler thread (-1)
Jun  8 20:50:00 localhost kernel: Error handler waking up
Jun  8 20:50:00 localhost kernel: scsi_unjam_host: Checking to see if we need to request sense
Jun  8 20:50:00 localhost kernel: scsi_unjam_host: Requesting sense for 4
Jun  8 20:50:00 localhost kernel: Adding timer for command cd8b1e00 at 1000 (d2a12a28)
Jun  8 20:50:00 localhost kernel: In eh_done cd8b1e00 result:0
Jun  8 20:50:00 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:00 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
Jun  8 20:50:00 localhost kernel: Sense requested for cd8b1e00 - result 2
Jun  8 20:50:00 localhost kernel: Info fld=0xe6960, Current bh08:04: sense key Medium Error
Jun  8 20:50:00 localhost kernel: Additional sense indicates Address mark not found for data field
Jun  8 20:50:00 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:03 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:03 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:03 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:03 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:06 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:06 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:06 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:06 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:09 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:09 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:09 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:09 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:12 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:12 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:12 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:12 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:15 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:15 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:15 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:15 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:17 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:17 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:17 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:17 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:20 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:20 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:20 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:20 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:23 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:23 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:23 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  8 20:50:23 localhost kernel: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
Jun  8 20:50:26 localhost kernel: In eh_done cd8b1e00 result:2
Jun  8 20:50:26 localhost kernel: send_eh_cmnd: cd8b1e00 eh_state:2002
Jun  8 20:50:26 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
