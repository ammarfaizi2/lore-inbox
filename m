Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWGMBOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWGMBOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWGMBOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:14:11 -0400
Received: from xenotime.net ([66.160.160.81]:61907 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932479AbWGMBOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:14:09 -0400
Date: Wed, 12 Jul 2006 18:06:30 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, kjhall@us.ibm.com
Subject: [PATCH] TPM: fix failure path leak
Message-Id: <20060712180630.74955977.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

kfree(devname) on the misc_register() failure path.
Otherwise it is lost forever.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/tpm/tpm.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2618-rc1mm1.orig/drivers/char/tpm/tpm.c
+++ linux-2618-rc1mm1/drivers/char/tpm/tpm.c
@@ -1141,6 +1141,7 @@ struct tpm_chip *tpm_register_hardware(s
 		put_device(dev);
 		clear_bit(chip->dev_num, dev_mask);
 		kfree(chip);
+		kfree(devname);
 		return NULL;
 	}
 


---
