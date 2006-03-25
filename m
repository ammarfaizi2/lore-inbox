Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWCYTrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWCYTrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWCYTrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:47:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33040 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751105AbWCYTrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:47:31 -0500
Date: Sat, 25 Mar 2006 20:47:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: thomas@winischhofer.net, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] video/sis/init301.c:SiS_ChrontelDoSomething2(): remove dead code
Message-ID: <20060325194729.GR4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted these two unused variables.

Please check whether this patch is correct or whether they should be 
used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Mar 2006

 drivers/video/sis/init301.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- linux-2.6.16-rc5-mm3-full/drivers/video/sis/init301.c.old	2006-03-09 23:39:56.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/video/sis/init301.c	2006-03-09 23:40:48.000000000 +0100
@@ -8560,39 +8560,30 @@
 
      }
 }
 
 static void
 SiS_ChrontelDoSomething2(struct SiS_Private *SiS_Pr)
 {
-     unsigned short temp,tempcl,tempch;
+     unsigned short temp;
 
      SiS_LongDelay(SiS_Pr, 1);
-     tempcl = 3;
-     tempch = 0;
 
      do {
        temp = SiS_GetCH701x(SiS_Pr,0x66);
        temp &= 0x04;  /* PLL stable? -> bail out */
        if(temp == 0x04) break;
 
        if(SiS_Pr->ChipType == SIS_740) {
           /* Power down LVDS output, PLL normal operation */
           SiS_SetCH701x(SiS_Pr,0x76,0xac);
        }
 
        SiS_SetCH701xForLCD(SiS_Pr);
 
-       if(tempcl == 0) {
-           if(tempch == 3) break;
-	   SiS_ChrontelResetDB(SiS_Pr);
-	   tempcl = 3;
-	   tempch++;
-       }
-       tempcl--;
        temp = SiS_GetCH701x(SiS_Pr,0x76);
        temp &= 0xfb;  /* Reset PLL */
        SiS_SetCH701x(SiS_Pr,0x76,temp);
        SiS_LongDelay(SiS_Pr, 2);
        temp = SiS_GetCH701x(SiS_Pr,0x76);
        temp |= 0x04;  /* PLL normal operation */
        SiS_SetCH701x(SiS_Pr,0x76,temp);

