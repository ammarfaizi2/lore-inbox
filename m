Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVIFA4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVIFA4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 20:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVIFA4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 20:56:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31181 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965022AbVIFA4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 20:56:46 -0400
Date: Tue, 6 Sep 2005 01:56:45 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig fix (GEN_RTC dependencies)
Message-ID: <20050906005645.GQ5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Yet another architecture not coverd by GEN_RTC - sparc64 never
picked it until now and it doesn't have asm/rtc.h to go with it, so
it wouldn't compile anyway (or have these ioctls in the user-visible
headers, for that matter).

	FWIW, I'm very tempted to introduce ARCH_HAS_GEN_RTC and have
it set in arch/*/Kconfig for architectures that know what to do with this
stuff - for something supposedly generic the list of architectures where
it doesn't work is getting too long...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-serial/drivers/char/Kconfig RC13-git5-genrtc/drivers/char/Kconfig
--- RC13-git5-serial/drivers/char/Kconfig	2005-09-05 16:41:18.000000000 -0400
+++ RC13-git5-genrtc/drivers/char/Kconfig	2005-09-05 16:41:19.000000000 -0400
@@ -736,7 +736,7 @@
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !PPC64 && !M32R && !SPARC32
+	depends on RTC!=y && !IA64 && !ARM && !PPC64 && !M32R && !SPARC32 && !SPARC64
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
