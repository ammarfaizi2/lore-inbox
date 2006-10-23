Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWJWWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWJWWnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWJWWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:43:49 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:17297 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1750956AbWJWWns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:43:48 -0400
Date: Mon, 23 Oct 2006 15:43:46 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: thomas@winischhofer.net
cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] video SiS: remove unnecessary variables in SiS_DDC2Delay
Message-ID: <Pine.LNX.4.64N.0610231542130.5012@attu3.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecesary iteration and accumulator variables from SiS_DDC2Delay.

Originally spotted by Jesper Juhl <jesper.juhl@gmail.com>.

Cc: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 drivers/video/sis/init301.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
index f13fadd..47e1896 100644
--- a/drivers/video/sis/init301.c
+++ b/drivers/video/sis/init301.c
@@ -445,11 +445,8 @@ #endif
 void
 SiS_DDC2Delay(struct SiS_Private *SiS_Pr, unsigned int delaytime)
 {
-   unsigned int i, j;
-
-   for(i = 0; i < delaytime; i++) {
-      j += SiS_GetReg(SiS_Pr->SiS_P3c4,0x05);
-   }
+   while (delaytime-- > 0)
+      SiS_GetReg(SiS_Pr->SiS_P3c4, 0x05);
 }
 
 #if defined(SIS300) || defined(SIS315H)
