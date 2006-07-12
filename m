Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWGLVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWGLVBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWGLVBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:01:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:51879 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932235AbWGLVBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:01:47 -0400
Subject: [PATCH] tpm: interrupt clear fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>, akpm@osdl.org
Content-Type: text/plain
Date: Wed, 12 Jul 2006 14:01:53 -0700
Message-Id: <1152738113.5347.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under stress testing I found that the interrupt is not always cleared.
This is a bug and this patch should go into 2.6.18 and 2.6.17.x.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- tcg/tpmdd/drivers/char/tpm/tpm_tis.c	2006-06-07 11:37:08.000000000 -0700
+++ linux-2.6.17/drivers/char/tpm/tpm_tis.c	2006-07-10 12:58:28.000000000 -0700
@@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
 	iowrite32(interrupt,
 		  chip->vendor.iobase +
 		  TPM_INT_STATUS(chip->vendor.locality));
+	mb();
 	return IRQ_HANDLED;
 }
 


