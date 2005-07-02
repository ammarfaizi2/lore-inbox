Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVGBVt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVGBVt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVGBVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:49:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3850 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261297AbVGBVsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:48:39 -0400
Date: Sat, 2 Jul 2005 23:48:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: [2.6 patch]
Message-ID: <20050702214836.GD5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following kconfig warning:
  net/ipv4/Kconfig:92:warning: defaults for choice values not supported

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

I've Cc'ed Roman because I might have missed a more elegant solution.

--- linux-2.6.13-rc1-mm1-full/net/ipv4/Kconfig.old	2005-07-02 20:07:25.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/net/ipv4/Kconfig	2005-07-02 20:13:05.000000000 +0200
@@ -58,8 +58,9 @@
 	depends on IP_ADVANCED_ROUTER
 	default IP_FIB_HASH
 
-config IP_FIB_HASH
+config ASK_IP_FIB_HASH
 	bool "FIB_HASH"
+	select IP_FIB_HASH
 	---help---
 	Current FIB is very proven and good enough for most users.
 
@@ -84,12 +85,9 @@
        
 endchoice
 
-# If the user does not enable advanced routing, he gets the safe
-# default of the fib-hash algorithm.
 config IP_FIB_HASH
 	bool
-	depends on !IP_ADVANCED_ROUTER
-	default y
+	default y if !IP_ADVANCED_ROUTER
 
 config IP_MULTIPLE_TABLES
 	bool "IP: policy routing"
