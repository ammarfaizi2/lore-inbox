Return-Path: <linux-kernel-owner+w=401wt.eu-S964805AbXADSJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbXADSJP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbXADSJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:09:15 -0500
Received: from wasp.net.au ([203.190.192.17]:35053 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964817AbXADSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:09:13 -0500
Message-ID: <459D42B1.20604@wasp.net.au>
Date: Thu, 04 Jan 2007 22:08:49 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>, Alan <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with pata_hpt37x ...
References: <20070102070144.GA11270@MAIL.13thfloor.at> <20070102145855.170c03e2@localhost.localdomain> <459D26D4.3010601@wasp.net.au> <20070104173058.GA2160@MAIL.13thfloor.at>
In-Reply-To: <20070104173058.GA2160@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

> sounds great! where can I get that version?
> should it be in 2.6.20-rc* or is there a separate
> patch available somewhere?

The patch was contained in the message from Alan to you that I replied to. I just applied it to a 
vanilla 2.6.20-rc3 tree and fired it up.

(I've pasted it inline here for you but I'm using thunderbird and it's likely the resulting mess may 
not apply - not hard to manually change the required lines however)

--- linux.vanilla-2.6.20-rc3/drivers/ata/pata_hpt37x.c	2007-01-01 21:43:27.000000000 +0000
+++ linux-2.6.20-rc3/drivers/ata/pata_hpt37x.c	2007-01-02 14:30:18.122801920 +0000
@@ -25,7 +25,7 @@
  #include <linux/libata.h>

  #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.5.1"
+#define DRV_VERSION	"0.5.2"

  struct hpt_clock {
  	u8	xfer_speed;
@@ -749,7 +749,7 @@
  {
  	struct ata_port *ap = qc->ap;
  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int mscreg = 0x50 + 2 * ap->port_no;
+	int mscreg = 0x50 + 4 * ap->port_no;
  	u8 bwsr_stat, msc_stat;

  	pci_read_config_byte(pdev, 0x6A, &bwsr_stat);




Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
