Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTKXG5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 01:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTKXG5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 01:57:32 -0500
Received: from CPE-144-132-198-235.nsw.bigpond.net.au ([144.132.198.235]:25734
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id S263592AbTKXG5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 01:57:30 -0500
Date: Mon, 24 Nov 2003 14:41:20 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] sis comparison / assignment operator fix
Message-ID: <20031124064120.GA13435@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi,


This fixes what seems to be an obvious = vs == bug in the init301.c
sis file.

It has 

if (temp = 0xffff) return;

which should always be true, so it always returns.

	- g.
-- 
geoff.

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="sis-init301.c.patch"

--- linux-2.6.0-test10/drivers/video/sis/init301.c.orig	2003-11-24 14:36:57.000000000 +0800
+++ linux-2.6.0-test10/drivers/video/sis/init301.c	2003-11-24 14:37:59.000000000 +0800
@@ -11712,7 +11712,7 @@ SetOEMLCDData(SiS_Private *SiS_Pr, PSIS_
   }
 
   temp = GetOEMLCDPtr(SiS_Pr,HwDeviceExtension, ROMAddr, 1);
-  if(temp = 0xFFFF) return;
+  if(temp == 0xFFFF) return;
 
   index = SiS_Pr->SiS_VBModeIDTable[ModeIdIndex]._VB_LCDHIndex;
   for(i=0x14, j=0; i<=0x17; i++, j++) {

--ikeVEW9yuYc//A+q--
