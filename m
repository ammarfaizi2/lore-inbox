Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTIQNHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTIQNHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:07:07 -0400
Received: from m23.limsi.fr ([192.44.78.23]:34945 "EHLO m23.limsi.fr")
	by vger.kernel.org with ESMTP id S262744AbTIQNG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:06:58 -0400
Date: Wed, 17 Sep 2003 15:06:56 +0200
From: Olivier Galibert <olivier.galibert@limsi.fr>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: AIC7xxx LUN enumeration failure and DV config failure
Message-ID: <20030917130656.GA2948@m23.limsi.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have two transtec 5016 IDE disks/SCSI interface raid arrays
connected to a motherboard Adaptec AIC7902 Ultra320 SCSI adapter on
scsi1.  Each is split in two LUNs, 2x1.4Tb for the first and 2x2Tb for
the second.  There is also the root disk and $DEITY-knows-what on
scsi0.

With 2.4.22-pre9 aic79xx driver:
Sep 17 14:41:41 m61 kernel: SCSI subsystem driver Revision: 1.00
Sep 17 14:41:41 m61 kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
Sep 17 14:41:41 m61 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Sep 17 14:41:41 m61 kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Sep 17 14:41:41 m61 kernel: 
Sep 17 14:41:42 m61 kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
Sep 17 14:41:42 m61 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Sep 17 14:41:42 m61 kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Sep 17 14:41:42 m61 kernel: 
Sep 17 14:41:42 m61 kernel: blk: queue f7969618, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel: (scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
Sep 17 14:41:42 m61 kernel: scsi1:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
Sep 17 14:41:42 m61 kernel: scsi1:A:1:0: DV failed to configure device.  Please file a bug report against this driver.
Sep 17 14:41:42 m61 kernel:   Vendor: SEAGATE   Model: ST373307LC        Rev: 0004
Sep 17 14:41:42 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:41:42 m61 kernel: blk: queue f7969418, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel:   Vendor: SUPER     Model: GEM318            Rev: 0   
Sep 17 14:41:42 m61 kernel:   Type:   Processor                          ANSI SCSI revision: 02
Sep 17 14:41:42 m61 kernel: blk: queue f78f1618, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Sep 17 14:41:42 m61 kernel: (scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
Sep 17 14:41:42 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
Sep 17 14:41:42 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:41:42 m61 kernel: blk: queue f78ce218, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
Sep 17 14:41:42 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:41:42 m61 kernel: blk: queue f78ce018, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel: (scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, 16bit)
Sep 17 14:41:42 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
Sep 17 14:41:42 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:41:42 m61 kernel: blk: queue f7889c18, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
Sep 17 14:41:42 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:41:42 m61 kernel: blk: queue f7889a18, I/O limit 524287Mb (mask 0x7fffffffff)
Sep 17 14:41:42 m61 kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Sep 17 14:41:42 m61 kernel: scsi1:A:0:1: Tagged Queuing enabled.  Depth 32
Sep 17 14:41:42 m61 kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
Sep 17 14:41:42 m61 kernel: scsi1:A:1:1: Tagged Queuing enabled.  Depth 32
Sep 17 14:41:42 m61 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Sep 17 14:41:42 m61 kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Sep 17 14:41:42 m61 kernel: Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
Sep 17 14:41:42 m61 kernel: Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
Sep 17 14:41:42 m61 kernel: Attached scsi disk sde at scsi1, channel 0, id 1, lun 1
Sep 17 14:41:42 m61 kernel: SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Sep 17 14:41:42 m61 kernel: Partition check:
Sep 17 14:41:42 m61 kernel:  sda: sda1 sda2 sda3 sda4
Sep 17 14:41:42 m61 kernel: SCSI device sdb: 2788016128 512-byte hdwr sectors (1427464 MB)
Sep 17 14:41:42 m61 kernel:  sdb: sdb1
Sep 17 14:41:42 m61 kernel: SCSI device sdc: 2788016128 512-byte hdwr sectors (1427464 MB)
Sep 17 14:41:42 m61 kernel:  sdc: sdc1
Sep 17 14:41:42 m61 kernel: SCSI device sdd: 4101521408 512-byte hdwr sectors (2099979 MB)
Sep 17 14:41:42 m61 kernel:  sdd: sdd1
Sep 17 14:41:42 m61 kernel: SCSI device sde: 4101521408 512-byte hdwr sectors (2099979 MB)
Sep 17 14:41:42 m61 kernel:  sde: sde1
Sep 17 14:41:42 m61 kernel: Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 3


There is a DV configuration failure which limits the speed to U160,
but otherwise everything works nicely.


With 2.4.23-pre4 aix7xxx driver:

Sep 17 14:37:25 m61 kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.9
Sep 17 14:37:25 m61 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Sep 17 14:37:25 m61 kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Sep 17 14:37:25 m61 kernel: 
Sep 17 14:37:25 m61 kernel: (scsi0:A:0): 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|QAS, 16bit)
Sep 17 14:37:25 m61 kernel:   Vendor: SEAGATE   Model: ST373307LC        Rev: 0004
Sep 17 14:37:25 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:37:25 m61 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Sep 17 14:37:25 m61 kernel:   Vendor: SUPER     Model: GEM318            Rev: 0   
Sep 17 14:37:25 m61 kernel:   Type:   Processor                          ANSI SCSI revision: 02
Sep 17 14:37:25 m61 kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.9
Sep 17 14:37:25 m61 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Sep 17 14:37:25 m61 kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Sep 17 14:37:25 m61 kernel: 
Sep 17 14:37:25 m61 kernel: scsi1:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
Sep 17 14:37:25 m61 kernel: scsi1:A:1:0: DV failed to configure device.  Please file a bug report against this driver.
Sep 17 14:37:25 m61 kernel: (scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
Sep 17 14:37:25 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
Sep 17 14:37:25 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:37:25 m61 kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Sep 17 14:37:25 m61 kernel: scsi: On host 1 channel 0 id 0 only 128 (max_scsi_report_luns) of 536870896 luns reported, try increasing max_scsi_report_luns.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x7400616e73746563 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x2001202020202020 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x2002202020202020 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun808529923 has a LUN larger than allowed by the host adapter
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun3078 has a LUN larger than allowed by the host adapter
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x000000000f000000 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: (scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, 16bit)
Sep 17 14:37:25 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
Sep 17 14:37:25 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 17 14:37:25 m61 kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
Sep 17 14:37:25 m61 kernel: scsi: On host 1 channel 0 id 1 only 128 (max_scsi_report_luns) of 536870896 luns reported, try increasing max_scsi_report_luns.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x7400616e73746563 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x2001202020202020 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x2002202020202020 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun808529923 has a LUN larger than allowed by the host adapter
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun3078 has a LUN larger than allowed by the host adapter
Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x000000000f000000 has a LUN larger than currently supported.
Sep 17 14:37:25 m61 kernel: SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Sep 17 14:37:25 m61 kernel: SCSI device sda: drive cache: write back
Sep 17 14:37:25 m61 kernel:  sda: sda1 sda2 sda3 sda4
Sep 17 14:37:25 m61 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Sep 17 14:37:25 m61 kernel: SCSI device sdb: 2788016128 512-byte hdwr sectors (1427464 MB)
Sep 17 14:37:25 m61 kernel: SCSI device sdb: drive cache: write back
Sep 17 14:37:25 m61 kernel:  sdb: sdb1
Sep 17 14:37:25 m61 kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Sep 17 14:37:25 m61 kernel: SCSI device sdc: 4101521408 512-byte hdwr sectors (2099979 MB)
Sep 17 14:37:25 m61 kernel: SCSI device sdc: drive cache: write back
Sep 17 14:37:25 m61 kernel:  sdc: sdc1
Sep 17 14:37:25 m61 kernel: Attached scsi disk sdc at scsi1, channel 0, id 1, lun 0
Sep 17 14:37:25 m61 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Sep 17 14:37:25 m61 kernel: Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 3
Sep 17 14:37:25 m61 kernel: Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Sep 17 14:37:26 m61 kernel: Attached scsi generic sg3 at scsi1, channel 0, id 1, lun 0,  type 0


You can see that the LUN enumeration exploded.  We end up with the
first half of each RAID only.  The configuration failure is still
there too.  BTW, the behaviour is the same with 2.6.0-test3.

I can test and/or provide additional information as needed.

  OG.

