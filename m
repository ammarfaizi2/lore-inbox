Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265883AbSKBGon>; Sat, 2 Nov 2002 01:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKBGon>; Sat, 2 Nov 2002 01:44:43 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:44188 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265883AbSKBGom>; Sat, 2 Nov 2002 01:44:42 -0500
Date: Sat, 2 Nov 2002 02:43:23 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.45 : net/ipv4/ipconfig.c
Message-ID: <Pine.LNX.4.44.0211020240540.856-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch moves a variable to a place prior to a label (no 
reinitialization). Please review.

Regards,
Frank

--- linux/net/ipv4/ipconfig.c.old	Sat Oct 19 12:08:27 2002
+++ linux/net/ipv4/ipconfig.c	Fri Nov  1 22:02:27 2002
@@ -1144,6 +1144,7 @@
 
 	DBG(("IP-Config: Entered.\n"));
 #ifdef IPCONFIG_DYNAMIC
+ int retries = CONF_OPEN_RETRIES;
  try_try_again:
 #endif
 	/* Give hardware a chance to settle */
@@ -1175,8 +1176,6 @@
 	    ic_first_dev->next) {
 #ifdef IPCONFIG_DYNAMIC
 	
-		int retries = CONF_OPEN_RETRIES;
-
 		if (ic_dynamic() < 0) {
 			ic_close_devs();
 

