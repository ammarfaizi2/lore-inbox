Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbUKUPiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbUKUPiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKUPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:38:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36104 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261319AbUKUPgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:08 -0500
Date: Sun, 21 Nov 2004 16:36:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: thomas@winischhofer.net, Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/video/sis/ cleanups
Message-ID: <20041121153600.GN2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups under drivers/video/sis/ :
- make needlessly global code static
- remove the following unused functions:
  - init.c: SiS_GetModeID
  - init301.c: SiS_{Get,Set}TrumpReg


diffstat output:
 drivers/video/sis/init.c     |  150 -----------------------------------
 drivers/video/sis/init.h     |   91 +++++++++------------
 drivers/video/sis/init301.c  |   87 ++++++--------------
 drivers/video/sis/init301.h  |   66 +++++++--------
 drivers/video/sis/oem300.h   |   26 +++---
 drivers/video/sis/sis_main.c |    6 -
 drivers/video/sis/sis_main.h |   13 +--
 7 files changed, 128 insertions(+), 311 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/init.h.old	2004-11-21 02:15:42.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/init.h	2004-11-21 02:51:52.000000000 +0100
@@ -85,43 +85,43 @@
 #endif
 
 /* Mode numbers */
-const USHORT  ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};
-const USHORT  ModeIndex_320x240[]      = {0x50, 0x56, 0x00, 0x53};
-const USHORT  ModeIndex_320x240_FSTN[] = {0x5a, 0x5b, 0x00, 0x00};  /* FSTN */
-const USHORT  ModeIndex_400x300[]      = {0x51, 0x57, 0x00, 0x54};
-const USHORT  ModeIndex_512x384[]      = {0x52, 0x58, 0x00, 0x5c};
-const USHORT  ModeIndex_640x400[]      = {0x2f, 0x5d, 0x00, 0x5e};
-const USHORT  ModeIndex_640x480[]      = {0x2e, 0x44, 0x00, 0x62};
-const USHORT  ModeIndex_720x480[]      = {0x31, 0x33, 0x00, 0x35};
-const USHORT  ModeIndex_720x576[]      = {0x32, 0x34, 0x00, 0x36};
-const USHORT  ModeIndex_768x576[]      = {0x5f, 0x60, 0x00, 0x61};
-const USHORT  ModeIndex_800x480[]      = {0x70, 0x7a, 0x00, 0x76};
-const USHORT  ModeIndex_800x600[]      = {0x30, 0x47, 0x00, 0x63};
-const USHORT  ModeIndex_848x480[]      = {0x39, 0x3b, 0x00, 0x3e};
-const USHORT  ModeIndex_856x480[]      = {0x3f, 0x42, 0x00, 0x45};
-const USHORT  ModeIndex_960x540[]      = {0x1d, 0x1e, 0x00, 0x1f};  /* 315 series only */
-const USHORT  ModeIndex_1024x768[]     = {0x38, 0x4a, 0x00, 0x64};
-const USHORT  ModeIndex_1024x576[]     = {0x71, 0x74, 0x00, 0x77};
-const USHORT  ModeIndex_1024x600[]     = {0x20, 0x21, 0x00, 0x22};  /* 300 series only */
-const USHORT  ModeIndex_1280x1024[]    = {0x3a, 0x4d, 0x00, 0x65};
-const USHORT  ModeIndex_1280x960[]     = {0x7c, 0x7d, 0x00, 0x7e};
-const USHORT  ModeIndex_1152x768[]     = {0x23, 0x24, 0x00, 0x25};  /* 300 series only */
-const USHORT  ModeIndex_1152x864[]     = {0x29, 0x2a, 0x00, 0x2b};
-const USHORT  ModeIndex_300_1280x768[] = {0x55, 0x5a, 0x00, 0x5b};
-const USHORT  ModeIndex_310_1280x768[] = {0x23, 0x24, 0x00, 0x25};
-const USHORT  ModeIndex_1280x720[]     = {0x79, 0x75, 0x00, 0x78};
-const USHORT  ModeIndex_1280x800[]     = {0x14, 0x15, 0x00, 0x16};
-const USHORT  ModeIndex_1360x768[]     = {0x48, 0x4b, 0x00, 0x4e};
-const USHORT  ModeIndex_300_1360x1024[]= {0x67, 0x6f, 0x00, 0x72};  /* 300 series, BARCO only */
-const USHORT  ModeIndex_1400x1050[]    = {0x26, 0x27, 0x00, 0x28};  /* 315 series only */
-const USHORT  ModeIndex_1680x1050[]    = {0x17, 0x18, 0x00, 0x19};  /* 315 series only */
-const USHORT  ModeIndex_1600x1200[]    = {0x3c, 0x3d, 0x00, 0x66};
-const USHORT  ModeIndex_1920x1080[]    = {0x2c, 0x2d, 0x00, 0x73};  /* 315 series only */
-const USHORT  ModeIndex_1920x1440[]    = {0x68, 0x69, 0x00, 0x6b};
-const USHORT  ModeIndex_300_2048x1536[]= {0x6c, 0x6d, 0x00, 0x00};
-const USHORT  ModeIndex_310_2048x1536[]= {0x6c, 0x6d, 0x00, 0x6e};
+static const USHORT  ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};
+static const USHORT  ModeIndex_320x240[]      = {0x50, 0x56, 0x00, 0x53};
+static const USHORT  ModeIndex_320x240_FSTN[] = {0x5a, 0x5b, 0x00, 0x00};  /* FSTN */
+static const USHORT  ModeIndex_400x300[]      = {0x51, 0x57, 0x00, 0x54};
+static const USHORT  ModeIndex_512x384[]      = {0x52, 0x58, 0x00, 0x5c};
+static const USHORT  ModeIndex_640x400[]      = {0x2f, 0x5d, 0x00, 0x5e};
+static const USHORT  ModeIndex_640x480[]      = {0x2e, 0x44, 0x00, 0x62};
+static const USHORT  ModeIndex_720x480[]      = {0x31, 0x33, 0x00, 0x35};
+static const USHORT  ModeIndex_720x576[]      = {0x32, 0x34, 0x00, 0x36};
+static const USHORT  ModeIndex_768x576[]      = {0x5f, 0x60, 0x00, 0x61};
+static const USHORT  ModeIndex_800x480[]      = {0x70, 0x7a, 0x00, 0x76};
+static const USHORT  ModeIndex_800x600[]      = {0x30, 0x47, 0x00, 0x63};
+static const USHORT  ModeIndex_848x480[]      = {0x39, 0x3b, 0x00, 0x3e};
+static const USHORT  ModeIndex_856x480[]      = {0x3f, 0x42, 0x00, 0x45};
+static const USHORT  ModeIndex_960x540[]      = {0x1d, 0x1e, 0x00, 0x1f};  /* 315 series only */
+static const USHORT  ModeIndex_1024x768[]     = {0x38, 0x4a, 0x00, 0x64};
+static const USHORT  ModeIndex_1024x576[]     = {0x71, 0x74, 0x00, 0x77};
+static const USHORT  ModeIndex_1024x600[]     = {0x20, 0x21, 0x00, 0x22};  /* 300 series only */
+static const USHORT  ModeIndex_1280x1024[]    = {0x3a, 0x4d, 0x00, 0x65};
+static const USHORT  ModeIndex_1280x960[]     = {0x7c, 0x7d, 0x00, 0x7e};
+static const USHORT  ModeIndex_1152x768[]     = {0x23, 0x24, 0x00, 0x25};  /* 300 series only */
+static const USHORT  ModeIndex_1152x864[]     = {0x29, 0x2a, 0x00, 0x2b};
+static const USHORT  ModeIndex_300_1280x768[] = {0x55, 0x5a, 0x00, 0x5b};
+static const USHORT  ModeIndex_310_1280x768[] = {0x23, 0x24, 0x00, 0x25};
+static const USHORT  ModeIndex_1280x720[]     = {0x79, 0x75, 0x00, 0x78};
+static const USHORT  ModeIndex_1280x800[]     = {0x14, 0x15, 0x00, 0x16};
+static const USHORT  ModeIndex_1360x768[]     = {0x48, 0x4b, 0x00, 0x4e};
+static const USHORT  ModeIndex_300_1360x1024[]= {0x67, 0x6f, 0x00, 0x72};  /* 300 series, BARCO only */
+static const USHORT  ModeIndex_1400x1050[]    = {0x26, 0x27, 0x00, 0x28};  /* 315 series only */
+static const USHORT  ModeIndex_1680x1050[]    = {0x17, 0x18, 0x00, 0x19};  /* 315 series only */
+static const USHORT  ModeIndex_1600x1200[]    = {0x3c, 0x3d, 0x00, 0x66};
+static const USHORT  ModeIndex_1920x1080[]    = {0x2c, 0x2d, 0x00, 0x73};  /* 315 series only */
+static const USHORT  ModeIndex_1920x1440[]    = {0x68, 0x69, 0x00, 0x6b};
+static const USHORT  ModeIndex_300_2048x1536[]= {0x6c, 0x6d, 0x00, 0x00};
+static const USHORT  ModeIndex_310_2048x1536[]= {0x6c, 0x6d, 0x00, 0x6e};
 
