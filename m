Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317407AbSFRNkN>; Tue, 18 Jun 2002 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317408AbSFRNkM>; Tue, 18 Jun 2002 09:40:12 -0400
Received: from thufir.bluecom.no ([217.118.32.12]:24588 "EHLO
	thufir.bluecom.no") by vger.kernel.org with ESMTP
	id <S317407AbSFRNkM>; Tue, 18 Jun 2002 09:40:12 -0400
Date: Tue, 18 Jun 2002 15:35:27 +0200
To: linux-kernel@vger.kernel.org
Subject: small 5575 PCI ATM fix
Message-ID: <20020618133527.GA11756@kernelspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Petter <petter@kernelspace.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was grepping through some code, and noticed that the return value
of a kmalloc in iphase.c was not checked.
A patch was sendt to the author, but this was the reply I got:

"Peter Wang is no longer a member of the Interphase team.  Interphase
does support the 5575 PCI ATM adapter with Linux, but for driver enhancements
and fixes, we require a current software warranty contract.  If you
could send me the serial number and / or the MAC address of your adapter, I
can verify your warranty status and have the latest driver sent to you."

I do not care about their driver since I do not have an ATM card, but
the current driver should anyhow be fixed.

Please apply the patch below.

Regards

Petter Wahlman


--- linux-2.4.19-pre10/drivers/atm/iphase.c     Mon Feb 25 20:37:57 2002
+++ linux-2.4.19-pre10-pw/drivers/atm/iphase.c  Tue Jun 18 10:47:02 2002
@@ -2002,6 +2002,10 @@
         }
         iadev->desc_tbl = kmalloc(iadev->num_tx_desc *
                                    sizeof(struct desc_tbl_t),
GFP_KERNEL);
+       if (!iadev->desc_tbl) {
+            printk(KERN_ERR DEV_LABEL " couldn't get mem\n");
+            return -EAGAIN;
+        }

        /* Communication Queues base address */
         i = TX_COMP_Q * iadev->memSize;
