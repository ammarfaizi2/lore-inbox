Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133010AbRDKWzk>; Wed, 11 Apr 2001 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133015AbRDKWz2>; Wed, 11 Apr 2001 18:55:28 -0400
Received: from mail.zikzak.de ([195.21.249.46]:32260 "EHLO mail.zikzak.de")
	by vger.kernel.org with ESMTP id <S133018AbRDKWyv>;
	Wed, 11 Apr 2001 18:54:51 -0400
From: amk@krell.snafu.de (Andreas M. Kirchwitz)
Subject: aic7xxx 6.1.5 in kernel 2.4.3 doesn't recognize Yamaha CDRW
Date: 11 Apr 2001 22:54:47 GMT
Organization: Touched By The Hand Of God.
Message-ID: <slrn9d9o5m.597.amk@krell.zikzak.de>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello!

In case somebody is interested ...

The new Adaptec SCSI host-adapter driver "aic7xxx 6.1.5" in
Linux kernel 2.4.3 (compiled on a RedHat 7.0 system) doesn't
recognize my Yamaha CRW4416S CD-ReWriter. It also outputs some
error messages saying "request_module[scsi_hostadapter]:
Root fs not mounted".

It worked fine with the old aic7xxx 5.x driver in kernel 2.4.2.

After fetching the new aic7xxx 6.1.11 driver from
http://people.FreeBSD.org/~gibbs/linux/ and applying
the patch to a vanilla 2.4.3 kernel source tree,
everything was fine again. The error messages disappeared
and my Yamaha CD-ReWriter was recognized.

Looks like the aic7xxx 6.1.5 driver shipped with kernel 2.4.3
isn't a good choice. ;-)

Excerpt from /var/log/messages with vanilla Linux kernel 2.4.3
and built-in aic7xxx 6.1.5 driver:

  Apr 11 22:03:51 lakai kernel: SCSI subsystem driver Revision: 1.00
  Apr 11 22:03:51 lakai kernel: request_module[scsi_hostadapter]: Root fs not mounted
  Apr 11 22:03:51 lakai kernel: request_module[scsi_hostadapter]: Root fs not mounted
  Apr 11 22:03:51 lakai kernel: request_module[scsi_hostadapter]: Root fs not mounted
  Apr 11 22:03:51 lakai kernel: PCI: Found IRQ 9 for device 02:0b.0
  Apr 11 22:03:51 lakai kernel: PCI: The same IRQ used for device 01:00.0
  Apr 11 22:03:51 lakai kernel: PCI: The same IRQ used for device 02:09.0
  Apr 11 22:03:51 lakai kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
  Apr 11 22:03:51 lakai kernel:         <Adaptec 2940 SCSI adapter>
  Apr 11 22:03:51 lakai kernel:         aic7870: Single Channel A, SCSI Id=7, 16/255 SCBs
  Apr 11 22:03:51 lakai kernel:
  Apr 11 22:03:51 lakai kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Apr 11 22:03:51 lakai kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
  Apr 11 22:03:51 lakai kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Apr 11 22:03:51 lakai kernel: scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
  Apr 11 22:03:51 lakai kernel: (scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Apr 11 22:03:51 lakai kernel: SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
  Apr 11 22:03:51 lakai kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >

Excerpt from /var/log/messages with aic7xxx 6.1.11 patch applied
to vanilla kernel 2.4.3 source tree:

  Apr 12 00:00:52 lakai kernel: SCSI subsystem driver Revision: 1.00
  Apr 12 00:00:52 lakai kernel: PCI: Found IRQ 9 for device 02:0b.0
  Apr 12 00:00:52 lakai kernel: PCI: The same IRQ used for device 01:00.0
  Apr 12 00:00:52 lakai kernel: PCI: The same IRQ used for device 02:09.0
  Apr 12 00:00:52 lakai kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11
  Apr 12 00:00:52 lakai kernel:         <Adaptec 2940 SCSI adapter>
  Apr 12 00:00:52 lakai kernel:         aic7870: Single Channel A, SCSI Id=7, 16/255 SCBs
  Apr 12 00:00:52 lakai kernel:
  Apr 12 00:00:52 lakai kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Apr 12 00:00:52 lakai kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
  Apr 12 00:00:53 lakai kernel:   Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0f
  Apr 12 00:00:53 lakai kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
  Apr 12 00:00:53 lakai kernel: scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
  Apr 12 00:00:53 lakai kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Apr 12 00:00:53 lakai kernel: (scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Apr 12 00:00:53 lakai kernel: SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
  Apr 12 00:00:53 lakai kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
  Apr 12 00:00:53 lakai kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
  Apr 12 00:00:53 lakai kernel: (scsi0:A:5): 8.333MB/s transfers (8.333MHz, offset 15)
  Apr 12 00:00:53 lakai kernel: sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray


Regards,
Andreas