-const USHORT SiS_DRAMType[17][5]={
+static const USHORT SiS_DRAMType[17][5]={
 	{0x0C,0x0A,0x02,0x40,0x39},
 	{0x0D,0x0A,0x01,0x40,0x48},
 	{0x0C,0x09,0x02,0x20,0x35},
@@ -141,7 +141,7 @@
 	{0x09,0x08,0x01,0x01,0x00}
 };
 
-const USHORT SiS_SDRDRAM_TYPE[13][5] =
+static const USHORT SiS_SDRDRAM_TYPE[13][5] =
 {
 	{ 2,12, 9,64,0x35},
 	{ 1,13, 9,64,0x44},
@@ -158,7 +158,7 @@
 	{ 1, 9, 8, 2,0x00}
 };
 
-const USHORT SiS_DDRDRAM_TYPE[4][5] =
+static const USHORT SiS_DDRDRAM_TYPE[4][5] =
 {
 	{ 2,12, 9,64,0x35},
 	{ 2,12, 8,32,0x31},
@@ -166,7 +166,7 @@
 	{ 2, 9, 8, 4,0x01}
 };
 
-const USHORT SiS_MDA_DAC[] =
+static const USHORT SiS_MDA_DAC[] =
 {
 	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
         0x15,0x15,0x15,0x15,0x15,0x15,0x15,0x15,
@@ -178,7 +178,7 @@
         0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F
 };
 
-const USHORT SiS_CGA_DAC[] =
+static const USHORT SiS_CGA_DAC[] =
 {
         0x00,0x10,0x04,0x14,0x01,0x11,0x09,0x15,
         0x00,0x10,0x04,0x14,0x01,0x11,0x09,0x15,
@@ -190,7 +190,7 @@
         0x2A,0x3A,0x2E,0x3E,0x2B,0x3B,0x2F,0x3F
 };
 
-const USHORT SiS_EGA_DAC[] =
+static const USHORT SiS_EGA_DAC[] =
 {
         0x00,0x10,0x04,0x14,0x01,0x11,0x05,0x15,
         0x20,0x30,0x24,0x34,0x21,0x31,0x25,0x35,
@@ -202,7 +202,7 @@
         0x2A,0x3A,0x2E,0x3E,0x2B,0x3B,0x2F,0x3F
 };
 
-const USHORT SiS_VGA_DAC[] =
+static const USHORT SiS_VGA_DAC[] =
 {
 	0x00,0x10,0x04,0x14,0x01,0x11,0x09,0x15,
 	0x2A,0x3A,0x2E,0x3E,0x2B,0x3B,0x2F,0x3F,
@@ -2361,10 +2361,6 @@
    { 0x0000 }
 };
 
-USHORT  SiS_GetModeID(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay,
-			  int Depth, BOOLEAN FSTN, int LCDwith, int LCDheight);
-USHORT  SiS_GetModeID_LCD(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay, int Depth, BOOLEAN FSTN,
-                          USHORT CustomT, int LCDwith, int LCDheight);
 USHORT  SiS_GetModeID_TV(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay, int Depth);
 USHORT  SiS_GetModeID_VGA2(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay, int Depth);
 
@@ -2382,12 +2378,9 @@
 void	SiS_DisplayOn(SiS_Private *SiS_Pr);
 void	SiS_DisplayOff(SiS_Private *SiS_Pr);
 void	SiSRegInit(SiS_Private *SiS_Pr, SISIOADDRESS BaseAddr);
-void	SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN SiSDetermineROMLayout661(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SetEnableDstn(SiS_Private *SiS_Pr, int enable);
 void	SiS_SetEnableFstn(SiS_Private *SiS_Pr, int enable);
-void	SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-USHORT	SiS_GetMCLK(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SearchModeID(SiS_Private *SiS_Pr, USHORT *ModeNo, USHORT *ModeIdIndex);
 UCHAR	SiS_GetModePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
 USHORT	SiS_GetColorDepth(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/init.c.old	2004-11-21 02:19:18.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/init.c	2004-11-21 02:51:44.000000000 +0100
@@ -608,150 +608,6 @@
    }
 }
 
-/*********************************************/
-/*            HELPER: Get ModeID             */
-/*********************************************/
-
-USHORT
-SiS_GetModeID(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay,
-              int Depth, BOOLEAN FSTN, int LCDwidth, int LCDheight)
-{
-   USHORT ModeIndex = 0;
-
-   switch(HDisplay)
-   {
-     case 320:
-     	  if(VDisplay == 200)     ModeIndex = ModeIndex_320x200[Depth];
-	  else if(VDisplay == 240) {
-	     if(FSTN) ModeIndex = ModeIndex_320x240_FSTN[Depth];
-	     else     ModeIndex = ModeIndex_320x240[Depth];
-          }
-          break;
-     case 400:
-          if(VDisplay == 300) ModeIndex = ModeIndex_400x300[Depth];
-          break;
-     case 512:
-          if(VDisplay == 384) ModeIndex = ModeIndex_512x384[Depth];
-          break;
-     case 640:
-          if(VDisplay == 480)      ModeIndex = ModeIndex_640x480[Depth];
-	  else if(VDisplay == 400) ModeIndex = ModeIndex_640x400[Depth];
-          break;
-     case 720:
-          if(VDisplay == 480)      ModeIndex = ModeIndex_720x480[Depth];
-          else if(VDisplay == 576) ModeIndex = ModeIndex_720x576[Depth];
-          break;
-     case 768:
-          if(VDisplay == 576) ModeIndex = ModeIndex_768x576[Depth];
-	  break;
-     case 800:
-	  if(VDisplay == 600)      ModeIndex = ModeIndex_800x600[Depth];
-	  else if(VDisplay == 480) ModeIndex = ModeIndex_800x480[Depth];
-          break;
-     case 848:
-	  if(VDisplay == 480) ModeIndex = ModeIndex_848x480[Depth];
-	  break;
-     case 856:
-	  if(VDisplay == 480) ModeIndex = ModeIndex_856x480[Depth];
-	  break;
-     case 960:
-	  if(VGAEngine == SIS_315_VGA) {
-	     if(VDisplay == 540) ModeIndex = ModeIndex_960x540[Depth];
-	  }
-	  break;
-     case 1024:
-          if(VDisplay == 768)      ModeIndex = ModeIndex_1024x768[Depth];
-	  else if(VDisplay == 576) ModeIndex = ModeIndex_1024x576[Depth];
-	  else if((!(VBFlags & CRT1_LCDA)) && (VGAEngine == SIS_300_VGA)) {
-	     if(VDisplay == 600) ModeIndex = ModeIndex_1024x600[Depth];
-	  }
-          break;
-     case 1152:
-          if(VDisplay == 864) ModeIndex = ModeIndex_1152x864[Depth];
-          if((!(VBFlags & CRT1_LCDA)) && (VGAEngine == SIS_300_VGA)) {
-	     if(VDisplay == 768) ModeIndex = ModeIndex_1152x768[Depth];
-	  }
-	  break;
-     case 1280:
-          if(VDisplay == 1024) ModeIndex = ModeIndex_1280x1024[Depth];
-	  else if(VDisplay == 800) {
-	     if(VGAEngine == SIS_315_VGA) {
-	        if((VBFlags & CRT1_LCDA) && (LCDwidth == 1280) && (LCDheight == 800)) {
-	           ModeIndex = ModeIndex_1280x800[Depth];
-	        } else if(!(VBFlags & CRT1_LCDA)) {
-	           ModeIndex = ModeIndex_1280x800[Depth];
-	        }
-	     }
-	  } else if(VDisplay == 720) {
-	     if((VBFlags & CRT1_LCDA) && (LCDwidth == 1280) && (LCDheight == 720)) {
-	        ModeIndex = ModeIndex_1280x720[Depth];
-	     } else if(!(VBFlags & CRT1_LCDA)) {
-	        ModeIndex = ModeIndex_1280x720[Depth];
-	     }
-	  } else if(!(VBFlags & CRT1_LCDA)) {
-             if(VDisplay == 960) ModeIndex = ModeIndex_1280x960[Depth];
-	     else if(VDisplay == 768) {
-	        if(VGAEngine == SIS_300_VGA) {
-	           ModeIndex = ModeIndex_300_1280x768[Depth];
-	        } else {
-	           ModeIndex = ModeIndex_310_1280x768[Depth];
-	        }
-	     }
-	  }
-          break;
-     case 1360:
-          if(VDisplay == 768) ModeIndex = ModeIndex_1360x768[Depth];
-          if(!(VBFlags & CRT1_LCDA)) {
-	     if(VGAEngine == SIS_300_VGA) {
-	        if(VDisplay == 1024) ModeIndex = ModeIndex_300_1360x1024[Depth];
-             }
-	  }
-          break;
-     case 1400:
-          if(VGAEngine == SIS_315_VGA) {
-	     if(VDisplay == 1050) {
-	        if((VBFlags & CRT1_LCDA) &&
-	           (((LCDwidth == 1400) && (LCDheight == 1050)) ||
-		    ((LCDwidth == 1600) && (LCDheight == 1200)))) {
-	           ModeIndex = ModeIndex_1400x1050[Depth];
-	        } else if(!(VBFlags & CRT1_LCDA)) {
-	           ModeIndex = ModeIndex_1400x1050[Depth];
-	        }
-	     }
-	  }
-          break;
-     case 1600:
-          if(VDisplay == 1200) ModeIndex = ModeIndex_1600x1200[Depth];
-          break;
-     case 1680:
-          if(VGAEngine == SIS_315_VGA) {
-             if(VDisplay == 1050) ModeIndex = ModeIndex_1680x1050[Depth];
-	  }
-          break;
-     case 1920:
-          if(!(VBFlags & CRT1_LCDA)) {
-	     if(VGAEngine == SIS_315_VGA) {
-	        if(VDisplay == 1080) ModeIndex = ModeIndex_1920x1080[Depth];
-	     }
-             if(VDisplay == 1440) ModeIndex = ModeIndex_1920x1440[Depth];
-	  }
-          break;
-     case 2048:
-          if(!(VBFlags & CRT1_LCDA)) {
-             if(VDisplay == 1536) {
-                if(VGAEngine == SIS_300_VGA) {
-	            ModeIndex = ModeIndex_300_2048x1536[Depth];
-  	        } else {
-	            ModeIndex = ModeIndex_310_2048x1536[Depth];
-                }
-	     }
-	  }
-          break;
-   }
-
-   return(ModeIndex);
-}
-
 USHORT
 SiS_GetModeID_LCD(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay,
                   int Depth, BOOLEAN FSTN, USHORT CustomT, int LCDwidth, int LCDheight)
@@ -1429,7 +1285,7 @@
 /*             HELPER: SetLVDSetc            */
 /*********************************************/
 
-void
+static void
 SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    USHORT temp;
@@ -1658,7 +1514,7 @@
 /*             HELPER: GetVBType             */
 /*********************************************/
 
-void
+static void
 SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT flag=0, rev=0, nolcd=0;
@@ -1771,7 +1627,7 @@
    return data;
 }
 
-USHORT
+static USHORT
 SiS_GetMCLK(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   UCHAR  *ROMAddr  = HwInfo->pjVirtualRomBase;
--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/init301.h.old	2004-11-21 02:21:35.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/init301.h	2004-11-21 02:52:07.000000000 +0100
@@ -82,7 +82,7 @@
 #endif
 #endif
 
-const UCHAR SiS_YPbPrTable[3][64] = {
+static const UCHAR SiS_YPbPrTable[3][64] = {
   {
     0x17,0x1d,0x03,0x09,0x05,0x06,0x0c,0x0c,
     0x94,0x49,0x01,0x0a,0x06,0x0d,0x04,0x0a,
@@ -127,7 +127,7 @@
   }
 };
 
-const UCHAR SiS_HiTVGroup3_1[] = {
+static const UCHAR SiS_HiTVGroup3_1[] = {
     0x00, 0x14, 0x15, 0x25, 0x55, 0x15, 0x0b, 0x13,
     0xb1, 0x41, 0x62, 0x62, 0xff, 0xf4, 0x45, 0xa6,
     0x25, 0x2f, 0x67, 0xf6, 0xbf, 0xff, 0x8e, 0x20,
@@ -138,7 +138,7 @@
     0x1a, 0x1f, 0x25, 0x2a, 0x4c, 0xaa, 0x01
 };
 
-const UCHAR SiS_HiTVGroup3_2[] = {
+static const UCHAR SiS_HiTVGroup3_2[] = {
     0x00, 0x14, 0x15, 0x25, 0x55, 0x15, 0x0b, 0x7a,
     0x54, 0x41, 0xe7, 0xe7, 0xff, 0xf4, 0x45, 0xa6,
     0x25, 0x2f, 0x67, 0xf6, 0xbf, 0xff, 0x8e, 0x20,
@@ -300,7 +300,7 @@
 #endif
 
 void	SiS_UnLockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
+static	void	SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_EnableCRT2(SiS_Private *SiS_Pr);
 USHORT	SiS_GetRatePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex, PSIS_HW_INFO HwInfo);
 void	SiS_WaitRetrace1(SiS_Private *SiS_Pr);
@@ -317,7 +317,7 @@
                 USHORT RefreshRateTableIndex, PSIS_HW_INFO HwInfo);
 USHORT	SiS_GetResInfo(SiS_Private *SiS_Pr,USHORT ModeNo,USHORT ModeIdIndex);
 void	SiS_DisableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
+static	void	SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SetCRT2Group(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo, USHORT ModeNo);
 void	SiS_SiS30xBLOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SiS30xBLOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
@@ -326,43 +326,41 @@
 USHORT 	SiS_GetCH700x(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
 USHORT 	SiS_GetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
-void   	SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
-USHORT 	SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
+static	void   	SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
+static	USHORT 	SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH70xxANDOR(SiS_Private *SiS_Pr, USHORT tempax,USHORT tempbh);
 #ifdef SIS315H
-void   	SiS_Chrontel701xOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void   	SiS_Chrontel701xOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void   	SiS_ChrontelInitTVVSync(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void   	SiS_ChrontelDoSomething1(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
+static	void   	SiS_Chrontel701xOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
+static	void   	SiS_Chrontel701xOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
+static	void   	SiS_ChrontelInitTVVSync(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
+static	void   	SiS_ChrontelDoSomething1(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void   	SiS_Chrontel701xBLOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void   	SiS_Chrontel701xBLOff(SiS_Private *SiS_Pr);
 #endif /* 315 */
 #ifdef SIS300
-void    SiS_SetTrumpReg(SiS_Private *SiS_Pr, USHORT tempbx);
-USHORT  SiS_GetTrumpReg(SiS_Private *SiS_Pr, USHORT tempbx);
 static  BOOLEAN SiS_SetTrumpionBlock(SiS_Private *SiS_Pr, UCHAR *dataptr);
 #endif
 
 USHORT  SiS_ReadDDC1Bit(SiS_Private *SiS_Pr);
-void    SiS_SetSwitchDDC2(SiS_Private *SiS_Pr);
-USHORT  SiS_SetStart(SiS_Private *SiS_Pr);
-USHORT  SiS_SetStop(SiS_Private *SiS_Pr);
+static	void    SiS_SetSwitchDDC2(SiS_Private *SiS_Pr);
+static	USHORT  SiS_SetStart(SiS_Private *SiS_Pr);
+static	USHORT  SiS_SetStop(SiS_Private *SiS_Pr);
 void    SiS_DDC2Delay(SiS_Private *SiS_Pr, USHORT delaytime);
-USHORT  SiS_SetSCLKLow(SiS_Private *SiS_Pr);
-USHORT  SiS_SetSCLKHigh(SiS_Private *SiS_Pr);
-USHORT  SiS_ReadDDC2Data(SiS_Private *SiS_Pr, USHORT tempax);
-USHORT  SiS_WriteDDC2Data(SiS_Private *SiS_Pr, USHORT tempax);
-USHORT  SiS_CheckACK(SiS_Private *SiS_Pr);
+static	USHORT  SiS_SetSCLKLow(SiS_Private *SiS_Pr);
+static	USHORT  SiS_SetSCLKHigh(SiS_Private *SiS_Pr);
+static	USHORT  SiS_ReadDDC2Data(SiS_Private *SiS_Pr, USHORT tempax);
+static	USHORT  SiS_WriteDDC2Data(SiS_Private *SiS_Pr, USHORT tempax);
+static	USHORT  SiS_CheckACK(SiS_Private *SiS_Pr);
 
-USHORT  SiS_InitDDCRegs(SiS_Private *SiS_Pr, unsigned long VBFlags, int VGAEngine,
+static	USHORT  SiS_InitDDCRegs(SiS_Private *SiS_Pr, unsigned long VBFlags, int VGAEngine,
                         USHORT adaptnum, USHORT DDCdatatype, BOOLEAN checkcr32);
-USHORT  SiS_WriteDABDDC(SiS_Private *SiS_Pr);
-USHORT  SiS_PrepareReadDDC(SiS_Private *SiS_Pr);
-USHORT  SiS_PrepareDDC(SiS_Private *SiS_Pr);
-void    SiS_SendACK(SiS_Private *SiS_Pr, USHORT yesno);
-USHORT  SiS_DoProbeDDC(SiS_Private *SiS_Pr);
-USHORT  SiS_ProbeDDC(SiS_Private *SiS_Pr);
-USHORT  SiS_ReadDDC(SiS_Private *SiS_Pr, USHORT DDCdatatype, unsigned char *buffer);
+static	USHORT  SiS_WriteDABDDC(SiS_Private *SiS_Pr);
+static	USHORT  SiS_PrepareReadDDC(SiS_Private *SiS_Pr);
+static	USHORT  SiS_PrepareDDC(SiS_Private *SiS_Pr);
+static	void    SiS_SendACK(SiS_Private *SiS_Pr, USHORT yesno);
+static	USHORT  SiS_DoProbeDDC(SiS_Private *SiS_Pr);
+static	USHORT  SiS_ProbeDDC(SiS_Private *SiS_Pr);
+static	USHORT  SiS_ReadDDC(SiS_Private *SiS_Pr, USHORT DDCdatatype, unsigned char *buffer);
 USHORT  SiS_HandleDDC(SiS_Private *SiS_Pr, unsigned long VBFlags, int VGAEngine,
 		      USHORT adaptnum, USHORT DDCdatatype, unsigned char *buffer);
 #ifdef LINUX_XF86
@@ -371,16 +369,16 @@
 #endif
 
 #ifdef SIS315H
-void    SiS_OEM310Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
+static	void    SiS_OEM310Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
                           USHORT ModeNo,USHORT ModeIdIndex);
-void    SiS_OEM661Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
+static	void    SiS_OEM661Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
                           USHORT ModeNo,USHORT ModeIdIndex, USHORT RRTI);
-void    SiS_FinalizeLCD(SiS_Private *, USHORT, USHORT, PSIS_HW_INFO);
+static	void    SiS_FinalizeLCD(SiS_Private *, USHORT, USHORT, PSIS_HW_INFO);
 #endif
 #ifdef SIS300
-void    SiS_OEM300Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
+static	void    SiS_OEM300Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
                           USHORT ModeNo, USHORT ModeIdIndex, USHORT RefTabindex);
-void    SetOEMLCDData2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
+static	void    SetOEMLCDData2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
 		       USHORT ModeNo, USHORT ModeIdIndex,USHORT RefTableIndex);
 #endif
 
--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/init301.c.old	2004-11-21 02:21:40.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/init301.c	2004-11-21 02:58:18.000000000 +0100
@@ -100,7 +100,7 @@
       SiS_SetRegOR(SiS_Pr->SiS_Part1Port,0x24,0x01);
 }
 
-void
+static void
 SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    if(HwInfo->jChipType >= SIS_315H)
@@ -4086,7 +4086,7 @@
  * from outside the context of a mode switch!
  * MUST call getVBType before calling this
  */
-void
+static void
 SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT temp=0,tempah;
@@ -8376,7 +8376,7 @@
   SiS_SetCH701x(SiS_Pr,(temp1 << 8) | 0x49);
 }
 
-void
+static void
 SiS_Chrontel701xOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT temp;
@@ -8421,7 +8421,7 @@
   }
 }
 
-void
+static void
 SiS_Chrontel701xOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT temp;
@@ -8494,7 +8494,7 @@
      }
 }
 
