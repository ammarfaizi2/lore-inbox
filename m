Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWALIey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWALIey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWALIey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:34:54 -0500
Received: from [195.144.244.147] ([195.144.244.147]:25505 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1030259AbWALIex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:34:53 -0500
Message-ID: <43C614A5.6030703@varma-el.com>
Date: Thu, 12 Jan 2006 11:34:45 +0300
From: Andrey Volkov <avolkov@varma-el.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [kernel-2.6.15] Fix PCI irq mapping for lite5200
Content-Type: multipart/mixed;
 boundary="------------010607090800000105020007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607090800000105020007
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hi Sylvain,

This patch fix problem of PCI boards irq mapping on lite5200
(raised after your changes of MPC52xx_IRQ0 number)

--
Regards
Andrey Volkov

--------------010607090800000105020007
Content-Type: text/plain;
 name="01-lite5200_map_irq-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-lite5200_map_irq-fix.diff"

	lite5200_map_irq: Fix irq mapping for external PCI boards

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
---

 arch/ppc/platforms/lite5200.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
index 7ed52dc..cd4acb3 100644
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -73,7 +73,8 @@ lite5200_show_cpuinfo(struct seq_file *m
 static int
 lite5200_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
-	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
+	/* Only INTA supported */
+	return (pin == 1) ? MPC52xx_IRQ0 : -1;
 }
 #endif
 

--------------010607090800000105020007--
