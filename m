Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVD3UKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVD3UKM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVD3UJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:09:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6927 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261397AbVD3UIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:08:09 -0400
Date: Sat, 30 Apr 2005 22:08:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mwave/3780i.c: cleanups
Message-ID: <20050430200807.GO3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make a needlessly global function static
- #if 0 the unused global function dsp3780I_ReadGenCfg

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

 drivers/char/mwave/3780i.c |    6 ++++--
 drivers/char/mwave/3780i.h |    4 ----
 2 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/char/mwave/3780i.h.old	2005-04-17 18:12:29.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/mwave/3780i.h	2005-04-17 18:13:16.000000000 +0200
@@ -338,10 +338,6 @@
                                    unsigned long ulMsaAddr);
 void dsp3780I_WriteMsaCfg(unsigned short usDspBaseIO,
                           unsigned long ulMsaAddr, unsigned short usValue);
-void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
-                          unsigned char ucValue);
-unsigned char dsp3780I_ReadGenCfg(unsigned short usDspBaseIO,
-                                  unsigned uIndex);
 int dsp3780I_GetIPCSource(unsigned short usDspBaseIO,
                           unsigned short *pusIPCSource);
 
--- linux-2.6.12-rc2-mm3-full/drivers/char/mwave/3780i.c.old	2005-04-17 18:12:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/mwave/3780i.c	2005-04-17 18:13:33.000000000 +0200
@@ -107,8 +107,8 @@
 	spin_unlock_irqrestore(&dsp_lock, flags);
 }
 
-void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
-                          unsigned char ucValue)
+static void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
+				 unsigned char ucValue)
 {
 	DSP_ISA_SLAVE_CONTROL rSlaveControl;
 	DSP_ISA_SLAVE_CONTROL rSlaveControl_Save;
@@ -141,6 +141,7 @@
 
 }
 
+#if 0
 unsigned char dsp3780I_ReadGenCfg(unsigned short usDspBaseIO,
                                   unsigned uIndex)
 {
@@ -167,6 +168,7 @@
 
 	return ucValue;
 }
+#endif  /*  0  */
 
 int dsp3780I_EnableDSP(DSP_3780I_CONFIG_SETTINGS * pSettings,
                        unsigned short *pIrqMap,

