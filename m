Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWHUSyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWHUSyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWHUSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:48:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51388 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbWHUSsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:21 -0400
Date: Mon, 21 Aug 2006 11:46:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Kylene Hall <kjhall@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/20] tpm: interrupt clear fix
Message-ID: <20060821184647.GJ21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tpm-interrupt-clear-fix.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kylene Jo Hall <kjhall@us.ibm.com>

Under stress testing I found that the interrupt is not always cleared.
This is a bug and this patch should go into 2.6.18 and 2.6.17.x.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/tpm/tpm_tis.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.8.orig/drivers/char/tpm/tpm_tis.c
+++ linux-2.6.17.8/drivers/char/tpm/tpm_tis.c
@@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
 	iowrite32(interrupt,
 		  chip->vendor.iobase +
 		  TPM_INT_STATUS(chip->vendor.locality));
+	ioread32(chip->vendor.iobase + TPM_INT_STATUS(chip->vendor.locality));
 	return IRQ_HANDLED;
 }
 

--
