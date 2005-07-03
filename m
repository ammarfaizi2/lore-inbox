Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVGCWUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVGCWUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVGCWUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 18:20:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36868 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261552AbVGCWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 18:20:05 -0400
Date: Mon, 4 Jul 2005 00:20:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: [2.6 patch] fix IP_FIB_HASH kconfig warning
Message-ID: <20050703222002.GQ5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This time with a subject... ]

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