-void
+static void
 SiS_ChrontelInitTVVSync(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
      USHORT temp;
@@ -8620,7 +8620,7 @@
     SiS_SetCH701x(SiS_Pr,0x0077);  /* MV? */
 }
 
-void
+static void
 SiS_ChrontelDoSomething1(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
      USHORT temp;
@@ -9008,20 +9008,6 @@
   return FALSE;
 }
 
-#ifdef SIS300
-/* Write Trumpion register */
-void
-SiS_SetTrumpReg(SiS_Private *SiS_Pr, USHORT tempbx)
-{
-  SiS_Pr->SiS_DDC_DeviceAddr = 0xF0;  		/* DAB (Device Address Byte) */
-  SiS_Pr->SiS_DDC_Index = 0x11;			/* Bit 0 = SC;  Bit 1 = SD */
-  SiS_Pr->SiS_DDC_Data  = 0x02;              	/* Bitmask in IndexReg for Data */
-  SiS_Pr->SiS_DDC_Clk   = 0x01;              	/* Bitmask in IndexReg for Clk */
-  SiS_SetupDDCN(SiS_Pr);
-  SiS_SetChReg(SiS_Pr, tempbx, 0);
-}
-#endif
-
 /* Write to Chrontel 700x */
 /* Parameter is [Data (S15-S8) | Register no (S7-S0)] */
 void
