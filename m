Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319375AbSHVPxH>; Thu, 22 Aug 2002 11:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319376AbSHVPxH>; Thu, 22 Aug 2002 11:53:07 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:62109 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S319375AbSHVPxG>; Thu, 22 Aug 2002 11:53:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux 2.4.20-pre2-ac6
Date: Thu, 22 Aug 2002 17:57:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10208220104100.11626-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10208220104100.11626-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020822155306Z319375-685+35525@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 August 2002 10:05, Andre Hedrick wrote:
> SWEET, that give me a comparison point to check.
> Please try with DMA off on the burn to isolate if net logic in the changes
> is bad or if it is the DMA engine part.
> 

ok update:

not only is it not possible to burn, reading a cd also fails:
from dmesg:
<snip>
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 23.D
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
attempt to access beyond end of device
0b:00: rw=0, want=34, limit=2
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
attempt to access beyond end of device
0b:00: rw=0, want=34, limit=2
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
attempt to access beyond end of device
0b:00: rw=0, want=34, limit=2
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
scsi0: ERROR on channel 0, id 1, lun 0, CDB: 0x03 00 00 00 40 00
Current sd0b:00: sns = 70  3
ASC= 2 ASCQ= 0
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x02
0x00 0x00 0x00 0x00 0x00
 I/O error: dev 0b:00, sector 0

messages show the loading of modules: modprobe sr_mod, modprobe ide-scsi and 
modprobe sg. then I tried 3 times to mount the cd (the 'attempt to access 
beyond end of device' messages) and once to do a `dd if=/dev/sr0 of=test 
bs=1024 count=1` which fails saying:
dd: reading `/dev/sr0': Input/output error
0+0 records in
0+0 records out


hope this helps

	Rudmer
