Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVA3Xeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVA3Xeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVA3Xeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:34:50 -0500
Received: from mid-2.inet.it ([213.92.5.19]:7422 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S261838AbVA3Xeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:34:46 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: 2.6.11-rc[1,2]-mmX scsi cdrom problem, 2.6.10-mm2 ok
Date: Mon, 31 Jan 2005 00:34:31 +0100
User-Agent: KMail/1.7.91
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501310034.32005.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a problem with latest mm releases; with 2.6.11-rc1,2-mmX every time 
I fire up k3b, it get stuck here: (last line, previous lines just for 
documentation :) )

open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 11
ioctl(11, CDROM_SEND_PACKET, 0xbfffc4e0) = 0
close(11)                               = 0
open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 11
ioctl(11, CDROM_SEND_PACKET, 0xbfffc590) = -1 EIO (Input/output error)
close(11)                               = 0
open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 11
ioctl(11, CDROM_SEND_PACKET, 0xbfffc4e0) = 0
ioctl(11, CDROM_SEND_PACKET, 0xbfffc4e0) = 0
close(11)                               = 0
open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 11
ioctl(11, CDROM_GET_CAPABILITY or SNDRV_SEQ_IOCTL_UNSUBSCRIBE_PORT, 
0x7fffffff) = 3735535
close(11)                               = 0
lstat64("/dev", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=30220, ...}) = 0
lstat64("/dev/sr1", {st_mode=S_IFBLK|0600, st_rdev=makedev(11, 1), ...}) = 0
open("/dev/sr1", O_RDONLY|O_NONBLOCK)   = 11
fstat64(11, {st_mode=S_IFBLK|0600, st_rdev=makedev(11, 1), ...}) = 0
ioctl(11, CDROM_SEND_PACKET, 0xbfffd740) = 0
close(11)                               = 0
open("/dev/sr1", O_RDONLY|O_NONBLOCK)   = 11
fstat64(11, {st_mode=S_IFBLK|0600, st_rdev=makedev(11, 1), ...}) = 0
ioctl(11, CDROMAUDIOBUFSIZ or SCSI_IOCTL_GET_IDLUN, 0xbfffd7e8) = 0
ioctl(11, SCSI_IOCTL_GET_BUS_NUMBER, 0xbfffd8a4) = 0
close(11)                               = 0
open("/dev/sr1", O_RDONLY|O_NONBLOCK)   = 11
ioctl(11, CDROM_SEND_PACKET, 0xbfffd7d0) = 0
ioctl(11, CDROM_SEND_PACKET          

At this point k3b is stuck in D stat, needs reboot.

I've thinked of faulty HW, but 2.6.10-mm2 can complete the scan (I haven't 
tried to use that device, to ber honest, after successful initialization).

On scsi- bus I've the following devices:
cova@kefk ~ $ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: Nikon    Model: COOLSCANIII      Rev: 1.31
  Type:   Scanner                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0c
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05

cova@kefk ~ $ cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.2.36
Adaptec 2902/04/10/15/20C/30C SCSI adapter
aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
Allocated SCBs: 4, SG List Length: 128



Let me know if further details/testing are needed.



-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
