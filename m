Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271336AbRINWKC>; Fri, 14 Sep 2001 18:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271108AbRINWJx>; Fri, 14 Sep 2001 18:09:53 -0400
Received: from forge.redmondlinux.org ([209.81.49.42]:22996 "EHLO
	forge.redmondlinux.org") by vger.kernel.org with ESMTP
	id <S271336AbRINWJc>; Fri, 14 Sep 2001 18:09:32 -0400
Message-ID: <3BA27FAD.60007@cheek.com>
Date: Fri, 14 Sep 2001 15:07:41 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2 IDE cd-roms + ide-scsi = 4 scsi cdroms ???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i added a second ide cdrom to this system and now notice that i have 
four scsi cdroms show up.  really weird.  this was on 2.4.7-ac10 and 
repros on 2.4.9-ac10.

when i had one cdrom (/dev/hdc) i had just one scsi cdrom after loading 
ide-scsi (/dev/sr0).

relevant /var/log/messages portion:

Sep 14 08:58:07 sanfrancisco kernel: SCSI subsystem driver Revision: 1.00
Sep 14 08:58:07 sanfrancisco kernel: scsi0 : SCSI host adapter emulation 
for IDE ATAPI | LST System Analysis            Friddevices
Sep 14 08:58:07 sanfrancisco kernel:   Vendor: LITE-ON   Model: LTR-12101B
  Rev: LS3G
Sep 14 08:58:07 sanfrancisco kernel:   Type:   CD-ROM
  ANSI SCSI revision: 02
Sep 14 08:58:07 sanfrancisco kernel:   Vendor: LITE-ON   Model: LTR-12101B
  Rev: LS3G
Sep 14 08:58:07 sanfrancisco kernel:   Type:   CD-ROM
  ANSI SCSI revision: 02
Sep 14 08:58:07 sanfrancisco kernel:   Vendor: COMPAQ    Model: CRD-8322B
  Rev: 1.06
Sep 14 08:58:07 sanfrancisco kernel:   Type:   CD-ROM
  ANSI SCSI revision: 02
Sep 14 08:58:07 sanfrancisco kernel:   Vendor: COMPAQ    Model: CRD-8322B
  Rev: 1.06
Sep 14 08:58:07 sanfrancisco kernel:   Type:   CD-ROM
  ANSI SCSI revision: 02
Sep 14 08:58:07 sanfrancisco kernel: Attached scsi CD-ROM sr0 at scsi0, 
channel 0, id 0, lun 0
Sep 14 08:58:07 sanfrancisco kernel: Attached scsi CD-ROM sr1 at scsi0, 
channel 0, id 0, lun 1
Sep 14 08:58:07 sanfrancisco kernel: Attached scsi CD-ROM sr2 at scsi0, 
channel 0, id 1, lun 0
Sep 14 08:58:07 sanfrancisco kernel: Attached scsi CD-ROM sr3 at scsi0, 
channel 0, id 1, lun 1
Sep 14 08:58:07 sanfrancisco kernel: sr0: scsi3-mmc drive: 20x/20x 
writer cd/rw xa/form2 cdda tray
Sep 14 08:58:07 sanfrancisco kernel: Uniform CD-ROM driver Revision: 3.12
Sep 14 08:58:07 sanfrancisco kernel: sr1: scsi3-mmc drive: 20x/20x 
writer cd/rw xa/form2 cdda tray
Sep 14 08:58:07 sanfrancisco kernel: sr2: scsi3-mmc drive: 32x/32x cd/rw 
xa/form2 cdda tray
Sep 14 08:58:07 sanfrancisco kernel: sr3: scsi3-mmc drive: 32x/32x cd/rw 
xa/form2 cdda tray


# cat /proc/sys/dev/cdrom/info
CD-ROM information, Id: cdrom.c 3.12 2000/10/18

drive name:             sr3     sr2     sr1     sr0
drive speed:            32      32      20      20
drive # of slots:       1       1       1       1
Can close tray:         1       1       1       1
Can open tray:          1       1       1       1
Can lock tray:          1       1       1       1
Can change speed:       1       1       1       1
Can select disk:        0       0       0       0
Can read multisession:  1       1       1       1
Can read MCN:           1       1       1       1
Reports media changed:  1       1       1       1
Can play audio:         1       1       1       1
Can write CD-R:         0       0       1       1
Can write CD-RW:        0       0       1       1
Can read DVD:           0       0       0       0
Can write DVD-R:        0       0       0       0
Can write DVD-RAM:      0       0       0       0


# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-12101B       Rev: LS3G
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 01
  Vendor: LITE-ON  Model: LTR-12101B       Rev: LS3G
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: COMPAQ   Model: CRD-8322B        Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 01
  Vendor: COMPAQ   Model: CRD-8322B        Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02



# lsmod
Module                  Size  Used by
nfs                    73120   1  (autoclean)
lockd                  48352   1  (autoclean) [nfs]
sunrpc                 64416   1  (autoclean) [nfs lockd]
ospm_system             2192   0  (unused)
ospm_busmgr            11392   0  [ospm_system]
af_packet               9200   1  (autoclean)
nls_iso8859-1           2832   1  (autoclean)
nls_cp437               4352   1  (autoclean)
vfat                    9264   1  (autoclean)
fat                    29760   0  (autoclean) [vfat]
mga                    97952   0  (unused)
agpgart                25920   1
parport_pc             23504   0
parport                24512   0  [parport_pc]
es1371                 29952   0
gameport                1520   0  [es1371]
ac97_codec              9072   0  [es1371]
3c59x                  25184   1
usb-uhci               21376   0  (unused)
usbcore                49440   1  [usb-uhci]
sound                  54912   0  (unused)
soundcore               3856   6  [es1371 sound]
ide-scsi                7376   0
sr_mod                 12416   0
scsi_mod               50208   2  [ide-scsi sr_mod]
cdrom                  27392   0  [sr_mod]
ide-floppy             10992   0


thanks!

joe

