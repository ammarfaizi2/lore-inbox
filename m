Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUHaGAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUHaGAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUHaGAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:00:15 -0400
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:11935 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S266684AbUHaGAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:00:08 -0400
Message-ID: <7076215DFAA4574099E5CD59FE42226204FBC27B@pcssrv42.pcs.pc.ome.toshiba.co.jp>
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: Petr Sebor <petr@scssoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, petter.sundlof@findus.dhs.org,
       linux-kernel@vger.kernel.org
Subject: RE: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
Date: Tue, 31 Aug 2004 14:58:26 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr

Petr wrote> I am not using the combine mode on the sata drives 
Petr wrote> (or at least, I don't know about it). I was implying that
Petr wrote> when I connect another pure IDE drive to the motherboard, 
Petr wrote> then the situation gets better.

It seems that I have mistaken. 
The misunderstood problem is as follows. 

Combined mode can be set up by the SATA controller of ESB of Intel tip. 
This mode is the mode which can use SATA and PATA simultaneously. 
In ata_piix driver, when combined mode is specified, it does not work.
On the other hand, at the piix driver, in order not to recognize ESB tip, 
it worked only by PIO mode.

Petr wrote> Whats wrong here (or ... what feels wrong) is that the system 
Petr wrote> slows down noticeably when transferring data
Petr wrote> to/from the sata drives. It 'feels' like using an old ide 
Petr wrote> disk with pio mode only. I am not saying that the transfer rates
Petr wrote> are low though... hdparm -t on the sata drives gives me following:

It is the result of measuring in my environment:

  Linux-2.4.28-pre2 (RedHat Enterprise Linux 3 Update2 Base)
  HDD: HITACHI DeskStar 80G x 2
  SATA: Intel 82801ESB
  ata_piix driver version : 1.02.

The result is as follows. 
I think that there are not your result and great difference.

/dev/sda:
Timing buffered disk reads:  152 MB in  3.00 seconds =  50.67 MB/sec

/dev/sdb:
Timing buffered disk reads:  174 MB in  3.02 seconds =  57.62 MB/sec

Best Regards,
Haruo 
