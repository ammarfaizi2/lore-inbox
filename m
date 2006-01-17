Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWAQOCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWAQOCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWAQOCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:02:31 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:21465 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S932153AbWAQOCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:02:30 -0500
Date: Tue, 17 Jan 2006 14:02:22 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: tpmdd_devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15+]: Trusted Platform depends on Security models
Message-ID: <Pine.LNX.4.64.0601171359120.25253@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that "TPM Hardware Support" (CONFIG_TCG_TPM) depends on
"Enable different security models" (CONFIG_SECURITY). Without this last
option, I get:

$ make modules_install
. . .
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map 2.6.16-rc1; fi
WARNING: /lib/modules/2.6.16-rc1/kernel/drivers/char/tpm/tpm_bios.ko needs unknown symbol securityfs_create_dir
WARNING: /lib/modules/2.6.16-rc1/kernel/drivers/char/tpm/tpm_bios.ko needs unknown symbol securityfs_remove
WARNING: /lib/modules/2.6.16-rc1/kernel/drivers/char/tpm/tpm_bios.ko needs unknown symbol securityfs_create_file
$

Regards,

Signed-off-by: Rui Saraiva <rmps@mail.pt>

---

--- linux-2.6.16-rc1/drivers/char/Kconfig	2006-01-17 13:36:14.000000000 +0000
+++ linux-2.6.16-rc1-rmps/drivers/char/Kconfig	2006-01-17 13:36:43.000000000 +0000
@@ -6,7 +6,7 @@ menu "TPM devices"

  config TCG_TPM
  	tristate "TPM Hardware Support"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && SECURITY
  	---help---
  	  If you have a TPM security chip in your system, which
  	  implements the Trusted Computing Group's specification,
