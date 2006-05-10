Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWEJC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWEJC4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWEJC4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:36 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51261 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932425AbWEJC4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:21 -0400
Date: Tue, 9 May 2006 19:56:05 -0700
Message-Id: <200605100256.k4A2u56F031749@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] riva CalcStateExt gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could be a bug. The return from CalcVClock isn't checked
so the variables in questions could be random data ..

Fixes the following warning,

drivers/video/riva/riva_hw.c: In function 'CalcStateExt':
drivers/video/riva/riva_hw.c:1241: warning: 'p' may be used uninitialized in this function
drivers/video/riva/riva_hw.c:1241: warning: 'n' may be used uninitialized in this function
drivers/video/riva/riva_hw.c:1241: warning: 'm' may be used uninitialized in this function
drivers/video/riva/riva_hw.c:1241: warning: 'VClk' may be used uninitialized in this function


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/video/riva/riva_hw.c
===================================================================
--- linux-2.6.16.orig/drivers/video/riva/riva_hw.c
+++ linux-2.6.16/drivers/video/riva/riva_hw.c
@@ -1238,7 +1238,12 @@ static void CalcStateExt
     int            dotClock
 )
 {
-    int pixelDepth, VClk, m, n, p;
+    int pixelDepth;
+    int VClk = 0;
+    int m = 0;
+    int n = 0;
+    int p = 0;
+
     /*
      * Save mode parameters.
      */
