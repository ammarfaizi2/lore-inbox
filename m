Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTAHCcr>; Tue, 7 Jan 2003 21:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbTAHCcr>; Tue, 7 Jan 2003 21:32:47 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:12674 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267625AbTAHCcp>; Tue, 7 Jan 2003 21:32:45 -0500
Date: Wed, 8 Jan 2003 03:41:07 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: dipankar@in.ibm.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <20030108024107.GA1127@louise.pinerecords.com>
References: <20030103101618.GB8582@in.ibm.com> <596830816.1041606846@aslan.scsiguy.com> <20030106073204.GA1875@in.ibm.com> <274040000.1041869813@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274040000.1041869813@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [gibbs@scsiguy.com]
>
> These reads are actually more expensive than just using PIO.  Neither of
> these older drivers included a test to try and catch fishy behavior.

Justin, are you quite sure that these tests actually work?
I too have just run into

aic7xxx: PCI Device 0:16:0 failed memory mapped test.  Using PIO.
aic7xxx: PCI Device 0:17:0 failed memory mapped test.  Using PIO.

with aic79xx-linux-2.4-20021230 (6.2.25) in Linux 2.4.21-pre3.
What makes me scratch my head in particular is:

	o  The chipset is i440BX aka the Compatibility King.
	o  I've never had *any* problems with 6.2.8.

Full ahc boot-up messages follow:

PCI: Found IRQ 11 for device 00:10.0
aic7xxx: PCI Device 0:16:0 failed memory mapped test.  Using PIO.
PCI: Found IRQ 10 for device 00:11.0
aic7xxx: PCI Device 0:17:0 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST39173N          Rev: 6244
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:3:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST39173N          Rev: 6244
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 4, lun 0
...

-- 
Tomas Szepe <szepe@pinerecords.com>