@@ -9060,7 +9046,7 @@
   SiS_SetChReg(SiS_Pr, tempbx, 0);
 }
 
-void
+static void
 SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
@@ -9098,21 +9084,6 @@
   return 0xFFFF;
 }
 
-#ifdef SIS300
-/* Read from Trumpion */
-USHORT
-SiS_GetTrumpReg(SiS_Private *SiS_Pr, USHORT tempbx)
-{
-  SiS_Pr->SiS_DDC_DeviceAddr = 0xF0;	/* DAB */
-  SiS_Pr->SiS_DDC_Index = 0x11;		/* Bit 0 = SC;  Bit 1 = SD */
-  SiS_Pr->SiS_DDC_Data  = 0x02;         /* Bitmask in IndexReg for Data */
-  SiS_Pr->SiS_DDC_Clk   = 0x01;         /* Bitmask in IndexReg for Clk */
-  SiS_SetupDDCN(SiS_Pr);
-  SiS_Pr->SiS_DDC_ReadAddr = tempbx;
-  return(SiS_GetChReg(SiS_Pr,0));
-}
-#endif
-
 /* Read from Chrontel 700x */
 /* Parameter is [Register no (S7-S0)] */
 USHORT
@@ -9162,7 +9133,7 @@
 
 /* Read from Chrontel 70xx */
 /* Parameter is [Register no (S7-S0)] */
