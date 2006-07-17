Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWGQQda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWGQQda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWGQQcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:64698 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750956AbWGQQc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:29 -0400
Date: Mon, 17 Jul 2006 09:28:06 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Kylene Hall <kjhall@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 27/45] tpm: interrupt clear fix
Message-ID: <20060717162806.GB4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tpm-interrupt-clear-fix.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
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

--- linux-2.6.17.6.orig/drivers/char/tpm/tpm_tis.c
+++ linux-2.6.17.6/drivers/char/tpm/tpm_tis.c
@@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
 	iowrite32(interrupt,
 		  chip->vendor.iobase +
 		  TPM_INT_STATUS(chip->vendor.locality));
+	mb();
 	return IRQ_HANDLED;
 }
 

--
