Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVKPS5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVKPS5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVKPS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:57:09 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:26761 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030422AbVKPS5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:57:08 -0500
Message-ID: <437B8102.1090900@ru.mvista.com>
Date: Wed, 16 Nov 2005 21:57:06 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] ppc32: Fix incorrect PCI frequency value
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The time to wait after deasserting PCI_RST has been counted with
incorrect value - this patch fixes the issue.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---

  arch/ppc/syslib/m82xx_pci.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: f571549f6e990531b853304fe9bf74cb488a02ac
ac9eb05c322380b1d11a0271e1507428b95ab994
diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
index 1d1c395..20f1fa3 100644
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
@@ -248,7 +248,8 @@ pq2ads_setup_pci(struct pci_controller *
  	pci_div = ( (sccr & SCCR_PCI_MODCK) ? 2 : 1) *
  			( ( (sccr & SCCR_PCIDF_MSK) >> SCCR_PCIDF_SHIFT) + 1);
  	freq = (uint)((2*binfo->bi_cpmfreq)/(pci_div));
-	time = (int)666666/freq;
+	time = (int)66666666/freq;
+	
  	/* due to PCI Local Bus spec, some devices needs to wait such a long
  	time after RST 	deassertion. More specifically, 0.508s for 66MHz & twice more for 33 */
  	printk("%s: The PCI bus is %d Mhz.\nWaiting %s after deasserting RST...\n",__FILE__,freq,
---
Sincerely,
Vitaly


