Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQKOA1A>; Tue, 14 Nov 2000 19:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbQKOA0u>; Tue, 14 Nov 2000 19:26:50 -0500
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:14084 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S129793AbQKOA0k>;
	Tue, 14 Nov 2000 19:26:40 -0500
Message-ID: <3A11D22C.9E3AA068@windeath.2y.net>
Date: Tue, 14 Nov 2000 18:00:44 -0600
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gert Wollny <wollny@cns.mpg.de>
Cc: linux-kernel@vger.kernel.org, twaugh@redhat.com
Subject: Re: Parport/IMM/Zip Oops Revisited -- Filesys problem? Viro pleaselook
In-Reply-To: <Pine.LNX.4.10.10011150012390.684-100000@bolide.beigert.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Wollny wrote:
> 
> Actually i never tried to mount in my testings, just did "modprobe imm". I
> did not even load sd.o, which reads the size of the medium. Output after
> successfull modprobe:
> kernel: imm: Version 2.04 (for Linux 2.4.0)
> kernel: imm_connect 1
> kernel: imm: Found device at ID 6, Attempting to use EPP 32 bit
> kernel: imm: Found device at ID 6, Attempting to use PS/2
> kernel: imm: Communication established at 0x378 with ID 6 using PS/2
> kernel: device_check 0
> kernel: scsi1 : Iomega VPI2 (imm) interface
> kernel: scsi : 2 hosts.
> kernel:   Vendor: IOMEGA    Model: ZIP 250           Rev: J.45
> kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
> 
> Even without a disk this works (if parport_pc is preloaded).
> 
> Anyway the disk in the drive was a 250MB vfat formatted one. But OTOH, the
> oops trace points to ext2.
> 
> For completeness: With the disk "modprobe sd"  gives

As you say, for completeness:

SCSI subsystem driver Revision: 1.00
parport0: PC-style at 0x378 [PCSPP]
parport0: irq 7 detected
imm: Version 2.04 (for Linux 2.4.0)
imm: Found device at ID 6, Attempting to use EPP 32 bit
imm: Found device at ID 6, Attempting to use SPP
imm: Communication established at 0x378 with ID 6 using SPP
scsi0 : Iomega VPI2 (imm) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: P.05
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
 sda: sda4

As I noted in a previous posting to the list my Communication type is
misdetected as SPP when it really is EPP. The 101 MB size looks fishy
also as it usually reads 96 MB IIRC.

> 
> kernel: Detected scsi removable disk sda at scsi1, channel 0, id 6, lun 0
> kernel: SCSI device sda: hdwr sector= 512 bytes. Sectors= 489532 [239 MB] [0.2 GB]
> kernel: sda: Write Protect is off
> kernel:  sda: sda4
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
