Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRJaBOb>; Tue, 30 Oct 2001 20:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278815AbRJaBOQ>; Tue, 30 Oct 2001 20:14:16 -0500
Received: from jalon.able.es ([212.97.163.2]:11499 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S278818AbRJaBNs>;
	Tue, 30 Oct 2001 20:13:48 -0500
Date: Wed, 31 Oct 2001 00:18:46 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: cdrecord from ext3
Message-ID: <20011031001846.A1840@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have found a strange problem using cdrecord from an ext3 partition.
When burning a cd image (about 500Mb), with cdrecord -v to see some info,
after about 150Mb the percentage of fifo filled begins to drop, until the
burning fails. I though it was related to some buffer/cache issue, but
then I just copied the image to an ext2 partition (so the cache still
filled more, just reaching my ram size), and burnt perfect from the
ext2 partition.

So it looks like ext3 can not give a sustained read rate (not so much,
burning was at 8x). Fifo from ext2 never dropped below 99%.

Is this a bug or the answer is just 'never toast from a journaled fs' ?

Kernel: 2.4.13-ac5+bproc, controller is an Adaptec

Controller:
Adaptec AIC7xxx driver version: 6.2.4
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

Drives:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: CREATIVE Model: CD5230E          Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: YAMAHA   Model: CRW8424E         Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02

Settings:
Channel A Target 0 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
		(ext2)
Channel A Target 1 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
		(ext3)

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-ac5-beo #1 SMP Tue Oct 30 00:10:00 CET 2001 i686
