Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTCCQPu>; Mon, 3 Mar 2003 11:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTCCQPt>; Mon, 3 Mar 2003 11:15:49 -0500
Received: from mail.ithnet.com ([217.64.64.8]:44804 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266686AbTCCQPp>;
	Mon, 3 Mar 2003 11:15:45 -0500
Date: Mon, 3 Mar 2003 17:26:10 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem report: 2.4.21-pre[4,5] tar on second scsi streamer
 cold-boots
Message-Id: <20030303172610.6d20b83d.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

yet another strange occurence on a Serverworks-chipset based system. I have:

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:04.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0225
01:02.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
01:03.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

with SCSI:

<6>SCSI subsystem driver Revision: 1.00
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8   
<4>        <Adaptec 29160 Ultra160 SCSI adapter>
<4>        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<6>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
<4>        <Adaptec aic7899 Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<6>scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
<4>        <Adaptec aic7899 Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
<4>
<4>  Vendor: BNCHMARK  Model: DLT1              Rev: 391B
<4>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<4>  Vendor: IBM       Model: IC35L073UWDY10-0  Rev: S21E
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi1:A:8:0: Tagged Queuing enabled.  Depth 8
<4>  Vendor: QUANTUM   Model: SDLT320           Rev: 3838
<4>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<6>scsi3 : SCSI host adapter emulation for IDE ATAPI devices
<4>scsi: c165dca0, pc: c1632ba0, rq: dfede540
<4>  Vendor: AOPEN     Model: CD-RW CRW2440     Rev: 2.02
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<6>st: Version 20020805, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
<4>Attached scsi tape st0 at scsi0, channel 0, id 1, lun 0
<4>Attached scsi tape st1 at scsi2, channel 0, id 2, lun 0
<4>Attached scsi disk sda at scsi1, channel 0, id 8, lun 0

Report:

If I try to do a simple tar on the second streamer (/dev/st1) the machine cold-boots (no oops, no segfault, just zap) after varying amount of written data. I try to tar around 50GB and it does not manage this amount ever, I tried several times. If I disconnect /dev/st0 (BNCHMARK drive) and do just the same tar on /dev/st0 it works as expected.
As you can see /dev/st0 is connected to another SCSI-bus, so it should not interfer on the bus (termination issue or the like).
As it cold-boots without prior warning I have no good idea how to present valuable debug info.

Regards,
Stephan


