Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRCQDia>; Fri, 16 Mar 2001 22:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131538AbRCQDiV>; Fri, 16 Mar 2001 22:38:21 -0500
Received: from smtp4vepub.gte.net ([206.46.170.25]:38740 "EHLO
	smtp4ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S131531AbRCQDiJ>; Fri, 16 Mar 2001 22:38:09 -0500
Message-ID: <3AB2DBF2.D5F23507@neuronet.pitt.edu>
Date: Fri, 16 Mar 2001 22:37:22 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <200103170012.f2H0C8s01133@eng2.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:
> 
> If your testing Doug's patch, it might be a good idea to run with/without
> your adapter built as a module, as the kernel is inconsistent in its setting
> of "online" in scsi.c: it sets online TRUE after an attach in
> scsi_register_device_module(), but leaves online as is after an
> attach in scsi_register_host().
> 
> So, if the scan_scsis set online FALSE, it sometimes is set back to TRUE;
> otherwise, I don't think any other code will set online to TRUE (once it
> is set to FALSE after its scanned, no one can even open the device, not even sg).
> 
> The online = TRUE should probably be removed from scsi_register_device_module(),
> as disks with peripheral qualifier 1 (like Doug's the Clariion storage)
> ususally complain when sent a READ CAPACITY. I got such errors when running with
> a Clariion DASS (DGC RAID/DISK, scsi attached disk array).

In my first post everything but the aic7xxx_old driver was builtin. With
it built into the kernel the output is as follows:

SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7895 Ultra SCSI host adapter> found at PCI 0/14/1
(scsi0) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 383 instructions downloaded
(scsi1) <Adaptec AIC-7895 Ultra SCSI host adapter> found at PCI 0/14/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 383 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7895 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7895 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: SEAGATE   Model: ST39173LW         Rev: 6246
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi1:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST15150N          Rev: 4611
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi1:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: TEAC      Model: CD-R56S4          Rev: 1.0P
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 2, lun 0
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 8388315 512-byte hdwr sectors (4295 MB)
 sdb: sdb1
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 4, lun 1
Detected scsi CD-ROM sr2 at scsi1, channel 0, id 4, lun 2
Detected scsi CD-ROM sr3 at scsi1, channel 0, id 4, lun 3
Detected scsi CD-ROM sr4 at scsi1, channel 0, id 4, lun 4
Detected scsi CD-ROM sr5 at scsi1, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 16x/16x xa/form2 changer
sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
sr1: scsi3-mmc drive: 16x/16x xa/form2 changer
sr1: CDROM (ioctl) reports ILLEGAL REQUEST.
sr2: scsi3-mmc drive: 16x/16x xa/form2 changer
sr2: CDROM (ioctl) reports ILLEGAL REQUEST.
sr3: scsi3-mmc drive: 16x/16x xa/form2 changer
sr3: CDROM (ioctl) reports ILLEGAL REQUEST.
sr4: scsi3-mmc drive: 16x/16x xa/form2 changer
sr4: CDROM (ioctl) reports ILLEGAL REQUEST.
sr5: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray

-- 
     Rafael

PS. By the way, it's not necessary to cc me.
