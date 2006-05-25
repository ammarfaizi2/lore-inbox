Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWEYTkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWEYTkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWEYTkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:40:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:5040 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030367AbWEYTkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:40:10 -0400
Subject: [PATCH] tpm: fix bug for TPM on ThinkPad T60 and Z60
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Michael Prokop <prokop@sbox.tugraz.at>,
       Seiji Munetoh <MUNETOH@jp.ibm.com>,
       Leendert Van Doorn <leendert@us.ibm.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 14:38:16 -0500
Message-Id: <1148585896.5317.189.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TPM chip on the ThinkPad T60 and Z60 machines is returning 0xFFFF
for the vendor ID which is a check the driver made to double check it
was actually talking to the memory mapped space of a TPM.  This patch
removes the check since it isn't absolutely necessary and was causing
device discovery to fail on these machines.

This bug fix should go into 2.6.17.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
 tpm_tis.c |    4 ----
 1 files changed, 4 deletions(-)

--- linux-2.6.17-rc3/drivers/char/tpm/tpm_tis.c	2006-05-16 12:33:36.434356500 -0500
+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/tpm_tis.c	2006-05-25 14:52:01.793058750 -0500
@@ -457,10 +457,6 @@ static int __devinit tpm_tis_pnp_init(st
 	}
 
 	vendor = ioread32(chip->vendor.iobase + TPM_DID_VID(0));
-	if ((vendor & 0xFFFF) == 0xFFFF) {
-		rc = -ENODEV;
-		goto out_err;
-	}
 
 	/* Default timeouts */
 	chip->vendor.timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);



