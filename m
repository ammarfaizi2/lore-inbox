Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUFNWxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUFNWxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUFNWxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:53:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40676 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264562AbUFNWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:53:44 -0400
Date: Tue, 15 Jun 2004 00:53:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6: modular scsi/mca_53c9x doesn't work (fwd)
Message-ID: <20040614225335.GP13951@fs.tum.de>
References: <20040614185256.GJ13951@fs.tum.de> <20040614192215.GA5360@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614192215.GA5360@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 08:22:15PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 14, 2004 at 08:52:56PM +0200, Adrian Bunk wrote:
> > The issue described in the mail forwarded below is still present in 
> > 2.6.7-rc3-mm2 (but not specific to -mm).
> > 
> > I'd suggest the following workaround:
> 
> Please add the exports instead.  It'll affect all the other 53C9X-based
> drivers aswell.

This sounds like a better solution.

Patch below.

cu
Adrian

--- linux-2.6.7-rc3-mm2-modular-no-smp/drivers/scsi/NCR53C9x.c.old	2004-06-15 00:44:36.000000000 +0200
+++ linux-2.6.7-rc3-mm2-modular-no-smp/drivers/scsi/NCR53C9x.c	2004-06-15 00:47:23.000000000 +0200
@@ -3646,4 +3646,15 @@
 }
 #endif
 
+EXPORT_SYMBOL(esp_abort);
+EXPORT_SYMBOL(esp_allocate);
+EXPORT_SYMBOL(esp_deallocate);
+EXPORT_SYMBOL(esp_initialize);
+EXPORT_SYMBOL(esp_intr);
+EXPORT_SYMBOL(esp_queue);
+EXPORT_SYMBOL(esp_reset);
+EXPORT_SYMBOL(esp_slave_alloc);
+EXPORT_SYMBOL(esp_slave_destroy);
+EXPORT_SYMBOL(esps_in_use);
+
 MODULE_LICENSE("GPL");