-USHORT
+static USHORT
 SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
@@ -9172,7 +9143,7 @@
 }
 
 /* Our own DDC functions */
-USHORT
+static USHORT
 SiS_InitDDCRegs(SiS_Private *SiS_Pr, unsigned long VBFlags, int VGAEngine,
                 USHORT adaptnum, USHORT DDCdatatype, BOOLEAN checkcr32)
 {
@@ -9286,7 +9257,7 @@
     return 0;
 }
 
-USHORT
+static USHORT
 SiS_WriteDABDDC(SiS_Private *SiS_Pr)
 {
    if(SiS_SetStart(SiS_Pr)) return 0xFFFF;
@@ -9299,7 +9270,7 @@
    return(0);
 }
 
-USHORT
+static USHORT
 SiS_PrepareReadDDC(SiS_Private *SiS_Pr)
 {
    if(SiS_SetStart(SiS_Pr)) return 0xFFFF;
@@ -9309,7 +9280,7 @@
    return(0);
 }
 
-USHORT
+static USHORT
 SiS_PrepareDDC(SiS_Private *SiS_Pr)
 {
    if(SiS_WriteDABDDC(SiS_Pr)) SiS_WriteDABDDC(SiS_Pr);
@@ -9317,7 +9288,7 @@
    return(0);
 }
 
