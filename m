Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUHPJWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUHPJWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHPJWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:22:50 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:6853 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S267487AbUHPJWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:22:40 -0400
Subject: [PATCH] Re: acpi shutdown problem on SMP (tyan tiger mp, athlon)
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
References: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1092648198.8494.7.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 11:23:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch fixes poweroff on my Tyan Tiger S2460 - AMP 760 MP mainboard.
I also test ist on my UP ACPI systems and none broke.

Please verify if it breaks poweroff on other systems.

Alexander

diff -u -r -N linux-2.6.8.1/drivers/acpi/hardware/hwsleep.c
linux-2.6.8.1-acpifix/drivers/acpi/hardware/hwsleep.c
--- linux-2.6.8.1/drivers/acpi/hardware/hwsleep.c	2004-08-16
09:53:05.000000000 +0200
+++ linux-2.6.8.1-acpifix/drivers/acpi/hardware/hwsleep.c	2004-08-16
10:00:41.257905209 +0200
@@ -284,6 +284,11 @@
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
+	} else {
+		status = acpi_hw_clear_acpi_status (ACPI_MTX_DO_NOT_LOCK);
+		if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+		}
 	}
 
 	/*

Am Fr, den 13.08.2004 schrieb Alexander Rauth um 7:56:
> this problem first appeared in vanilla-2.6.2 and is still present in
> vanilla-2.6.8-rc4 (vanilla-2.6.1 worked fine)
> 
> on shutdown the disks spin down, the VGA switches to powersave, but the
> cpu-fans and the power-supply won't power down.


