Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUL0WGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUL0WGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUL0WGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:06:52 -0500
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:38031 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261603AbUL0WGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:06:41 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200412272202.iBRM2Upj021784@wildsau.enemy.org>
Subject: SG_GET_VERSION_NUM rejected on scsi device?
To: linux-kernel@vger.kernel.org
Date: Mon, 27 Dec 2004 23:02:29 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good evening,

I have a old Plextor CD-R, native scsi, attached to an AHA_2940.
looks like this:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs

blk: queue dd3b3218, I/O limit 4095Mb (mask 0xffffffff)
resize_dma_pool: unknown device type -1
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue dd3b3018, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray


now, I do an ioctl(SG_GET_VERSION_NUM) (0x2282), and that fails:

    open("/dev/sr0", O_RDONLY)              = 3
    ioctl(3, 0x2282, 0xbffff660)            = -1 EINVAL (Invalid argument)

on the other hand, I can sucessfully mount /dev/sr0, e.g.:

bash-2.05# df
...
/dev/sr0                110998    110998         0 100% /mnt

kernel is 2.4.28, but since this is a native scsi device, that should
not matter, right?

so, what's wrong here?

/herp

