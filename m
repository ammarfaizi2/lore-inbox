Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVGIDLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVGIDLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 23:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVGIDJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 23:09:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36359 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263100AbVGIDHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 23:07:33 -0400
Date: Sat, 9 Jul 2005 05:07:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix IP_FIB_HASH kconfig warning
Message-ID: <20050709030730.GC28243@stusta.de>
References: <20050703222002.GQ5346@stusta.de> <Pine.LNX.4.61.0507042025180.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507042025180.3728@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 08:27:56PM +0200, Roman Zippel wrote:

>...
> config IP_FIB_HASH  
> 	def_bool ASK_IP_FIB_HASH || !IP_ADVANCED_ROUTER

An updated patch is below.

> bye, Roman

cu
Adrian


<--  snip  -->


This patch fixes the following kconfig warning:
  net/ipv4/Kconfig:92:warning: defaults for choice values not supported

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc2-mm1-modular/net/ipv4/Kconfig.old	2005-07-08 23:55:31.000000000 +0200
+++ linux-2.6.13-rc2-mm1-modular/net/ipv4/Kconfig	2005-07-08 23:56:23.000000000 +0200
@@ -56,9 +56,9 @@
 choice 
 	prompt "Choose IP: FIB lookup algorithm (choose FIB_HASH if unsure)"
 	depends on IP_ADVANCED_ROUTER
-	default IP_FIB_HASH
+	default ASK_IP_FIB_HASH
 
-config IP_FIB_HASH
+config ASK_IP_FIB_HASH
 	bool "FIB_HASH"
 	---help---
 	Current FIB is very proven and good enough for most users.
@@ -84,12 +84,8 @@
        
 endchoice
 
-# If the user does not enable advanced routing, he gets the safe
-# default of the fib-hash algorithm.
 config IP_FIB_HASH
-	bool
-	depends on !IP_ADVANCED_ROUTER
-	default y
+	def_bool ASK_IP_FIB_HASH || !IP_ADVANCED_ROUTER
 
 config IP_MULTIPLE_TABLES
 	bool "IP: policy routing"

