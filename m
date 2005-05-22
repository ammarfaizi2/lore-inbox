Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVEVX5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVEVX5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 19:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEVXy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 19:54:59 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:34436 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261832AbVEVXye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 19:54:34 -0400
Message-Id: <20050522235336.590432000@abc>
References: <20050522235233.190143000@abc>
Date: Mon, 23 May 2005 01:52:37 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       Domen Puncer <domen@coderock.org>
Content-Disposition: inline; filename=dvb-frontend-use-timer_after.patch
X-SA-Exim-Connect-IP: 84.189.216.198
Subject: [DVB patch 4/5] dvb_frontend: use time_after()
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use time_after() macro.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---
 drivers/media/dvb/dvb-core/dvb_frontend.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4-git3/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.12-rc4-git3.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-05-19 22:52:12.000000000 +0200
+++ linux-2.6.12-rc4-git3/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-05-23 00:57:16.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/moduleparam.h>
 #include <linux/list.h>
 #include <linux/suspend.h>
+#include <linux/jiffies.h>
 #include <asm/processor.h>
 #include <asm/semaphore.h>
 
@@ -327,7 +328,8 @@ static int dvb_frontend_is_exiting(struc
 		return 1;
 
 	if (fepriv->dvbdev->writers == 1)
-		if (jiffies - fepriv->release_jiffies > dvb_shutdown_timeout * HZ)
+		if (time_after(jiffies, fepriv->release_jiffies +
+					dvb_shutdown_timeout * HZ))
 			return 1;
 
 	return 0;

--

