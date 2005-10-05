Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVJEVS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVJEVS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJEVS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:18:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:12764 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030295AbVJEVS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:18:57 -0400
Message-ID: <4344433D.5090305@pobox.com>
Date: Wed, 05 Oct 2005 17:18:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pasi Pirhonen <upi@papat.org>,
       Michael Madore <Michael.Madore@aslab.com>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
Subject: Re: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and simplification
References: <20051005210610.EC31826369@lns1058.lss.emc.com> <20051005210842.F366B26369@lns1058.lss.emc.com> <434442D9.5010800@pobox.com>
In-Reply-To: <434442D9.5010800@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------010705060208000102020607"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010705060208000102020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also, I just applied the attached patch, to kill a warning:

drivers/scsi/sata_mv.c:471: warning: 'mv_dump_mem' defined but not used

	Jeff




--------------010705060208000102020607
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -467,9 +467,9 @@ static void mv_stop_dma(struct ata_port 
 	}
 }
 
+#ifdef ATA_DEBUG
 static void mv_dump_mem(void __iomem *start, unsigned bytes)
 {
-#ifdef ATA_DEBUG
 	int b, w;
 	for (b = 0; b < bytes; ) {
 		DPRINTK("%p: ", start + b);
@@ -479,8 +479,9 @@ static void mv_dump_mem(void __iomem *st
 		}
 		printk("\n");
 	}
-#endif
 }
+#endif
+
 static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 {
 #ifdef ATA_DEBUG

--------------010705060208000102020607--
