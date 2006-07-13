Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWGMTYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWGMTYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWGMTYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:24:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:41145 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030309AbWGMTYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:24:38 -0400
Subject: Re: [PATCH] tpm: interrupt clear fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0607130743370.10732@chaos.analogic.com>
References: <1152738113.5347.33.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0607130743370.10732@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:24:36 -0700
Message-Id: <1152818676.5347.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under stress testing I found that the interrupt is not always cleared.
This is a bug and this patch should go into 2.6.18 and 2.6.17.x.

On Thu, 2006-07-13 at 07:45 -0400, linux-os (Dick Johnson) wrote:

> PCI devices need a final read to flush all pending writes. Whatever
> mb() does, just hides the problem.


Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

--- linux-2.6.18-rc1/drivers/char/tpm/tpm_tis.c	2006-07-13 14:46:39.727500500 -0500
+++ linux-2.6.18-rc1-tpm/drivers/char/tpm/tpm_tis.c	2006-07-13 14:47:33.878884750 -0500
@@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
 	iowrite32(interrupt,
 		  chip->vendor.iobase +
 		  TPM_INT_STATUS(chip->vendor.locality));
+	ioread32(chip->vendor.iobase + TPM_INT_STATUS(chip->vendor.locality));
 	return IRQ_HANDLED;
 }
 


