Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280469AbRJaULU>; Wed, 31 Oct 2001 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280472AbRJaULJ>; Wed, 31 Oct 2001 15:11:09 -0500
Received: from cliff.mcs.anl.gov ([140.221.9.17]:20611 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S280470AbRJaUKw>;
	Wed, 31 Oct 2001 15:10:52 -0500
Message-ID: <3BE058E8.F9DC0FC1@mcs.anl.gov>
Date: Wed, 31 Oct 2001 14:02:48 -0600
From: JP Navarro <navarro@mcs.anl.gov>
Organization: Argonne National Laboratory
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Raid/Adaptec/SCSI errors, obvious explanation isn't
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can consistently generate 1-2 of the following errors per hour:

Oct 31 10:08:30 ccfs2 kernel: SCSI disk error : host 2 channel 0 id 9 lun 0
return code = 800
Oct 31 10:08:30 ccfs2 kernel: Current sd08:51: sense key Hardware Error
Oct 31 10:08:30 ccfs2 kernel: Additional sense indicates Internal target failure
Oct 31 10:08:30 ccfs2 kernel:  I/O error: dev 08:51, sector 35371392

The errors occur on most of the 14 SCSI disks on two JBODs.
Multiple errors on the same disk always reference different sectors.

The errors occur 1-2 per hour when we rsync a remote machine to a local
file-system.
We've produced this error only once running Bonnie++.
No other I/O activity (cp, nfs serving, etc) has caused an error.

Our hardware config:
   IBM NetFinity 5100 with Dual 866 MHz CPUs (86584RY)
   NetGear GA620 Gigabit Ethernet
   Two IBM EXP15 Fast Wide Ultra SCSI JBODs
   Adaptec 2940 Ultra SCSI adapters
   Each JBOD has 7 x 36 GB 7200 RPM IBM Ultrastar 36XP drives (DRHS-36D)
   Adaptec BIOS configured for 40 MB/s

Our software config:
   RedHat 7.1
   Kernel 2.4.9-ac9

The 14 disks are configured at two 7 disk RAID0 volumes of EXT3. We've
reproduced the problem with one RAID0 volume per JBOD, and also splitting
volumes so they span both JBODs (4 disks on one and 3 on the other).  We did
this because we suspect the errors may be caused by excessive I/O load on a
JBOD.
   
This error started happening *after* we upgraded to the above from the following
s/w:
   RedHat 6.2
   Kernel 2.4.2
   Two RAID0 volumes with ReiserFS

Previous postings have suggested hardware (disk) failures or a bug in the RAID
<-> Adaptec driver interaction.  We think disk failures are unlikely since they
are happening on multiple disks and only after a software upgrade.

We once tested 15K drives on these EXP15 JBODs and encountered SCSI disks/driver
errors, so we've suspected some type of JBOD problem under high load.

Anyhow, does anyone have a clue as to what might be causing these errors, what
tests we could conduct to shed light on the problem, or additional information
we could provide that would be useful.

We're considering running the following tests:

- reduce the SCSI disk transfer rates to below 40 MB/s
- try 2 and 3 disk RAID0/EXT3 file-systems
- other kernels?

Regards,

JP Navarro
