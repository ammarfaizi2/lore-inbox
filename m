Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVDIXFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDIXFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDIXFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:05:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58886 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261408AbVDIXEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:04:49 -0400
Date: Sun, 10 Apr 2005 01:04:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: paulsch@us.ibm.com, sullivam@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mwave/tp3780i.c: remove dead code
Message-ID: <20050409230447.GP3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some dead code found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/mwave/tp3780i.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.12-rc2-mm2-full/drivers/char/mwave/tp3780i.c.old	2005-04-09 21:41:37.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/char/mwave/tp3780i.c	2005-04-09 21:42:32.000000000 +0200
@@ -283,13 +283,13 @@
 
 
 
 int tp3780I_EnableDSP(THINKPAD_BD_DATA * pBDData)
 {
 	DSP_3780I_CONFIG_SETTINGS *pSettings = &pBDData->rDspSettings;
-	BOOLEAN bDSPPoweredUp = FALSE, bDSPEnabled = FALSE, bInterruptAllocated = FALSE;
+	BOOLEAN bDSPPoweredUp = FALSE, bInterruptAllocated = FALSE;
 
 	PRINTK_2(TRACE_TP3780I, "tp3780i::tp3780I_EnableDSP entry pBDData %p\n", pBDData);
 
 	if (pBDData->bDSPEnabled) {
 		PRINTK_ERROR(KERN_ERR_MWAVE "tp3780i::tp3780I_EnableDSP: Error: DSP already enabled!\n");
 		goto exit_cleanup;
@@ -388,28 +388,24 @@
 		bDSPPoweredUp = TRUE;
 	}
 
 	if (dsp3780I_EnableDSP(pSettings, s_ausThinkpadIrqToField, s_ausThinkpadDmaToField)) {
 		PRINTK_ERROR("tp3780i::tp3780I_EnableDSP: Error: dsp7880I_EnableDSP() failed\n");
 		goto exit_cleanup;
-	} else {
-		bDSPEnabled = TRUE;
 	}
 
 	EnableSRAM(pBDData);
 
 	pBDData->bDSPEnabled = TRUE;
 
 	PRINTK_1(TRACE_TP3780I, "tp3780i::tp3780I_EnableDSP exit\n");
 
 	return 0;
 
 exit_cleanup:
 	PRINTK_ERROR("tp3780i::tp3780I_EnableDSP: Cleaning up\n");
-	if (bDSPEnabled)
-		dsp3780I_DisableDSP(pSettings);
 	if (bDSPPoweredUp)
 		smapi_set_DSP_power_state(FALSE);
 	if (bInterruptAllocated) {
 		free_irq(pSettings->usDspIrq, NULL);
 		pSettings->bInterruptClaimed = FALSE;
 	}

