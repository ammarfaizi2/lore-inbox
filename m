Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSKZFX5>; Tue, 26 Nov 2002 00:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKZFX5>; Tue, 26 Nov 2002 00:23:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:8184 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266161AbSKZFXF>;
	Tue, 26 Nov 2002 00:23:05 -0500
Message-ID: <3DE306E4.26E746BA@digeo.com>
Date: Mon, 25 Nov 2002 21:30:12 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [patch] IDE fix for current -bk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2002 05:30:13.0285 (UTC) FILETIME=[E4EF9D50:01C2950C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_ide_setup_pci_device() is returning an uninitialised
ata_index_t causing an oops at bootup.


--- 25/drivers/ide/setup-pci.c~ide-fix	Mon Nov 25 21:24:42 2002
+++ 25-akpm/drivers/ide/setup-pci.c	Mon Nov 25 21:25:11 2002
@@ -693,7 +693,7 @@ static ata_index_t do_ide_setup_pci_devi
 	int autodma = 0;
 	int pciirq = 0;
 	int tried_config = 0;
-	ata_index_t index;
+	ata_index_t index = { .b = { .low = 0xff, .high = 0xff } };
 
 	if((autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
 		return index;

_
