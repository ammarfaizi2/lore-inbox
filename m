Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVG1IMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVG1IMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVG1IC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:02:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:4536 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261350AbVG1Hzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:55:31 -0400
Message-ID: <42E88F4D.8050306@jp.fujitsu.com>
Date: Thu, 28 Jul 2005 16:54:53 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13-rc3 4/6] failure of acpi_register_gsi() should be handled
 properly - change phpacpi driver
References: <42E88DC8.7050507@jp.fujitsu.com>
In-Reply-To: <42E88DC8.7050507@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the error check of acpi_register_gsi() into pnpacpi
driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.13-rc3-kanesige/drivers/pnp/pnpacpi/rsparser.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~handle-error-acpi_register_gsi-pnpacpi drivers/pnp/pnpacpi/rsparser.c
--- linux-2.6.13-rc3/drivers/pnp/pnpacpi/rsparser.c~handle-error-acpi_register_gsi-pnpacpi	2005-07-28 01:01:17.000000000 +0900
+++ linux-2.6.13-rc3-kanesige/drivers/pnp/pnpacpi/rsparser.c	2005-07-28 01:01:17.000000000 +0900
@@ -81,7 +81,7 @@ pnpacpi_parse_allocated_irqresource(stru
 		i++;
 	if (i < PNP_MAX_IRQ) {
 		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
-		if (irq == -1) {
+		if (irq < 0) {
 			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}

_