-void
+static void
 SiS_SendACK(SiS_Private *SiS_Pr, USHORT yesno)
 {
    SiS_SetSCLKLow(SiS_Pr);
@@ -9335,7 +9306,7 @@
    SiS_SetSCLKHigh(SiS_Pr);
 }
 
-USHORT
+static USHORT
 SiS_DoProbeDDC(SiS_Private *SiS_Pr)
 {
     unsigned char mask, value;
@@ -9385,7 +9356,7 @@
     return(ret);
 }
 
-USHORT
+static USHORT
 SiS_ProbeDDC(SiS_Private *SiS_Pr)
 {
    USHORT flag;
@@ -9401,7 +9372,7 @@
    return(flag);
 }
 
-USHORT
+static USHORT
 SiS_ReadDDC(SiS_Private *SiS_Pr, USHORT DDCdatatype, unsigned char *buffer)
 {
    USHORT flag, length, i;
@@ -10232,7 +10203,7 @@
 
 /* Generic I2C functions for Chrontel & DDC --------- */
 
-void
+static void
 SiS_SetSwitchDDC2(SiS_Private *SiS_Pr)
 {
   SiS_SetSCLKHigh(SiS_Pr);
@@ -10251,7 +10222,7 @@
 
 /* Set I2C start condition */
 /* This is done by a SD high-to-low transition while SC is high */
-USHORT
+static USHORT
 SiS_SetStart(SiS_Private *SiS_Pr)
 {
   if(SiS_SetSCLKLow(SiS_Pr)) return 0xFFFF;			           /* (SC->low)  */
@@ -10270,7 +10241,7 @@
 
 /* Set I2C stop condition */
 /* This is done by a SD low-to-high transition while SC is high */
-USHORT
+static USHORT
 SiS_SetStop(SiS_Private *SiS_Pr)
 {
   if(SiS_SetSCLKLow(SiS_Pr)) return 0xFFFF;			           /* (SC->low) */
@@ -10288,7 +10259,7 @@
 }
 
 /* Write 8 bits of data */
-USHORT
+static USHORT
 SiS_WriteDDC2Data(SiS_Private *SiS_Pr, USHORT tempax)
 {
   USHORT i,flag,temp;
@@ -10314,7 +10285,7 @@
   return(temp);
 }
 
-USHORT
+static USHORT
 SiS_ReadDDC2Data(SiS_Private *SiS_Pr, USHORT tempax)
 {
   USHORT i,temp,getdata;
@@ -10334,7 +10305,7 @@
   return(getdata);
 }
 
-USHORT
+static USHORT
 SiS_SetSCLKLow(SiS_Private *SiS_Pr)
 {
   SiS_SetRegANDOR(SiS_Pr->SiS_DDC_Port,
@@ -10345,7 +10316,7 @@
   return 0;
 }
 
-USHORT
+static USHORT
 SiS_SetSCLKHigh(SiS_Private *SiS_Pr)
 {
   USHORT temp, watchdog=1000;
@@ -10369,7 +10340,7 @@
 
 /* Check I2C acknowledge */
 /* Returns 0 if ack ok, non-0 if ack not ok */
-USHORT
+static USHORT
 SiS_CheckACK(SiS_Private *SiS_Pr)
 {
   USHORT tempah;
@@ -11075,7 +11046,7 @@
   }
 }
 
-void
+static void
 SiS_OEM310Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
                   USHORT ModeNo,USHORT ModeIdIndex)
 {
@@ -11279,7 +11250,7 @@
    }
 }
 
-void
+static void
 SiS_OEM661Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
                   USHORT ModeNo,USHORT ModeIdIndex, USHORT RRTI)
 {
@@ -11310,7 +11281,7 @@
  * function looks quite different in every BIOS, so you better
  * pray that we have a backup...
  */
-void
+static void
 SiS_FinalizeLCD(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex,
                 PSIS_HW_INFO HwInfo)
 {
@@ -11514,7 +11485,7 @@
 
 #ifdef SIS300
 
-void
+static void
 SetOEMLCDData2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
                USHORT ModeNo,USHORT ModeIdIndex, USHORT RefTabIndex)
 {
@@ -11914,7 +11885,7 @@
    return ModeIdIndex;
 }
 
-void
+static void
 SiS_OEM300Setting(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo,
 		  USHORT ModeNo, USHORT ModeIdIndex, USHORT RefTableIndex)
 {
--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/oem300.h.old	2004-11-21 02:49:53.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/oem300.h	2004-11-21 02:25:22.000000000 +0100
@@ -50,7 +50,7 @@
  *
  */
 
-const UCHAR SiS300_OEMTVDelay301[8][4] =
+static const UCHAR SiS300_OEMTVDelay301[8][4] =
 {
 	{0x08,0x08,0x08,0x08},
 	{0x08,0x08,0x08,0x08},
@@ -62,7 +62,7 @@
 	{0x20,0x20,0x20,0x20}
 };
 
-const UCHAR SiS300_OEMTVDelayLVDS[8][4] =
+static const UCHAR SiS300_OEMTVDelayLVDS[8][4] =
 {
 	{0x20,0x20,0x20,0x20},
 	{0x20,0x20,0x20,0x20},
@@ -74,7 +74,7 @@
 	{0x20,0x20,0x20,0x20}
 };
 
-const UCHAR SiS300_OEMTVFlicker[8][4] =
+static const UCHAR SiS300_OEMTVFlicker[8][4] =
 {
 	{0x00,0x00,0x00,0x00},
 	{0x00,0x00,0x00,0x00},
@@ -87,7 +87,7 @@
 };
 
 #if 0   /* TW: Not used */
-const UCHAR SiS300_OEMLCDDelay1[12][4]={
+static const UCHAR SiS300_OEMLCDDelay1[12][4]={
 	{0x2c,0x2c,0x2c,0x2c},
 	{0x20,0x20,0x20,0x20},
 	{0x20,0x20,0x20,0x20},
@@ -104,7 +104,7 @@
 #endif
 
 /* TW: From 630/301B BIOS */
-const UCHAR SiS300_OEMLCDDelay2[64][4] =		 /* for 301/301b/302b/301LV/302LV */
+static const UCHAR SiS300_OEMLCDDelay2[64][4] =		 /* for 301/301b/302b/301LV/302LV */
 {
 	{0x20,0x20,0x20,0x20},
 	{0x20,0x20,0x20,0x20},
@@ -173,7 +173,7 @@
 };
 
 /* TW: From 300/301LV BIOS */
-const UCHAR SiS300_OEMLCDDelay4[12][4] =
+static const UCHAR SiS300_OEMLCDDelay4[12][4] =
 {
 	{0x2c,0x2c,0x2c,0x2c},
 	{0x20,0x20,0x20,0x20},
@@ -190,7 +190,7 @@
 };
 
 /* TW: From 300/301LV BIOS */
-const UCHAR SiS300_OEMLCDDelay5[32][4] =
+static const UCHAR SiS300_OEMLCDDelay5[32][4] =
 {
 	{0x20,0x20,0x20,0x20},
 	{0x20,0x20,0x20,0x20},
@@ -227,7 +227,7 @@
 };
 
 /* TW: Added for LVDS */
-const UCHAR SiS300_OEMLCDDelay3[64][4] = {	/* For LVDS */
+static const UCHAR SiS300_OEMLCDDelay3[64][4] = {	/* For LVDS */
 	{0x20,0x20,0x20,0x20},
 	{0x20,0x20,0x20,0x20},
 	{0x20,0x20,0x20,0x20},
@@ -294,7 +294,7 @@
 	{0x20,0x20,0x20,0x20}
 };
 
-const UCHAR SiS300_Phase1[8][5][4] =
+static const UCHAR SiS300_Phase1[8][5][4] =
 {
     {
 	{0x21,0xed,0x00,0x08},
@@ -355,7 +355,7 @@
 };
 
 
-const UCHAR SiS300_Phase2[8][5][4] =
+static const UCHAR SiS300_Phase2[8][5][4] =
 {
     {
         {0x21,0xed,0x00,0x08},
@@ -415,7 +415,7 @@
     }
 };
 
-const UCHAR SiS300_Filter1[10][16][4] =
+static const UCHAR SiS300_Filter1[10][16][4] =
 {
     {
 	{0x00,0xf4,0x10,0x38},
@@ -599,7 +599,7 @@
     },
 };
 
-const UCHAR SiS300_Filter2[10][9][7] =
+static const UCHAR SiS300_Filter2[10][9][7] =
 {
     {
 	{0xFF,0x03,0x02,0xF6,0xFC,0x27,0x46},
@@ -714,7 +714,7 @@
 };
 
 /* Custom data for Barco iQ Pro R300 */
-const UCHAR barco_p1[2][9][7][3] = {
+static const UCHAR barco_p1[2][9][7][3] = {
     {
 	{  { 0x16, 0xcf, 0x00 },
 	   { 0x18, 0x00, 0x00 },
--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/sis_main.h.old	2004-11-21 02:46:09.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/sis_main.h	2004-11-21 02:51:15.000000000 +0100
@@ -153,7 +153,7 @@
    now (hoping that nobody is crazy enough to run two
    SiS cards at the same time).
  */
-SIS_HEAP       	sisfb_heap;
+static	SIS_HEAP       	sisfb_heap;
 
 #define MD_SIS300 1
 #define MD_SIS315 2
@@ -336,19 +336,19 @@
 };
 
 /* CR36 evaluation */
-const USHORT sis300paneltype[] =
+static const USHORT sis300paneltype[] =
     { LCD_UNKNOWN,   LCD_800x600,   LCD_1024x768,  LCD_1280x1024,
       LCD_1280x960,  LCD_640x480,   LCD_1024x600,  LCD_1152x768,
       LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN,
       LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN };
 
-const USHORT sis310paneltype[] =
+static const USHORT sis310paneltype[] =
     { LCD_UNKNOWN,   LCD_800x600,   LCD_1024x768,  LCD_1280x1024,
       LCD_640x480,   LCD_1024x600,  LCD_1152x864,  LCD_1280x960,
       LCD_1152x768,  LCD_1400x1050, LCD_1280x768,  LCD_1600x1200,
       LCD_640x480_2, LCD_640x480_3, LCD_UNKNOWN,   LCD_UNKNOWN };
 
-const USHORT sis661paneltype[] =
+static const USHORT sis661paneltype[] =
     { LCD_UNKNOWN,   LCD_800x600,   LCD_1024x768,  LCD_1280x1024,
       LCD_640x480,   LCD_1024x600,  LCD_1152x864,  LCD_1280x960,
       LCD_1152x768,  LCD_1400x1050, LCD_1280x768,  LCD_1600x1200,
@@ -800,11 +800,11 @@
 
 /* Interface used by the world */
 #ifndef MODULE
-int             sisfb_setup(char *options);
+static int      sisfb_setup(char *options);
 #endif
 
 /* Interface to the low level console driver */
-int             sisfb_init(void);
+static int      sisfb_init(void);
 
 
 /* fbdev routines */
@@ -908,7 +908,6 @@
 static void     SiS_SenseCh(struct sis_video_info *ivideo);
 
 /* Routines from init.c/init301.c */
-extern USHORT   SiS_GetModeID(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay, int Depth, BOOLEAN FSTN);
 extern USHORT   SiS_GetModeID_LCD(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay, int Depth,
                                   BOOLEAN FSTN, USHORT CustomT, int LCDwith, int LCDheight);
 extern USHORT   SiS_GetModeID_TV(int VGAEngine, ULONG VBFlags, int HDisplay, int VDisplay, int Depth);
--- linux-2.6.10-rc2-mm2-full/drivers/video/sis/sis_main.c.old	2004-11-21 02:46:55.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sis/sis_main.c	2004-11-21 02:48:56.000000000 +0100
@@ -3840,7 +3840,7 @@
 }
 
 #ifndef MODULE
-int __init sisfb_setup(char *options)
+static int __init sisfb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -4736,7 +4736,7 @@
 #endif
 
 
-int __devinit sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct sisfb_chip_info 	*chipinfo = &sisfb_chip_info[ent->driver_data];
 	struct sis_video_info 	*ivideo = NULL;
@@ -5720,7 +5720,7 @@
 	.remove 	= __devexit_p(sisfb_remove)
 };
 
-int __init sisfb_init(void)
+static int __init sisfb_init(void)
 {
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
 #ifndef MODULE

