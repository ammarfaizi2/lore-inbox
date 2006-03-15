Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWCOWNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWCOWNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWCOWNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:13:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:22174 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751823AbWCOWNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:13:41 -0500
Date: Wed, 15 Mar 2006 23:11:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315221119.GA21775@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315215020.GA18241@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below is a blind shot into the dark: it turns on MMIO for the 
sata_nv driver. But be careful with it - this turns on a probably 
totally untested mode in the driver and thus may damage your data. (It 
might not even work at all because the driver might not be ready for it 
- Jeff?).  I'd suggest to first boot into single-user mode with all 
filesystems readonly mounted.

on the low chance of this patch actually working, the interesting thing 
would be to check whether the latencies occur in MMIO mode too? (if they 
do then please send us the new latency traces too.)

	Ingo

---------

WARNING: this may damage your data. Be careful ...

 drivers/scsi/sata_nv.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux/drivers/scsi/sata_nv.c
===================================================================
--- linux.orig/drivers/scsi/sata_nv.c
+++ linux/drivers/scsi/sata_nv.c
@@ -280,6 +280,7 @@ static struct ata_port_info nv_port_info
 	.host_flags	= ATA_FLAG_SATA |
 			  /* ATA_FLAG_SATA_RESET | */
 			  ATA_FLAG_SRST |
+			  ATA_FLAG_MMIO |
 			  ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,
 	.mwdma_mask	= NV_MWDMA_MASK,
