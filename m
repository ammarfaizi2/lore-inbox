Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTKXFRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 00:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTKXFRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 00:17:54 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:12960 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263620AbTKXFRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 00:17:52 -0500
Message-ID: <50478.68.105.173.45.1069651886.squirrel@mail.mainstreetsoftworks.com>
Date: Mon, 24 Nov 2003 00:31:26 -0500 (EST)
Subject: [BUG 2.6.0-test10] SCSI update in CSET 1.1437.1.2 caused 'Badness'
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <tony@vroon.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A user noticed this oddness while using -test10 that he did
not see while using -test9.  This error does not seem to affect
anything. His e-mail is tony@vroon.org if you need more info
from him.

Reverting CSET 1.1437.1.2 fixed his problem below:
http://linux.bkbits.net:8080/linux-2.5/patch@1.1437.1.2?nav=index.html|tags|ChangeSet@1.1350.1.2..|cset@1.1437.1.2



scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:2:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:4:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 7)
Badness in kobject_get at lib/kobject.c:439
Call Trace:
 [<c0238bad>] kobject_get+0x4d/0x50
 [<c0291278>] get_device+0x18/0x30
 [<c02d285c>] scsi_device_get+0x2c/0x80
 [<c02d294e>] __scsi_iterate_devices+0x3e/0x70
 [<c02d6409>] scsi_run_host_queues+0x19/0x50
 [<c02f5f14>] ahc_linux_release_simq+0x94/0xd0
 [<c02f2552>] ahc_linux_dv_thread+0x1e2/0x230
 [<c02f2370>] ahc_linux_dv_thread+0x0/0x230
 [<c01070a9>] kernel_thread_helper+0x5/0xc

  Vendor: COMPAQPC  Model: DDYS-T09170N      Rev: B96H
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 17773524 512-byte hdwr sectors (9100 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg3 at scsi0, channel 0, id 4, lun 0,  type 5




