Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTE0LYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTE0LYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:24:30 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:49936 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263274AbTE0LYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:24:25 -0400
Message-ID: <3ED34E4A.8040601@torque.net>
Date: Tue, 27 May 2003 21:38:50 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
References: <20030524195123.GA8394@gtf.org>
In-Reply-To: <20030524195123.GA8394@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
<snip>

> * Only supports Intel PATA and SATA right now

Jeff,
Your patch applies to lk 2.5.70 without problems.

I found that my dual Celeron (abit mobo) has this
Intel IDE controller:
   00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)

so I tried a 2.5.70 kernel with this patch. Two disks
connected:
   - SCSI disk to a Tekram 390u3w controller (sym53c8xx_2
     driver). Root partition on this disk
   - a Maxtor ATA disk (D740X-6L) to the Intel IDE
     controller.

Didn't get too far. After finding the SCSI controller and
SCSI disk at boot up, this came out just before it locked up:
  ata1:PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14

So I disabled the IDE controllers in the BIOS and then
this came out:
  ....
  PCI: Enabling device 00:07.1 (0000->0001)
  ata1:PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
  ATA: abnormal status 0xFF on port 0x1F7
  ATA: abnormal status 0xFF on port 0x1F7

and it locked up again.

Doug Gilbert

