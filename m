Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWDWQAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWDWQAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDWQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:00:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:38796 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751415AbWDWQAy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:00:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JJulk3YyS7n3jZlt+haggv3/SBEIkmdRsY6ExrhqWnfrFW1pDGYWIZ5w06JYp8EdH7jlcgsJgAuZhsWEOOY70sRTVtgW7jvBB1RbCX/msJs55V0gX5Fnrr9ICCa7s5LKUfF3LVpwb2Sb89PTa9HzIHMcfZoAx/XY+/4OkcuQzAA=
Message-ID: <9e4733910604230900h12b4d200y7f3f045eb04feba5@mail.gmail.com>
Date: Sun, 23 Apr 2006 12:00:54 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Seek failure on SATA drive
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like a seek that missed. Was this the correct error
behavior? It knocked the drive out of the array. The drive is a fairly
new Maxtor model.

2.6.17-rc1
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6V200E0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05

Apr 22 21:26:23 jonsmirl kernel: ata1: translated ATA stat/err 0x37/00
to SCSI SK/ASC/ASCQ 0x4/00/00
Apr 22 21:26:23 jonsmirl kernel: ata1: status=0x37 { DeviceFault
SeekComplete CorrectedError Index Error }
Apr 22 21:27:23 jonsmirl kernel: ata1: command 0xca timeout, stat 0xb7
host_stat 0x21
Apr 22 21:27:23 jonsmirl kernel: ata1: translated ATA stat/err 0xb7/00
to SCSI SK/ASC/ASCQ 0xb/47/00
Apr 22 21:27:23 jonsmirl kernel: ata1: status=0xb7 { Busy }
Apr 22 21:27:23 jonsmirl kernel: sd 0:0:0:0: SCSI error: return code = 0x8000002
Apr 22 21:27:23 jonsmirl kernel: sda: Current: sense key=0xb
Apr 22 21:27:23 jonsmirl kernel:     ASC=0x47 ASCQ=0x0
Apr 22 21:27:23 jonsmirl kernel: Info fld=0x76622c2
Apr 22 21:27:23 jonsmirl kernel: end_request: I/O error, dev sda,
sector 124134082
Apr 22 21:27:53 jonsmirl kernel: ata1: command 0xea timeout, stat 0xb7
host_stat 0x0
Apr 22 21:27:53 jonsmirl kernel: ata1: translated ATA stat/err 0xb7/00
to SCSI SK/ASC/ASCQ 0xb/47/00
Apr 22 21:27:53 jonsmirl kernel: ata1: status=0xb7 { Busy }
Apr 22 21:27:53 jonsmirl kernel: raid1: Disk failure on sda5, disabling device.
Apr 22 21:27:53 jonsmirl kernel:        Operation continuing on 1 devices
Apr 22 21:27:53 jonsmirl kernel: RAID1 conf printout:
Apr 22 21:27:53 jonsmirl kernel:  --- wd:1 rd:2
Apr 22 21:27:53 jonsmirl kernel:  disk 0, wo:0, o:1, dev:hda2
Apr 22 21:27:53 jonsmirl kernel:  disk 1, wo:1, o:0, dev:sda5
Apr 22 21:27:53 jonsmirl kernel: RAID1 conf printout:
Apr 22 21:27:53 jonsmirl kernel:  --- wd:1 rd:2
Apr 22 21:27:53 jonsmirl kernel:  disk 0, wo:0, o:1, dev:hda2
Apr 22 21:28:14 jonsmirl kernel: ata1: command 0xb0 timeout, stat 0xb7
host_stat 0x0
Apr 22 21:28:14 jonsmirl kernel: ata1: translated ATA stat/err 0xb7/00
to SCSI SK/ASC/ASCQ 0xb/47/00
Apr 22 21:28:14 jonsmirl kernel: ata1: status=0xb7 { Busy }
Apr 22 21:28:14 jonsmirl smartd[1927]: Device: /dev/sda, not capable
of SMART self-check
Apr 22 21:28:14 jonsmirl smartd[1927]: Sending warning via mail to
jonsmirl@gmail.com ...

--
Jon Smirl
jonsmirl@gmail.com
