Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTFPLOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTFPLOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:14:38 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:46269 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263737AbTFPLOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:14:37 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 / IDE lost interrupt / ServerWorks problem
Message-ID: <1055763075.3eedaa83b19c8@imp.free.fr>
Date: Mon, 16 Jun 2003 13:31:15 +0200 (CEST)
From: jfontain@free.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 195.101.92.253
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me as I am not subscribed to the list] 
 
I just upgraded from a 2.4.20 to 2.4.21 but had to revert due to the following 
errors: 
 hdd: dma_timer_expiry: dma status == 0x60 
 hdd: timeout waiting for DMA 
 hdd: lost interrupt 
 
This chipset is: 
  Bus  0, device  15, function  0: 
    ISA bridge: ServerWorks CSB5 South Bridge (rev 147). 
  Bus  0, device  15, function  1: 
    IDE interface: ServerWorks CSB5 IDE Controller (rev 147). 
  Bus  0, device  15, function  2: 
    USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 5). 
on a bi-pentium III machine. 
 
With 2.4.20 and the ide1=ata66 kernel option, that setup worked great: 
# /sbin/hdparm -t /dev/hdd 
/dev/hdd: 
 Timing buffered disk reads:  64 MB in  1.37 seconds = 46.72 MB/sec 
(thanks to all for such great performance (same as SCSI!)) 
 
For 2.4.21, I just added the new "Generic PCI IDE Chipset Support" (no help 
provided), and recompiled, then rebooted. The 2.4.20 message: 
  hdd:351651888sectors(180046 MB)w/2048KiBCache,CHS=21889/255/63,UDMA(100) 
appeared on 2.4.21 as (notice that UDMA(100) has dissapeared): 
  hdd:351651888sectors(180046 MB)w/2048KiBCache,CHS=21889/255/63 
 
I then tried hdparm, which came up with only 2.5 MB/sec, then forced DMA which 
hdparm, tested again and got the errors cited at the beginning of this 
message. 
 
Please let me know if you'd like me to perform some tests, but as I can only 
reboot once or twice at lunch time. 
 
Regards, 
 
Jean-Luc 
 
