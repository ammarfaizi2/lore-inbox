Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSE0Ccu>; Sun, 26 May 2002 22:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316495AbSE0Cct>; Sun, 26 May 2002 22:32:49 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:35600 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316492AbSE0Cct>;
	Sun, 26 May 2002 22:32:49 -0400
Date: Sun, 26 May 2002 22:14:58 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.18: net/ipv4/ipconfig.c minor fix
Message-ID: <Pine.LNX.4.33.0205262210050.18267-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    The following patch fixes two compile warnings 'defined but not used'. 
Since the label and int are only used for IPCONFIG_DYNAMIC, appropriate 
fixes were made to remove the warnings.

Regards,
Frank

--- net/ipv4/ipconfig.c.old	Sun May 26 21:39:52 2002
+++ net/ipv4/ipconfig.c	Sun May 26 21:40:01 2002
@@ -1110,7 +1110,6 @@
 
 static int __init ip_auto_config(void)
 {
-	int retries = CONF_OPEN_RETRIES;
 	unsigned long jiff;
 
 #ifdef CONFIG_PROC_FS
@@ -1121,8 +1120,9 @@
 		return 0;
 
 	DBG(("IP-Config: Entered.\n"));
-
+#ifdef IPCONFIG_DYNAMIC
  try_try_again:
+#endif
 	/* Give hardware a chance to settle */
 	jiff = jiffies + CONF_PRE_OPEN;
 	while (time_before(jiffies, jiff))
@@ -1151,6 +1151,8 @@
 #endif
 	    ic_first_dev->next) {
 #ifdef IPCONFIG_DYNAMIC
+	
+		int retries = CONF_OPEN_RETRIES;
 
 		if (ic_dynamic() < 0) {
 			ic_close_devs();

