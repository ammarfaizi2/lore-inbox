Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVDQX1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVDQX1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVDQX1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:27:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47109 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261550AbVDQX1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:27:03 -0400
Date: Mon, 18 Apr 2005 01:27:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: thomas@winischhofer.net
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/sis/: make some functions static
Message-ID: <20050417232701.GW3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/sis/init.c     |    4 ++--
 drivers/video/sis/init.h     |    3 ---
 drivers/video/sis/init301.c  |    9 +++++----
 drivers/video/sis/init301.h  |    4 ----
 drivers/video/sis/sis_main.c |    5 +++--
 5 files changed, 10 insertions(+), 15 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.h.old	2005-04-18 00:41:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.h	2005-04-18 00:43:25.000000000 +0200
@@ -2394,11 +2394,9 @@
 void	SiS_DisplayOn(SiS_Private *SiS_Pr);
 void	SiS_DisplayOff(SiS_Private *SiS_Pr);
 void	SiSRegInit(SiS_Private *SiS_Pr, SISIOADDRESS BaseAddr);
-void	SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN SiSDetermineROMLayout661(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SetEnableDstn(SiS_Private *SiS_Pr, int enable);
 void	SiS_SetEnableFstn(SiS_Private *SiS_Pr, int enable);
-void	SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SearchModeID(SiS_Private *SiS_Pr, USHORT *ModeNo, USHORT *ModeIdIndex);
 UCHAR	SiS_GetModePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
 USHORT	SiS_GetColorDepth(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
@@ -2444,7 +2442,6 @@
 extern void     SiS_SetYPbPr(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 extern void 	SiS_SetTVMode(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex, PSIS_HW_INFO HwInfo);
 extern void     SiS_UnLockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-extern void     SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 extern void     SiS_DisableBridge(SiS_Private *, PSIS_HW_INFO);
 extern BOOLEAN  SiS_SetCRT2Group(SiS_Private *, PSIS_HW_INFO, USHORT);
 extern USHORT   SiS_GetRatePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex,
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.c.old	2005-04-18 00:41:47.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.c	2005-04-18 00:42:03.000000000 +0200
@@ -1384,7 +1384,7 @@
 /*             HELPER: SetLVDSetc            */
 /*********************************************/
 
-void
+static void
 SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    USHORT temp;
@@ -1625,7 +1625,7 @@
 /*             HELPER: GetVBType             */
 /*********************************************/
 
-void
+static void
 SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT flag=0, rev=0, nolcd=0, p4_0f, p4_25, p4_27;
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.h.old	2005-04-18 00:42:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.h	2005-04-18 00:43:59.000000000 +0200
@@ -293,7 +293,6 @@
 #endif
 
 void	SiS_UnLockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_EnableCRT2(SiS_Private *SiS_Pr);
 USHORT	SiS_GetRatePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex, PSIS_HW_INFO HwInfo);
 void	SiS_WaitRetrace1(SiS_Private *SiS_Pr);
@@ -310,7 +309,6 @@
                 USHORT RefreshRateTableIndex, PSIS_HW_INFO HwInfo);
 USHORT	SiS_GetResInfo(SiS_Private *SiS_Pr,USHORT ModeNo,USHORT ModeIdIndex);
 void	SiS_DisableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SetCRT2Group(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo, USHORT ModeNo);
 void	SiS_SiS30xBLOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SiS30xBLOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
@@ -319,8 +317,6 @@
 USHORT 	SiS_GetCH700x(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
 USHORT 	SiS_GetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
-void   	SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
-USHORT 	SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH70xxANDOR(SiS_Private *SiS_Pr, USHORT tempax,USHORT tempbh);
 #ifdef SIS315H
 static void   	SiS_Chrontel701xOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.c.old	2005-04-18 00:42:42.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.c	2005-04-18 00:52:32.000000000 +0200
@@ -86,6 +86,7 @@
 #define SiS_I2CDELAYSHORT  150
 
 static USHORT SiS_GetBIOSLCDResInfo(SiS_Private *SiS_Pr);
+static void SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx);
 
 /*********************************************/
 /*         HELPER: Lock/Unlock CRT2          */
@@ -100,7 +101,7 @@
       SiS_SetRegOR(SiS_Pr->SiS_Part1Port,0x24,0x01);
 }
 
-void
+static void
 SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    if(HwInfo->jChipType >= SIS_315H)
@@ -4236,7 +4237,7 @@
  * from outside the context of a mode switch!
  * MUST call getVBType before calling this
  */
-void
+static void
 SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT temp=0,tempah;
@@ -9219,7 +9220,7 @@
   SiS_SetChReg(SiS_Pr, tempbx, 0);
 }
 
-void
+static void
 SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
@@ -9323,7 +9324,7 @@
 
 /* Read from Chrontel 70xx */
 /* Parameter is [Register no (S7-S0)] */
-USHORT
+static USHORT
 SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/sis_main.c.old	2005-04-18 00:45:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/sis_main.c	2005-04-18 00:46:03.000000000 +0200
@@ -4762,7 +4762,8 @@
 #endif
 
 
-int __devinit sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit sisfb_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
 {
 	struct sisfb_chip_info 	*chipinfo = &sisfb_chip_info[ent->driver_data];
 	struct sis_video_info 	*ivideo = NULL;
@@ -5940,7 +5941,7 @@
 #endif
 #endif
 
-int __devinit sisfb_init_module(void)
+static int __devinit sisfb_init_module(void)
 {
 	sisfb_setdefaultparms();
 

